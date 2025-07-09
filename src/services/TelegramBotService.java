package services;

import bot.ResponTopikService;
import models.Keyword;
import org.telegram.telegrambots.bots.TelegramLongPollingBot;
import org.telegram.telegrambots.meta.api.methods.send.SendMessage;
import org.telegram.telegrambots.meta.api.objects.Update;
import org.telegram.telegrambots.meta.exceptions.TelegramApiException;
import org.telegram.telegrambots.meta.TelegramBotsApi;
import org.telegram.telegrambots.updatesreceivers.DefaultBotSession;

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class TelegramBotService extends TelegramLongPollingBot {
    private static final Logger LOGGER = Logger.getLogger(TelegramBotService.class.getName());

    private final String botToken;
    private final String botUsername;
    private final DatabaseService databaseService;

    // Simple in-memory map to track registration state
    private final java.util.Map<String, Boolean> registrationInProgress = new java.util.concurrent.ConcurrentHashMap<>();

    public TelegramBotService(String botToken, String botUsername, DatabaseService databaseService) {
        this.botToken = botToken;
        this.botUsername = botUsername;
        this.databaseService = databaseService;
    }

    @Override
    public String getBotUsername() {
        return botUsername;
    }

    @Override
    public String getBotToken() {
        return botToken;
    }

    @Override
    public void onUpdateReceived(Update update) {
        if (update.hasMessage() && update.getMessage().hasText()) {
            String chatId = update.getMessage().getChatId().toString();
            String userText = update.getMessage().getText();
            String telegramUsername = update.getMessage().getFrom().getUserName();
            if (telegramUsername == null || telegramUsername.isEmpty()) {
                telegramUsername = update.getMessage().getFrom().getFirstName();
                if (update.getMessage().getFrom().getLastName() != null) {
                    telegramUsername += " " + update.getMessage().getFrom().getLastName();
                }
                if (telegramUsername.trim().isEmpty()) {
                    telegramUsername = "User_" + update.getMessage().getFrom().getId();
                }
            }

            LOGGER.log(Level.INFO, "Pesan diterima dari " + telegramUsername + " (Chat ID: " + chatId + "): " + userText);

            try {
                boolean isAlreadyMember = db.DBConnection.isMember(chatId);
                String userStatus = "unv";
                try {
                    models.Member member = databaseService.getMemberByChatID(chatId);
                    if (member != null) {
                        userStatus = member.getStatus();
                    }
                } catch (Exception e) {
                    LOGGER.log(Level.WARNING, "Gagal mendapatkan status member: " + e.getMessage());
                }

                if (!isAlreadyMember) {
                    try (java.sql.Connection conn = db.DBConnection.getConnection()) {
                        String sqlInsert = "INSERT INTO users (telegram_id, username, status) VALUES (?, ?, 'unv')";
                        java.sql.PreparedStatement psInsert = conn.prepareStatement(sqlInsert);
                        psInsert.setString(1, chatId);
                        psInsert.setString(2, telegramUsername);
                        psInsert.executeUpdate();
                        LOGGER.log(Level.INFO, "Pengguna baru terdaftar otomatis: " + telegramUsername + " (Chat ID: " + chatId + ")");
                    } catch (Exception e) {
                        LOGGER.log(Level.SEVERE, "Gagal mendaftarkan pengguna otomatis (Chat ID: " + chatId + ")", e);
                    }
                    sendMessage(chatId, "Halo " + telegramUsername + "! Selamat datang! Untuk mengakses fitur, silakan daftar terlebih dahulu dengan mengirim perintah /daftar.");
                    return;
                }

                if (userStatus.equals("unv") || userStatus.equals("pending")) {
                    if (!userText.equalsIgnoreCase("/daftar")) {
                        sendMessage(chatId, "Anda belum terverifikasi. Silakan kirim perintah /daftar untuk memulai proses pendaftaran.");
                        return;
                    } else {
                        // Start registration process: ask for phone number
                        sendMessage(chatId, "Silakan kirim nomor HP Anda untuk pendaftaran.");
                        // Save state that user is in registration process
                        registrationInProgress.put(chatId, true);
                        return;
                    }
                }

                if (registrationInProgress.containsKey(chatId) && registrationInProgress.get(chatId)) {
                    // Assume userText is phone number
                    String phoneNumber = userText.trim();
                    try {
                        databaseService.updateMemberStatus(chatId, "pending");
                        // Update phone number as well
                        models.Member member = databaseService.getMemberByChatID(chatId);
                        if (member != null) {
                            member.setNomorHP(phoneNumber);
                            databaseService.updateMember(chatId, member);
                        }
                        sendMessage(chatId, "Terima kasih! Data Anda telah diterima dan menunggu persetujuan admin.");
                        // Notify admin (replace ADMIN_CHAT_ID with actual chat id)
                        String adminChatId = "ADMIN_CHAT_ID";
                        sendMessage(adminChatId, "User baru menunggu verifikasi:\nUsername: " + telegramUsername + "\nChat ID: " + chatId + "\nNomor HP: " + phoneNumber + "\nGunakan MemberForm untuk approve/reject.");
                        registrationInProgress.remove(chatId);
                    } catch (Exception e) {
                        LOGGER.log(Level.SEVERE, "Gagal menyimpan data pendaftaran: " + e.getMessage());
                        sendMessage(chatId, "Maaf, terjadi kesalahan saat menyimpan data Anda. Silakan coba lagi.");
                    }
                    return;
                }

                db.DBConnection.saveIncoming(chatId, userText);

                // Additional message handling logic can be added here

            } catch (Exception e) {
                LOGGER.log(Level.SEVERE, "Error processing update: " + e.getMessage(), e);
            }
        }
    }

    public void sendMessage(String chatId, String text) {
        SendMessage message = new SendMessage();
        message.setChatId(chatId);
        message.setText(text);
        try {
            LOGGER.log(Level.INFO, "Mengirim pesan ke " + chatId + ": " + text);
            execute(message);
            LOGGER.log(Level.INFO, "Pesan terkirim ke " + chatId + ": " + text);
        } catch (TelegramApiException e) {
            LOGGER.log(Level.SEVERE, "Gagal mengirim pesan ke " + chatId + ": " + e.getMessage(), e);
            e.printStackTrace();
        }
    }

    public void broadcastMessage(java.util.List<String> userIds, String text) {
        LOGGER.log(Level.INFO, "Memulai broadcast ke " + userIds.size() + " user.");
        for (String userId : userIds) {
            LOGGER.log(Level.INFO, "Mengirim pesan ke user: " + userId);
            sendMessage(userId, text);
        }
        LOGGER.log(Level.INFO, "Broadcast selesai.");
    }

    public void startBot() {
        try {
            clearWebhook();
            TelegramBotsApi botsApi = new TelegramBotsApi(DefaultBotSession.class);
            botsApi.registerBot(this);
            LOGGER.log(Level.INFO, "✅ Bot Telegram '" + botUsername + "' telah berhasil dimulai!");
        } catch (TelegramApiException e) {
            LOGGER.log(Level.SEVERE, "Gagal memulai Telegram Bot: " + e.getMessage(), e);
            javax.swing.JOptionPane.showMessageDialog(null,
                    "Gagal memulai bot Telegram: " + e.getMessage() + "\n" +
                    "Pastikan token dan username bot benar serta koneksi internet stabil.",
                    "Bot Startup Error", javax.swing.JOptionPane.ERROR_MESSAGE);
        }
    }

    public void clearWebhook() {
        boolean result = false;
        try {
            result = this.deleteWebhook();
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Gagal menghapus webhook lama: " + e.getMessage(), e);
        }
        if (result) {
            LOGGER.log(Level.INFO, "Webhook lama berhasil dihapus.");
        } else {
            LOGGER.log(Level.WARNING, "Webhook lama gagal dihapus atau tidak ada webhook yang aktif.");
        }
    }

    public void stopBot() {
        LOGGER.log(Level.INFO, "⛔ Bot Telegram dihentikan.");
    }

    private boolean deleteWebhook() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
