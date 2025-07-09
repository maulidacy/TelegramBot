/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package ui;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.sql.*;

import db.DBConnection;

/**
 *
 * @author cahya
 */
public class MemberForm extends javax.swing.JFrame {

    private static MemberForm instance; // Add static instance field

    private JTextField tfHp, tfUsername, tfChatId;
    private JTable tableMember;
    private DefaultTableModel tableModel;
    private telegrambot.TelegramBot telegramBot; // Add TelegramBot reference

    private JLabel lblNotification; // Add notification label

    /**
     * Creates new form MemberForm
     */
    public MemberForm() {
        instance = this; // Assign instance in constructor
        initComponents();
        setTitle("Kelola Member Telegram");
        setSize(620, 460);
        setLayout(null);
        setDefaultCloseOperation(EXIT_ON_CLOSE);

        telegramBot = telegrambot.TelegramBot.getInstance(); // Initialize TelegramBot instance

        JLabel lblHp = new JLabel("Nomor HP:");
        JLabel lblUsername = new JLabel("Username:");
        JLabel lblChatId = new JLabel("Chat ID:");

        tfHp = new JTextField();
        tfUsername = new JTextField();
        tfChatId = new JTextField();

        JButton btnDaftar = new JButton("DAFTAR");
        JButton btnClean = new JButton("CLEAN");
        JButton btnHapus = new JButton("HAPUS");
        JButton btnApprove = new JButton("APPROVE");
        JButton btnReject = new JButton("REJECT");

        lblHp.setBounds(20, 20, 100, 25);
        tfHp.setBounds(120, 20, 180, 25);
        lblUsername.setBounds(20, 50, 100, 25);
        tfUsername.setBounds(120, 50, 180, 25);
        lblChatId.setBounds(20, 80, 100, 25);
        tfChatId.setBounds(120, 80, 180, 25);

        btnDaftar.setBounds(320, 20, 100, 25);
        btnClean.setBounds(320, 50, 100, 25);
        btnHapus.setBounds(320, 80, 100, 25);
        btnApprove.setBounds(430, 20, 100, 25);
        btnReject.setBounds(430, 50, 100, 25);

        tableModel = new DefaultTableModel(new String[]{"Nomor HP", "Username", "Chat ID"}, 0);
        tableMember = new JTable(tableModel);
        JScrollPane scrollPane = new JScrollPane(tableMember);
        scrollPane.setBounds(20, 130, 560, 220);

        // Hide notification label in MemberForm to avoid duplicate notifications
        lblNotification = new JLabel("🔔 Ada user baru yang ingin mendaftar!");
        lblNotification.setBounds(20, 360, 300, 25);
        lblNotification.setVisible(false);
        // Do not add lblNotification to the form to hide it
        // add(lblNotification);

        // Add components to the JFrame content pane
        add(lblHp);
        add(tfHp);
        add(lblUsername);
        add(tfUsername);
        add(lblChatId);
        add(tfChatId);
        add(btnDaftar);
        add(btnClean);
        add(btnHapus);
        add(btnApprove);
        add(btnReject);
        add(scrollPane);

        loadData();

        btnDaftar.addActionListener(e -> {
            saveMember();
            // Notify MainForm to refresh notification
            if (MainForm.instance != null) {
                MainForm.instance.refreshNewUserNotification();
            }
        });
        btnClean.addActionListener(e -> clearForm());
        btnHapus.addActionListener(e -> deleteMember());
        btnApprove.addActionListener(e -> approveMember());
        btnReject.addActionListener(e -> rejectMember());
    }

    // Add public static method to refresh member list
    public static void refreshMemberList() {
        if (instance != null) {
            instance.loadData();
        }
    }

    private void saveMember() {
        String hp = tfHp.getText();
        String username = tfUsername.getText();
        String chatId = tfChatId.getText();

        if (username.isEmpty() || chatId.isEmpty()) {
            JOptionPane.showMessageDialog(this, "Username dan Chat ID wajib diisi!");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO users (telegram_id, username, phone, status) VALUES (?, ?, ?, 'pending')");
            ps.setString(1, chatId);
            ps.setString(2, username);
            ps.setString(3, hp);
            ps.executeUpdate();

            JOptionPane.showMessageDialog(this, "Member berhasil ditambahkan.");
            loadData();
            clearForm();
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, "Gagal tambah member: " + e.getMessage());
        }
    }

    private void approveMember() {
        int selected = tableMember.getSelectedRow();
        if (selected != -1) {
            String chatId = tableModel.getValueAt(selected, 2).toString();
            try (Connection conn = DBConnection.getConnection()) {
                PreparedStatement ps = conn.prepareStatement("UPDATE users SET status = 'verified' WHERE telegram_id = ?");
                ps.setString(1, chatId);
                ps.executeUpdate();
                JOptionPane.showMessageDialog(this, "Member berhasil disetujui.");
                // Send notification to user about approval
                if (telegramBot != null) {
                    // Use reflection or create a public method in TelegramBot to send message
                    try {
                        java.lang.reflect.Method method = telegramBot.getClass().getDeclaredMethod("sendText", long.class, String.class);
                        method.setAccessible(true);
                        method.invoke(telegramBot, Long.parseLong(chatId), "Selamat! Akun Anda telah diverifikasi oleh admin. Anda sekarang dapat mengakses semua fitur.\nKetik /start untuk memulai.");
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                loadData();
            } catch (SQLException e) {
                JOptionPane.showMessageDialog(this, "Gagal menyetujui member: " + e.getMessage());
            }
        } else {
            JOptionPane.showMessageDialog(this, "Pilih baris yang ingin disetujui.");
        }
    }

    private void rejectMember() {
        int selected = tableMember.getSelectedRow();
        if (selected != -1) {
            String chatId = tableModel.getValueAt(selected, 2).toString();
            try (Connection conn = DBConnection.getConnection()) {
                PreparedStatement ps = conn.prepareStatement("UPDATE users SET status = 'blocked' WHERE telegram_id = ?");
                ps.setString(1, chatId);
                ps.executeUpdate();
                JOptionPane.showMessageDialog(this, "Member berhasil ditolak.");
                // Send notification to user about rejection
                if (telegramBot != null) {
                    // Use reflection or create a public method in TelegramBot to send message
                    try {
                        java.lang.reflect.Method method = telegramBot.getClass().getDeclaredMethod("sendText", long.class, String.class);
                        method.setAccessible(true);
                        method.invoke(telegramBot, Long.parseLong(chatId), "Maaf, akun Anda tidak disetujui oleh admin. Silakan hubungi admin untuk informasi lebih lanjut.");
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                loadData();
            } catch (SQLException e) {
                JOptionPane.showMessageDialog(this, "Gagal menolak member: " + e.getMessage());
            }
        } else {
            JOptionPane.showMessageDialog(this, "Pilih baris yang ingin ditolak.");
        }
    }

    private void clearForm() {
        tfHp.setText("");
        tfUsername.setText("");
        tfChatId.setText("");
    }

    private void deleteMember() {
        int selected = tableMember.getSelectedRow();
        if (selected != -1) {
            String chatId = tableModel.getValueAt(selected, 2).toString();
            try (Connection conn = DBConnection.getConnection()) {
                PreparedStatement ps = conn.prepareStatement("DELETE FROM users WHERE telegram_id = ?");
                ps.setString(1, chatId);
                ps.executeUpdate();
                JOptionPane.showMessageDialog(this, "Member berhasil dihapus.");
                loadData();
            } catch (SQLException e) {
                JOptionPane.showMessageDialog(this, "Gagal hapus: " + e.getMessage());
            }
        } else {
            JOptionPane.showMessageDialog(this, "Pilih baris yang ingin dihapus.");
        }
    }

    private void loadData() {
        tableModel.setRowCount(0);
        boolean hasPending = false;
        try (Connection conn = DBConnection.getConnection()) {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT telegram_id, username, phone, status FROM users");
            while (rs.next()) {
                String status = rs.getString("status");
                if ("pending".equalsIgnoreCase(status)) {
                    tableModel.addRow(new Object[]{rs.getString("phone"), rs.getString("username"), rs.getString("telegram_id")});
                    hasPending = true;
                }
            }
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, "Gagal load data: " + e.getMessage());
        }
        // Show or hide notification label based on pending users
        lblNotification.setVisible(hasPending);
    }


    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        // Remove GroupLayout to avoid conflict with null layout and manual bounds
        // Commenting out the GroupLayout code
        /*
        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 444, Short.MAX_VALUE)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 300, Short.MAX_VALUE)
        );
        */

        pack();
    }// </editor-fold>//GEN-END:initComponents

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        SwingUtilities.invokeLater(() -> new MemberForm().setVisible(true));
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(MemberForm.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(MemberForm.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(MemberForm.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(MemberForm.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new MemberForm().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    // End of variables declaration//GEN-END:variables
}
