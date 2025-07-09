/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package ui;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import services.DatabaseService;
import services.DatabaseServiceImpl;
import services.TelegramBotService;

/**
 *
 * @author cahya
 */

public class FormBroadcast extends JFrame {

    private JTextArea txtMessage;
    private JButton btnSend;
    private JTextArea txtLog;

    private DatabaseService databaseService;
    private TelegramBotService telegramBotService;

    public FormBroadcast() {
        setTitle("Broadcast Pesan");
        setSize(500, 450);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        setLayout(new BorderLayout());

        txtMessage = new JTextArea(5, 40);
        JScrollPane scrollMessage = new JScrollPane(txtMessage);

        btnSend = new JButton("KIRIM");

        txtLog = new JTextArea(10, 40);
        txtLog.setEditable(false);
        JScrollPane scrollLog = new JScrollPane(txtLog);

        JPanel panelTop = new JPanel(new BorderLayout());
        panelTop.add(new JLabel("Masukkan pesan broadcast:"), BorderLayout.NORTH);
        panelTop.add(scrollMessage, BorderLayout.CENTER);
        panelTop.add(btnSend, BorderLayout.SOUTH);

        add(panelTop, BorderLayout.NORTH);
        add(scrollLog, BorderLayout.CENTER);

        databaseService = new DatabaseServiceImpl();

        String botToken = "7320988184:AAGHe5ZfsxHWjTw1P4m-fNvjm6T4P5hLwxc";
        String botUsername = "AloNg0bot";
        telegramBotService = new TelegramBotService(botToken, botUsername, databaseService);

        btnSend.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                sendBroadcast();
            }
        });

        // Additional button to test sending a single message manually
        JButton btnTestSend = new JButton("Test Send Single Message");
        btnTestSend.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                testSendSingleMessage();
            }
        });
        JPanel panelBottom = new JPanel();
        panelBottom.add(btnTestSend);
        add(panelBottom, BorderLayout.SOUTH);
    }

    private void sendBroadcast() {
        String message = txtMessage.getText().trim();
        if (message.isEmpty()) {
            JOptionPane.showMessageDialog(this, "Pesan tidak boleh kosong.", "Error", JOptionPane.ERROR_MESSAGE);
            return;
        }

        txtLog.append("Memulai broadcast pesan...\n");

        // Run broadcast in background thread to avoid blocking UI
        new javax.swing.SwingWorker<Void, String>() {
            @Override
            protected Void doInBackground() throws Exception {
                try {
                    publish("Memeriksa databaseService instance...");
                    if (databaseService == null) {
                        publish("databaseService is null!");
                        return null;
                    } else {
                        publish("databaseService is not null.");
                    }
                    publish("Memanggil getAllMembers()...");
                    var users = databaseService.getAllMembers();
                    publish("getAllMembers() berhasil dipanggil.");
                    publish("Jumlah user ditemukan: " + users.size());

                    databaseService.addBroadcast(message);
                    publish("Broadcast log disimpan.");

                    java.util.List<String> chatIds = new java.util.ArrayList<>();
                    for (var user : users) {
                        if ("ver".equalsIgnoreCase(user.getStatus())) {
                            chatIds.add(user.getChatID());
                        }
                    }
                    publish("Jumlah user verified: " + chatIds.size());

                    telegramBotService.broadcastMessage(chatIds, message);
                    publish("Pesan broadcast dikirim.");

                    for (var user : users) {
                        if ("ver".equalsIgnoreCase(user.getStatus())) {
                            databaseService.addMessageOutgoing(user.getId(), message);
                            publish("Pesan terkirim ke " + user.getUsername() + " (Chat ID: " + user.getChatID() + ")");
                        }
                    }

                    publish("Broadcast selesai.");
                } catch (Exception ex) {
                    publish("Gagal broadcast: " + ex.getMessage());
                    ex.printStackTrace();
                }
                return null;
            }

            @Override
            protected void process(java.util.List<String> chunks) {
                for (String log : chunks) {
                    txtLog.append(log + "\n");
                }
            }

            @Override
            protected void done() {
                txtMessage.setText("");
            }
        }.execute();
    }

    private void testSendSingleMessage() {
        String chatId = JOptionPane.showInputDialog(this, "Masukkan Chat ID pengguna untuk tes pengiriman pesan:");
        if (chatId == null || chatId.trim().isEmpty()) {
            JOptionPane.showMessageDialog(this, "Chat ID tidak boleh kosong.", "Error", JOptionPane.ERROR_MESSAGE);
            return;
        }
        String message = JOptionPane.showInputDialog(this, "Masukkan pesan untuk dikirim:");
        if (message == null || message.trim().isEmpty()) {
            JOptionPane.showMessageDialog(this, "Pesan tidak boleh kosong.", "Error", JOptionPane.ERROR_MESSAGE);
            return;
        }
        txtLog.append("Mengirim pesan tes ke Chat ID: " + chatId + "\n");
        try {
            telegramBotService.sendMessage(chatId.trim(), message.trim());
            txtLog.append("Pesan tes terkirim.\n");
        } catch (Exception ex) {
            txtLog.append("Gagal mengirim pesan tes: " + ex.getMessage() + "\n");
            JOptionPane.showMessageDialog(this, "Gagal mengirim pesan tes: " + ex.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
        }
    }
}
