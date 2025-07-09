package telegrambot;

import org.telegram.telegrambots.bots.TelegramLongPollingBot;
import org.telegram.telegrambots.meta.TelegramBotsApi;
import org.telegram.telegrambots.meta.api.methods.send.SendMessage;
import org.telegram.telegrambots.meta.api.objects.replykeyboard.ReplyKeyboardMarkup;
import org.telegram.telegrambots.meta.api.objects.replykeyboard.buttons.KeyboardButton;
import org.telegram.telegrambots.meta.api.objects.replykeyboard.buttons.KeyboardRow;
import org.telegram.telegrambots.meta.api.objects.Update;
import org.telegram.telegrambots.meta.api.objects.Message;
import org.telegram.telegrambots.updatesreceivers.DefaultBotSession;

import java.sql.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

import java.io.File;
import java.io.IOException;
import java.nio.channels.FileChannel;
import java.nio.channels.FileLock;

public class TelegramBot extends TelegramLongPollingBot {

    private static TelegramBot instance;
    private static FileLock lock;
    private static FileChannel lockChannel;
    private static final String LOCK_FILE_PATH = "bot.lock";

    private static volatile boolean started = false;

    private ConcurrentMap<Long, Boolean> searchModeUsers = new ConcurrentHashMap<>();

    private ConcurrentMap<Long, String> recommendationState = new ConcurrentHashMap<>();
    private ConcurrentMap<Long, List<bot.IndonesianFoodLoader.Food>> recommendationList = new ConcurrentHashMap<>();

    private final services.DatabaseService databaseService = new services.DatabaseServiceImpl();

    private TelegramBot() {
        // private constructor to prevent multiple instances
    }

    public static synchronized TelegramBot getInstance() {
        if (instance == null) {
            instance = new TelegramBot();
        }
        return instance;
    }

    private static boolean acquireLock() {
        try {
            File lockFile = new File(LOCK_FILE_PATH);
            if (lockFile.exists()) {
                // Try to delete stale lock file before acquiring lock
                if (!lockFile.delete()) {
                    System.err.println("Failed to delete stale lock file: " + LOCK_FILE_PATH);
                    // Check if the lock file is actually locked by another process
                    try (java.io.RandomAccessFile raf = new java.io.RandomAccessFile(lockFile, "rw");
                         FileChannel channel = raf.getChannel()) {
                        FileLock testLock = channel.tryLock();
                        if (testLock == null) {
                            // Lock is held by another process, so return false
                            System.err.println("Lock file is currently held by another process.");
                            return false;
                        } else {
                            // Lock is not held, release test lock and delete file forcibly
                            testLock.release();
                            channel.close();
                            if (lockFile.delete()) {
                                System.out.println("Deleted stale lock file after confirming no lock held: " + LOCK_FILE_PATH);
                            } else {
                                System.err.println("Failed to delete stale lock file after confirming no lock held: " + LOCK_FILE_PATH);
                                return false;
                            }
                        }
                    } catch (IOException ex) {
                        System.err.println("Error while checking lock file status: " + ex.getMessage());
                        return false;
                    }
                } else {
                    System.out.println("Deleted stale lock file: " + LOCK_FILE_PATH);
                }
            }
            lockChannel = new java.io.RandomAccessFile(lockFile, "rw").getChannel();
            lock = lockChannel.tryLock();
            if (lock == null) {
                return false;
            }
            // Add shutdown hook to release lock on exit
            Runtime.getRuntime().addShutdownHook(new Thread(() -> {
                try {
                    lock.release();
                    lockChannel.close();
                    lockFile.delete();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }));
            return true;
        } catch (IOException e) {
            System.err.println("Error acquiring lock: " + e.getMessage());
            return false;
        }
    }

    private void notifyAdminsForApproval(long userChatId, String username, String phoneNumber) {
        // List of admin chat IDs - replace with actual admin IDs
        long[] adminChatIds = {507170232L}; // TODO: update with real admin chat IDs

        String message = "User baru mendaftar:\n" +
                "Username: @" + username + "\n" +
                "Telegram ID: " + userChatId + "\n" +
                "Nomor Telepon: " + phoneNumber + "\n\n" +
                "Ketik /approve " + userChatId + " untuk menyetujui atau /reject " + userChatId + " untuk menolak.";

        for (long adminId : adminChatIds) {
            sendText(adminId, message);
        }
        // Notify MemberForm to refresh member list
        try {
            Class<?> memberFormClass = Class.forName("ui.MemberForm");
            java.lang.reflect.Method refreshMethod = memberFormClass.getMethod("refreshMemberList");
            refreshMethod.invoke(null);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void handleAdminCommand(long chatId, String text) throws Exception {
        if (text.startsWith("/approve ")) {
            String[] parts = text.split(" ");
            if (parts.length == 2) {
                long userIdToApprove = Long.parseLong(parts[1]);
                databaseService.updateMemberStatus(String.valueOf(userIdToApprove), "verified");
                sendText(chatId, "User dengan ID " + userIdToApprove + " telah disetujui.");
                sendText(userIdToApprove, "Selamat! Akun Anda telah diverifikasi oleh admin. Anda sekarang dapat mengakses semua fitur.");
            }
        } else if (text.startsWith("/reject ")) {
            String[] parts = text.split(" ");
            if (parts.length == 2) {
                long userIdToReject = Long.parseLong(parts[1]);
                databaseService.updateMemberStatus(String.valueOf(userIdToReject), "blocked");
                sendText(chatId, "User dengan ID " + userIdToReject + " telah ditolak.");
                sendText(userIdToReject, "Maaf, akun Anda tidak disetujui oleh admin. Silakan hubungi admin untuk informasi lebih lanjut.");
            }
        }
    }

    private List<bot.IndonesianFoodLoader.Food> getRecipesByCategory(String category) {
        List<bot.IndonesianFoodLoader.Food> recipes = new ArrayList<>();
        String resourcePath = "";
        switch (category) {
            case "pedas":
                resourcePath = "dataset/pedas.json";
                break;
            case "sehat":
                resourcePath = "dataset/sehat.json";
                break;
            case "cheesy":
                resourcePath = "dataset/cheesy.json";
                break;
            case "manis":
                resourcePath = "dataset/manis.json";
                break;
            default:
                return recipes;
        }
        try (java.io.InputStream is = getClass().getClassLoader().getResourceAsStream(resourcePath)) {
            if (is == null) {
                System.err.println("Resource not found: " + resourcePath);
                return recipes;
            }
            java.io.InputStreamReader reader = new java.io.InputStreamReader(is);
            com.google.gson.Gson gson = new com.google.gson.Gson();
            bot.IndonesianFoodLoader.Food[] foods = gson.fromJson(reader, bot.IndonesianFoodLoader.Food[].class);
            recipes = java.util.Arrays.asList(foods);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return recipes;
    }

    private List<bot.IndonesianFoodLoader.Food> getRecipesByIngredients(String ingredients) {
        List<bot.IndonesianFoodLoader.Food> recipes = new ArrayList<>();
        try {
            java.nio.file.Path path = java.nio.file.Paths.get("dataset/Indonesian_Food.json");
            String json = new String(java.nio.file.Files.readAllBytes(path));
            com.google.gson.Gson gson = new com.google.gson.Gson();
            bot.IndonesianFoodLoader.Food[] foods = gson.fromJson(json, bot.IndonesianFoodLoader.Food[].class);
            List<String> ingredientList = new ArrayList<>();
            for (String ing : ingredients.toLowerCase().split(",")) {
                ingredientList.add(ing.trim());
            }
            for (bot.IndonesianFoodLoader.Food food : foods) {
                String foodIngredients = food.ingredients.toLowerCase();
                boolean allMatch = true;
                for (String ing : ingredientList) {
                    if (!foodIngredients.contains(ing)) {
                        allMatch = false;
                        break;
                    }
                }
                if (allMatch) {
                    recipes.add(food);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return recipes;
    }

    private List<bot.IndonesianFoodLoader.Food> getRecipesByTitle(String title) {
        List<bot.IndonesianFoodLoader.Food> recipes = new ArrayList<>();
        try {
            java.nio.file.Path path = java.nio.file.Paths.get("dataset/Indonesian_Food.json");
            String json = new String(java.nio.file.Files.readAllBytes(path));
            com.google.gson.Gson gson = new com.google.gson.Gson();
            bot.IndonesianFoodLoader.Food[] foods = gson.fromJson(json, bot.IndonesianFoodLoader.Food[].class);
            // Normalize input title: replace hyphens with spaces and trim
            String normalizedInput = title.toLowerCase().replace("-", " ").trim().replaceAll("\\s+", " ");
            for (bot.IndonesianFoodLoader.Food food : foods) {
                if (food.title != null) {
                    // Normalize food title similarly
                    String normalizedFoodTitle = food.title.toLowerCase().replace("-", " ").trim().replaceAll("\\s+", " ");
                    if (normalizedFoodTitle.contains(normalizedInput)) {
                        recipes.add(food);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return recipes;
    }

    @Override
    public void onUpdateReceived(Update update) {
        try {
            if (update.hasMessage()) {
                Message msg = update.getMessage();
                long chatId = msg.getChatId();
                String username = msg.getFrom().getUserName();

                try (Connection conn = db.DBConnection.getConnection()) {
                    int userId;
                    boolean isNew = false;
                    String userStatus = "unv";

                    if (msg.hasContact()) {
                        String phoneNumber = msg.getContact().getPhoneNumber();
                        PreparedStatement updatePhone = conn.prepareStatement("UPDATE users SET phone = ?, status = ? WHERE telegram_id = ?");
                        updatePhone.setString(1, phoneNumber);
                        String pendingStatus = "pending";
                        if (pendingStatus.length() > 10) {
                            pendingStatus = pendingStatus.substring(0, 10);
                        }
                        updatePhone.setString(2, pendingStatus);
                        updatePhone.setLong(3, chatId);
                        updatePhone.executeUpdate();

                        sendText(chatId, "Terima kasih telah membagikan nomor telepon Anda: " + phoneNumber + "\nData Anda akan segera diverifikasi oleh admin.");
                        notifyAdminsForApproval(chatId, username, phoneNumber);
                        return;
                    }

                    if (msg.hasText()) {
                        String text = msg.getText();

                        PreparedStatement check = conn.prepareStatement("SELECT id, status FROM users WHERE telegram_id = ?");
                        check.setLong(1, chatId);
                        ResultSet rs = check.executeQuery();

                        if (!rs.next()) {
                            PreparedStatement insert = conn.prepareStatement("INSERT INTO users (telegram_id, username, status) VALUES (?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
                            insert.setLong(1, chatId);
                            insert.setString(2, username);
                            String statusValue = "unv";
                            if (statusValue.length() > 10) {
                                statusValue = statusValue.substring(0, 10);
                            }
                            insert.setString(3, statusValue);
                            insert.executeUpdate();
                            ResultSet keys = insert.getGeneratedKeys();
                            keys.next();
                            userId = keys.getInt(1);
                            userStatus = "unv";
                            isNew = true;
                        } else {
                            userId = rs.getInt("id");
                            userStatus = rs.getString("status");
                        }

                        if (text.startsWith("/approve ") || text.startsWith("/reject ")) {
                            handleAdminCommand(chatId, text);
                            return;
                        }

                        if (userStatus.equals("unv") || userStatus.equals("pending")) {
                            if (!text.equalsIgnoreCase("/daftar")) {
                                sendText(chatId, "Anda belum terverifikasi. Silakan ketik /daftar untuk memulai proses pendaftaran.");
                                return;
                            }
                        }

                        logMessage(conn, userId, "in", text);

                        if (isNew) {
                            String welcome = "Halo @" + username + "! Selamat datang di *Bot Makanan Trending*! 🍽️\n\n" +
                                    "Untuk mengakses semua fitur, silakan lakukan verifikasi dengan mengetik perintah /daftar.";
                            sendText(chatId, welcome);
                            logMessage(conn, userId, "out", welcome);
                            return;
                        }

                        if (text.equalsIgnoreCase("/daftar")) {
                            sendText(chatId, "Silakan kirim nomor telepon Anda dengan menggunakan fitur share contact di Telegram.");
                            return;
                        }

                        if (userStatus.equals("verified")) {
                            if (text.equalsIgnoreCase("/start")) {
                                String welcome = "Halo @" + username + "! Selamat datang di *Bot Makanan Trending*! 🍽️";
                                sendText(chatId, welcome);
                                logMessage(conn, userId, "out", welcome);

                                String prompt = "Silahkan klik menu di bawah ini untuk memilih opsi yang tersedia.";
                                sendTextWithKeyboard(chatId, prompt, true);
                                logMessage(conn, userId, "out", prompt);
                                return;
                            }

                            switch (text) {
                                case "Makanan Trending":
                                    try {
                                        bot.ResponTopikService.reloadFoodList();
                                        List<bot.IndonesianFoodLoader.Food> trendingFoodsList = bot.ResponTopikService.getTrendingFoodsList();
                                        StringBuilder sb = new StringBuilder();
                                        sb.append("🔥 *MAKANAN TRENDING BULAN INI* 🔥\n\n");
                                        for (int i = 0; i < Math.min(7, trendingFoodsList.size()); i++) {
                                            sb.append(i + 1).append(". ").append(trendingFoodsList.get(i).title).append("\n");
                                        }
                                        sb.append("\nKetik nomor untuk melihat detail resep!");
                                        sendTextWithKeyboard(chatId, sb.toString(), true);
                                        logMessage(conn, userId, "out", sb.toString());
                                        recommendationList.put(chatId, trendingFoodsList);
                                        recommendationState.put(chatId, "awaiting_recipe_number");
                                    } catch (Exception e) {
                                        String errorMsg = "Maaf, terjadi kesalahan saat mengambil data makanan trending.";
                                        sendText(chatId, errorMsg);
                                        logMessage(conn, userId, "out", errorMsg);
                                    }
                                    return;
                                case "Tips Masak":
                                    try {
                                        String tipText = databaseService.getRandomTip();
                                        String response = String.format(
                                                "👩‍🍳 *Tips Masak Hari Ini!* 🧂\n\n" +
                                                        "🔸 _%s_\n\n" +
                                                        "Coba praktikkan hari ini, ya! 😋\n" +
                                                        "Ingin tips lain? Ketik *tips* atau klik tombol \"Tips Masak\".",
                                                tipText
                                        );
                                        sendTextWithKeyboard(chatId, response, true);
                                        logMessage(conn, userId, "out", response);
                                    } catch (Exception e) {
                                        String errorMsg = "Maaf, terjadi kesalahan saat mengambil tips masak.";
                                        sendText(chatId, errorMsg);
                                        logMessage(conn, userId, "out", errorMsg);
                                    }
                                    return;
                                case "Cari Makanan":
                                    searchModeUsers.put(chatId, true);
                                    String prompt = "Silahkan ketik nama makanan yang ingin Anda cari";
                                    sendText(chatId, prompt);
                                    logMessage(conn, userId, "out", prompt);
                                    return;
                                case "Rekomendasi Hari Ini":
                                    ReplyKeyboardMarkup keyboardMarkup = new ReplyKeyboardMarkup();
                                    keyboardMarkup.setResizeKeyboard(true);
                                    List<KeyboardRow> keyboard = new ArrayList<>();

                                    KeyboardRow row1 = new KeyboardRow();
                                    row1.add(new KeyboardButton("🔥 Pedas"));
                                    row1.add(new KeyboardButton("🥗 Sehat"));
                                    row1.add(new KeyboardButton("🧀 Cheesy"));

                                    KeyboardRow row2 = new KeyboardRow();
                                    row2.add(new KeyboardButton("🍣 manis"));
                                    row2.add(new KeyboardButton("🥕 Pake bahan yang ada"));

                                    keyboard.add(row1);
                                    keyboard.add(row2);

                                    keyboardMarkup.setKeyboard(keyboard);

                                    SendMessage message = new SendMessage();
                                    message.setChatId(String.valueOf(chatId));
                                    message.setText("Lagi mau masak yang gimana?");
                                    message.setReplyMarkup(keyboardMarkup);

                                    try {
                                        execute(message);
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    }

                                    recommendationState.put(chatId, "awaiting_category");
                                    logMessage(conn, userId, "out", "Lagi mau masak yang gimana?");
                                    return;
                                default:
                                    if (searchModeUsers.getOrDefault(chatId, false)) {
                                        try {
                                            List<bot.IndonesianFoodLoader.Food> matchedRecipes = bot.ResponTopikService.searchFoodsByKeywordList(text);
                                            recommendationList.put(chatId, matchedRecipes);
                                            String response = bot.ResponTopikService.searchRecipesByKeyword(text);
                                            sendTextWithKeyboard(chatId, response, true);
                                            logMessage(conn, userId, "out", response);
                                            searchModeUsers.remove(chatId);
                                            recommendationState.put(chatId, "awaiting_recipe_number");
                                        } catch (Exception e) {
                                            sendText(chatId, "Maaf, terjadi kesalahan saat mencari resep.");
                                            searchModeUsers.remove(chatId);
                                        }
                                        return;
                                    } else if ("awaiting_recipe_number".equals(recommendationState.get(chatId))) {
                                        try {
                                            int index = Integer.parseInt(text) - 1;
                                            List<bot.IndonesianFoodLoader.Food> recipes = recommendationList.get(chatId);
                                            if (recipes != null && index >= 0 && index < recipes.size()) {
                                                String details = bot.ResponTopikService.getRecipeDetails(recipes.get(index).title);
                                                sendTextWithKeyboard(chatId, details, true);
                                                logMessage(conn, userId, "out", details);
                                            } else {
                                                sendText(chatId, "Nomor resep tidak valid. Silakan coba lagi.");
                                            }
                                        } catch (NumberFormatException e) {
                                            sendText(chatId, "Input tidak valid. Silakan masukkan nomor resep.");
                                        }
                                        recommendationState.remove(chatId);
                                        recommendationList.remove(chatId);
                                        return;
                                    } else if ("awaiting_category".equals(recommendationState.get(chatId))) {
                                        List<bot.IndonesianFoodLoader.Food> recipes = new ArrayList<>();
                                        String category = text.replaceAll("[^\\p{L}\\p{N}\\s]", "").trim().toLowerCase();
                                        try {
                                            switch (category) {
                                                case "pedas":
                                                    recipes = getRecipesByCategory("pedas");
                                                    break;
                                                case "sehat":
                                                    recipes = getRecipesByCategory("sehat");
                                                    break;
                                                case "cheesy":
                                                    recipes = getRecipesByCategory("cheesy");
                                                    break;
                                                case "manis":
                                                    recipes = getRecipesByCategory("manis");
                                                    break;
                                                case "pake bahan yang ada": // Handle "Pake bahan yang ada"
                                                    sendText(chatId, "Silakan ketik bahan-bahan yang Anda miliki, pisahkan dengan koma (contoh: ayam, bawang, cabai).");
                                                    recommendationState.put(chatId, "awaiting_ingredients");
                                                    return;
                                                default:
                                                    sendText(chatId, "Pilihan tidak dikenali. Silakan pilih kategori yang tersedia.");
                                                    return;
                                            }
                                        } catch (Exception e) {
                                            sendText(chatId, "Maaf, terjadi kesalahan saat mengambil resep.");
                                            recommendationState.remove(chatId);
                                            return;
                                        }
                                        if (recipes.isEmpty()) {
                                            sendText(chatId, "Maaf, tidak ada resep untuk kategori ini.");
                                            recommendationState.remove(chatId);
                                            return;
                                        }
                                        StringBuilder sb = new StringBuilder();
                                        sb.append("🌶️ Resep ").append(category).append(" untukmu:\n\n");
                                        for (int i = 0; i < Math.min(3, recipes.size()); i++) {
                                            bot.IndonesianFoodLoader.Food food = recipes.get(i);
                                            sb.append(i + 1).append(". ").append(food.title).append(" (").append("estimasi waktu").append(")\n");
                                        }
                                        sb.append("Ketik nomor untuk melihat detail resep!");
                                        sendTextWithKeyboard(chatId, sb.toString(), true);
                                        logMessage(conn, userId, "out", sb.toString());
                                        recommendationList.put(chatId, recipes);
                                        recommendationState.put(chatId, "awaiting_recipe_number");
                                        return;
                                    } else if ("awaiting_ingredients".equals(recommendationState.get(chatId))) {
                                        String ingredientsInput = text.trim();
                                        try {
                                            List<bot.IndonesianFoodLoader.Food> recipes = bot.ResponTopikService.searchRecipesByIngredients(ingredientsInput);
                                            if (recipes.isEmpty()) {
                                                sendText(chatId, "Maaf, tidak ditemukan resep dengan bahan tersebut.");
                                                recommendationState.remove(chatId);
                                                return;
                                            }
                                            StringBuilder sb = new StringBuilder();
                                            sb.append("Resep dengan bahan yang Anda miliki:\n\n");
                                            for (int i = 0; i < Math.min(3, recipes.size()); i++) {
                                                bot.IndonesianFoodLoader.Food food = recipes.get(i);
                                                sb.append(i + 1).append(". ").append(food.title).append(" (").append("estimasi waktu").append(")\n");
                                            }
                                            sb.append("Ketik nomor untuk melihat detail resep!");
                                            sendTextWithKeyboard(chatId, sb.toString(), true);
                                            logMessage(conn, userId, "out", sb.toString());
                                            recommendationList.put(chatId, recipes);
                                            recommendationState.put(chatId, "awaiting_recipe_number");
                                        } catch (Exception e) {
                                            sendText(chatId, "Maaf, terjadi kesalahan saat mencari resep.");
                                            recommendationState.remove(chatId);
                                        }
                                        return;
                                    }
                                    // Default fallback response if no specific state or command is matched
                                    String response = cariRespon(conn, text);
                                    if (response == null || response.trim().isEmpty()) {
                                        response = "😊 Wah, sepertinya aku belum paham maksud kamu. \n➡️ Yuk, pilih menu di bawah ini ya:";
                                    }
                                    sendTextWithKeyboard(chatId, response, true);
                                    logMessage(conn, userId, "out", response);
                                    return;
                            } // End of switch (text)
                        } // End of if (userStatus.equals("verified"))
                    } else { // This else belongs to `if (msg.hasText())`
                        // For unverified or pending users, block other inputs except /daftar and contact sharing
                        sendText(chatId, "Anda belum terverifikasi. Silakan ketik /daftar untuk memulai proses pendaftaran.");
                        return;
                    }
                } catch (SQLException e) { // Catch for the `try (Connection conn = ...)` block
                    Logger.getLogger(TelegramBot.class.getName()).log(Level.SEVERE, "Database error in onUpdateReceived: ", e);
                    sendText(chatId, "Maaf, terjadi kesalahan pada database. Silakan coba lagi nanti.");
                    return;
                }
            }
        } catch (Exception e) {
            Logger.getLogger(TelegramBot.class.getName()).log(Level.SEVERE, "Error in onUpdateReceived: ", e);
        }
    }

    private String cariRespon(Connection conn, String pesan) {
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT response FROM keywords WHERE keyword LIKE CONCAT('%', ?, '%') LIMIT 1");
            ps.setString(1, pesan);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("response");
            } else {
                // Do not return trending foods here to avoid showing trending menu for unrecognized inputs
                return null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return "Maaf, saya tidak mengerti. Coba ketik kata kunci makanan.";
        }
    }

    // Revert sendTextWithKeyboard to always show "Makanan Trending" button
    private void sendTextWithKeyboard(long chatId, String text, boolean showKeyboard) {
        SendMessage message = new SendMessage();
        message.setChatId(String.valueOf(chatId));
        message.setText(text);
        message.enableMarkdown(true);

        if (showKeyboard) {
            ReplyKeyboardMarkup keyboardMarkup = new ReplyKeyboardMarkup();
            keyboardMarkup.setResizeKeyboard(true);
            List<KeyboardRow> keyboard = new ArrayList<>();

            KeyboardRow row1 = new KeyboardRow();
            row1.add(new KeyboardButton("Makanan Trending"));
            row1.add(new KeyboardButton("Rekomendasi Hari Ini"));

            KeyboardRow row2 = new KeyboardRow();
            row2.add(new KeyboardButton("Tips Masak"));
            row2.add(new KeyboardButton("Cari Makanan"));

            keyboard.add(row1);
            keyboard.add(row2);

            keyboardMarkup.setKeyboard(keyboard);
            message.setReplyMarkup(keyboardMarkup);
        }

        try {
            execute(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void sendText(long chatId, String text) {
        if (chatId <= 0) {
            System.err.println("Invalid chatId: " + chatId + ". Skipping sendText.");
            return;
        }
        SendMessage message = new SendMessage();
        message.setChatId(String.valueOf(chatId));
        message.setText(text);
        message.enableMarkdown(true);

        try {
            execute(message);
        } catch (org.telegram.telegrambots.meta.exceptions.TelegramApiException e) {
            if (e.getMessage() != null && e.getMessage().contains("chat not found")) {
                System.err.println("TelegramApiException: chat not found for chatId " + chatId + ". Skipping message.");
            } else {
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void logMessage(Connection conn, int userId, String direction, String text) throws SQLException {
        PreparedStatement ps = conn.prepareStatement("INSERT INTO messages (user_id, direction, message) VALUES (?, ?, ?)");
        ps.setInt(1, userId);
        ps.setString(2, direction);
        ps.setString(3, text);
        ps.executeUpdate();
    }

    @Override
    public String getBotUsername() {
        return "AloNg0bot"; // Ganti dengan username bot Anda
    }

    @Override
    public String getBotToken() {
        return "7320988184:AAGHe5ZfsxHWjTw1P4m-fNvjm6T4P5hLwxc"; // Ganti dengan token bot dari @BotFather
    }

    public static synchronized void startBot() {
        if (started) {
            System.out.println("Bot is already started.");
            return;
        }
        if (!acquireLock()) {
            System.err.println("Another instance of the bot is already running. Exiting.");
            System.exit(1);
        }
        try {
            TelegramBotsApi botsApi = new TelegramBotsApi(DefaultBotSession.class);
            botsApi.registerBot(TelegramBot.getInstance());
            System.out.println("Bot berjalan...");
            started = true;
        } catch (org.telegram.telegrambots.meta.exceptions.TelegramApiRequestException e) {
            if (e.getMessage() != null && e.getMessage().contains("409")) {
                System.err.println("Error 409 Conflict: Another instance of the bot is already running or another getUpdates request is active.");
                System.err.println("Please ensure only one instance of the bot is running at a time.");
            } else {
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}