/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package ui;

import javax.swing.table.DefaultTableModel;
import java.util.ArrayList;
import java.util.List;
import models.Member; // We will create this class
import services.TelegramBotService; // We will create this class
import services.DatabaseService; // We will create this class
import services.MockDatabaseService; // A mock implementation for now

/**
 *
 * @author cahya
 */
public class MainForm extends javax.swing.JFrame {

    public static MainForm instance; // Add static instance field

    private String adminNama;
    private String waktuLogin;
    private DatabaseService databaseService; // Using an interface for flexibility
    private TelegramBotService botService; // Added botService field

    private javax.swing.JLabel lblNewUserNotification; // Notification label
    private javax.swing.JButton btnManageMembers; // Button to open MemberForm

    /**
     * Creates new form MainForm
     */
    public MainForm() {
        instance = this; // Assign instance in constructor
        initComponents(); // Initialize GUI components
        setTitle("Telegram Bot");

        // Initialize Database Service (using mock for now, replace with Firestore)
        // databaseService = new MockDatabaseService(); // Will be replaced by FirestoreDatabaseService
        databaseService = new services.DatabaseServiceImpl();

        // Initialize TelegramBotService instance
        String botToken = "7320988184:AAGHe5ZfsxHWjTw1P4m-fNvjm6T4P5hLwxc";
        String botUsername = "AloNg0bot";
        botService = new TelegramBotService(botToken, botUsername, databaseService);

        // Start the TelegramBot singleton in a separate thread to avoid blocking the UI
        new Thread(() -> telegrambot.TelegramBot.startBot()).start();

        // Set up the table model with initial data
        setupTableModel();
        loadMembersFromDatabase(); // Load initial data when form starts

        // Add mouse listener for table row selection
        tblMember.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                tblMemberMouseClicked(evt);
            }
        });

        // Add action listeners for buttons using lambda expressions
        btnDaftar.addActionListener(evt -> btnDaftarActionPerformed(evt));
        btnClean.addActionListener(evt -> btnCleanActionPerformed(evt));
        btnHapus.addActionListener(evt -> btnHapusActionPerformed(evt));
        btnEdit.addActionListener(evt -> btnEditActionPerformed(evt));
        btnBroadcast.addActionListener(evt -> btnBroadcastActionPerformed(evt));
        jButton7.addActionListener(evt -> btnLogoutActionPerformed(evt)); // Logout button
        jButton4.addActionListener(evt -> btnKeluarActionPerformed(evt)); // KELUAR button
        btnRefresh.addActionListener(evt -> btnRefreshActionPerformed(evt)); // Refresh button
        txtBroadcastPesan.addActionListener(evt -> txtBroadcastPesanActionPerformed(evt)); // Enter key for broadcast

        // Add action listeners for new buttons (placeholders for now)
        jButton2.addActionListener(evt -> btnKelolaKataKunciActionPerformed(evt)); // KELOLA KATA KUNCI
        jButton3.addActionListener(evt -> btnDatabasePesanActionPerformed(evt)); // DATABASE PESAN

        // Add notification label and manage members button
        lblNewUserNotification = new javax.swing.JLabel("🔔 Ada user baru yang ingin mendaftar!");
        // Remove manual bounds and add to layout instead
        // lblNewUserNotification.setBounds(20, 10, 250, 25);
        lblNewUserNotification.setVisible(false);
        add(lblNewUserNotification);

        // Update admin info on start (if available)
        updateAdminInfo();

        // Refresh notification visibility on form load
        refreshNewUserNotification();
    }

    // Add method to refresh new user notification
    public void refreshNewUserNotification() {
        boolean hasPending = false;
        try {
            List<Member> members = databaseService.getAllMembers();
            for (Member member : members) {
                if ("pending".equalsIgnoreCase(member.getStatus())) {
                    hasPending = true;
                    break;
                }
            }
        } catch (Exception e) {
            // Log or handle error if needed
        }
        if (lblNewUserNotification != null) {
            lblNewUserNotification.setVisible(hasPending);
        }
    }

    // Method to set up the table model explicitly
    private void setupTableModel() {
        DefaultTableModel model = new DefaultTableModel(
            new Object [][] {}, // No initial data rows
            new String [] {
                "Nomor HP", "Username", "Chat ID"
            }
        ) {
            boolean[] canEdit = new boolean [] {
                false, false, false // Make all cells non-editable directly in the table
            };

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        };
        tblMember.setModel(model);
        tblMember.getTableHeader().setReorderingAllowed(false); // Prevent column reordering
    }

    // Load members from the database service and populate the table
    private void loadMembersFromDatabase() {
        DefaultTableModel model = (DefaultTableModel) tblMember.getModel();
        model.setRowCount(0); // Clear existing data

        try {
            List<Member> members = databaseService.getAllMembers();
            for (Member member : members) {
                model.addRow(new Object[]{member.getNomorHP(), member.getUsername(), member.getChatID()});
            }
            txtPesanLog.append("Data anggota berhasil dimuat.\n");
        } catch (Exception e) {
            txtPesanLog.append("Gagal memuat data anggota: " + e.getMessage() + "\n");
            javax.swing.JOptionPane.showMessageDialog(this, "Error loading members: " + e.getMessage(), "Database Error", javax.swing.JOptionPane.ERROR_MESSAGE);
        }
    }


    public void setAdminNama(String adminNama) {
        this.adminNama = adminNama;
    }

    public void setWaktuLogin(String waktuLogin) {
        this.waktuLogin = waktuLogin;
    }

    // Remove jLabelLogin declaration and use jLabel9 instead
    // private javax.swing.JLabel jLabelLogin; // Add declaration for jLabelLogin

    public void updateAdminInfo() {
        if (jLabel1 != null) {
            jLabel1.setText("Admin: " + (adminNama != null ? adminNama : "N/A"));
        }
        // Update jLabel9 instead of jLabelLogin
        if (jLabel9 != null) {
            jLabel9.setText("Login: " + (waktuLogin != null ? waktuLogin : "N/A"));
        }
    }

    private void btnLogoutActionPerformed(java.awt.event.ActionEvent evt) {
        this.dispose();
        // Fix: Import FrmLogin class and use it directly
        ui.FrmLogin loginForm = new ui.FrmLogin();
        loginForm.setVisible(true);
        // Additional logout logic: clear any session or user data if applicable
        // For example, if you have a user session object, clear it here
        // If the app uses static or singleton user state, reset it here
    }

    private void btnKeluarActionPerformed(java.awt.event.ActionEvent evt) {
        System.exit(0);
    }

    private void btnDaftarActionPerformed(java.awt.event.ActionEvent evt) {
        String nomorHP = txtNomorHP.getText().trim();
        String username = txtUsername.getText().trim();
        String chatID = txtChatID.getText().trim();

        if (nomorHP.isEmpty() || username.isEmpty() || chatID.isEmpty()) {
            javax.swing.JOptionPane.showMessageDialog(this, "Semua field harus diisi.");
            return;
        }

        try {
            // Use default id and status for new member
            Member newMember = new Member(0, nomorHP, username, chatID, "ver");
            databaseService.addMember(newMember);
            loadMembersFromDatabase(); // Reload table after adding
            txtPesanLog.append("Anggota '" + username + "' berhasil didaftarkan.\n");
            btnCleanActionPerformed(evt);
        } catch (Exception e) {
            txtPesanLog.append("Gagal mendaftarkan anggota: " + e.getMessage() + "\n");
            javax.swing.JOptionPane.showMessageDialog(this, "Error registering member: " + e.getMessage(), "Database Error", javax.swing.JOptionPane.ERROR_MESSAGE);
        }
    }

    private void btnCleanActionPerformed(java.awt.event.ActionEvent evt) {
        txtNomorHP.setText("");
        txtUsername.setText("");
        txtChatID.setText("");
        tblMember.clearSelection(); // Clear table selection
    }

    private void btnHapusActionPerformed(java.awt.event.ActionEvent evt) {
        int selectedRow = tblMember.getSelectedRow();
        if (selectedRow >= 0) {
            DefaultTableModel model = (DefaultTableModel) tblMember.getModel();
            String chatIDToDelete = model.getValueAt(selectedRow, 2).toString(); // Assuming Chat ID is unique

            try {
                databaseService.deleteMember(chatIDToDelete);
                loadMembersFromDatabase(); // Reload table after deleting
                txtPesanLog.append("Anggota dengan Chat ID: " + chatIDToDelete + " berhasil dihapus.\n");
                btnCleanActionPerformed(evt);
            } catch (Exception e) {
                txtPesanLog.append("Gagal menghapus anggota: " + e.getMessage() + "\n");
                javax.swing.JOptionPane.showMessageDialog(this, "Error deleting member: " + e.getMessage(), "Database Error", javax.swing.JOptionPane.ERROR_MESSAGE);
            }
        } else {
            javax.swing.JOptionPane.showMessageDialog(this, "Pilih baris yang akan dihapus.");
        }
    }

    private void btnEditActionPerformed(java.awt.event.ActionEvent evt) {
        int selectedRow = tblMember.getSelectedRow();
        if (selectedRow >= 0) {
            String oldChatID = tblMember.getModel().getValueAt(selectedRow, 2).toString(); // Get old chat ID for update

            String nomorHP = txtNomorHP.getText().trim();
            String username = txtUsername.getText().trim();
            String chatID = txtChatID.getText().trim(); // New chat ID if changed

            if (nomorHP.isEmpty() || username.isEmpty() || chatID.isEmpty()) {
                javax.swing.JOptionPane.showMessageDialog(this, "Semua field harus diisi.");
                return;
            }

            try {
            // Use default id and status for updated member
            Member updatedMember = new Member(0, nomorHP, username, chatID, "ver");
            databaseService.updateMember(oldChatID, updatedMember); // Update by old Chat ID
            loadMembersFromDatabase(); // Reload table after editing
            txtPesanLog.append("Anggota dengan Chat ID: " + oldChatID + " berhasil diupdate.\n");
            btnCleanActionPerformed(evt);
        } catch (Exception e) {
            txtPesanLog.append("Gagal mengedit anggota: " + e.getMessage() + "\n");
            javax.swing.JOptionPane.showMessageDialog(this, "Error updating member: " + e.getMessage(), "Database Error", javax.swing.JOptionPane.ERROR_MESSAGE);
        }
        } else {
            javax.swing.JOptionPane.showMessageDialog(this, "Pilih baris yang akan diedit.");
        }
    }

    private void btnBroadcastActionPerformed(java.awt.event.ActionEvent evt) {
        String pesan = txtBroadcastPesan.getText().trim();
        if (pesan.isEmpty()) {
            javax.swing.JOptionPane.showMessageDialog(this, "Masukkan pesan broadcast.");
            return;
        }

        DefaultTableModel model = (DefaultTableModel) tblMember.getModel();
        int rowCount = model.getRowCount();

        if (rowCount == 0) {
            javax.swing.JOptionPane.showMessageDialog(this, "Tidak ada anggota untuk dikirim pesan.");
            return;
        }

        txtPesanLog.append("Memulai broadcast pesan...\n");
        // Iterate through all members and send broadcast
        for (int i = 0; i < rowCount; i++) {
            String chatID = model.getValueAt(i, 2).toString();
            String username = model.getValueAt(i, 1).toString(); // Get username for logging
            
            if (botService != null) {
                try {
                    botService.sendMessage(chatID, pesan); // Actual call
                    txtPesanLog.append("Pesan terkirim ke " + username + " (Chat ID: " + chatID + ")\n");
                } catch (Exception e) {
                    txtPesanLog.append("Gagal mengirim pesan ke " + username + " (Chat ID: " + chatID + "): " + e.getMessage() + "\n");
                }
            } else {
                txtPesanLog.append("Simulasi: Pesan terkirim ke " + username + " (Chat ID: " + chatID + "): '" + pesan + "'\n");
            }
        }
        txtPesanLog.append("Broadcast pesan selesai.\n");
        txtBroadcastPesan.setText(""); // Clear broadcast message field
    }

    private void tblMemberMouseClicked(java.awt.event.MouseEvent evt) {
        int selectedRow = tblMember.getSelectedRow();
        if (selectedRow >= 0) {
            DefaultTableModel model = (DefaultTableModel) tblMember.getModel();
            txtNomorHP.setText(model.getValueAt(selectedRow, 0).toString());
            txtUsername.setText(model.getValueAt(selectedRow, 1).toString());
            txtChatID.setText(model.getValueAt(selectedRow, 2).toString());
        }
    }

    private void btnRefreshActionPerformed(java.awt.event.ActionEvent evt) {
        loadMembersFromDatabase();
        javax.swing.JOptionPane.showMessageDialog(this, "Data anggota telah diperbarui.");
    }

    private void txtBroadcastPesanActionPerformed(java.awt.event.ActionEvent evt) {
        // This action listener is for when the user presses Enter in the broadcast message field.
        btnBroadcastActionPerformed(evt); // Trigger broadcast when Enter is pressed
    }

    // Placeholder for "Kelola Kata Kunci" button action
    private void btnKelolaKataKunciActionPerformed(java.awt.event.ActionEvent evt) {
        new ui.KeywordManagementForm(databaseService).setVisible(true);
    }

    // Placeholder for "Database Pesan" button action
    private void btnDatabasePesanActionPerformed(java.awt.event.ActionEvent evt) {
        new ui.MessageHistoryForm(databaseService).setVisible(true);
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jButton1 = new javax.swing.JButton();
        jLabel1 = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        jLabel3 = new javax.swing.JLabel();
        jLabel4 = new javax.swing.JLabel();
        jLabel5 = new javax.swing.JLabel();
        txtNomorHP = new javax.swing.JTextField();
        txtUsername = new javax.swing.JTextField();
        txtChatID = new javax.swing.JTextField();
        btnDaftar = new javax.swing.JButton();
        btnClean = new javax.swing.JButton();
        btnHapus = new javax.swing.JButton();
        btnEdit = new javax.swing.JButton();
        jScrollPane1 = new javax.swing.JScrollPane();
        tblMember = new javax.swing.JTable();
        btnRefresh = new javax.swing.JButton();
        jButton7 = new javax.swing.JButton();
        jLabel7 = new javax.swing.JLabel();
        txtBroadcastPesan = new javax.swing.JTextField();
        btnBroadcast = new javax.swing.JButton();
        jLabel8 = new javax.swing.JLabel();
        jLabel6 = new javax.swing.JLabel();
        jScrollPane2 = new javax.swing.JScrollPane();
        txtPesanLog = new javax.swing.JTextArea();
        jButton2 = new javax.swing.JButton();
        jButton3 = new javax.swing.JButton();
        jButton4 = new javax.swing.JButton();
        btnKelolaMember = new javax.swing.JButton();
        jLabel9 = new javax.swing.JLabel();

        jButton1.setText("jButton1");

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        jLabel1.setText("Admin: ");

        jLabel2.setText("KELOLA MEMBER");

        jLabel3.setText("Nomor HP");

        jLabel4.setText("Username");

        jLabel5.setText("Chat ID [ASAP]");

        btnDaftar.setText("DAFTAR");

        btnClean.setText("CLEAN");

        btnHapus.setText("HAPUS");

        btnEdit.setText("EDIT");

        tblMember.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null, null},
                {null, null, null},
                {null, null, null},
                {null, null, null}
            },
            new String [] {
                "Nomor HP", "Username", "Chat ID"
            }
        ));
        jScrollPane1.setViewportView(tblMember);

        btnRefresh.setText("REFRESH");
        btnRefresh.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnRefreshActionPerformed(evt);
            }
        });

        jButton7.setText("Logout");

        jLabel7.setText("BROADCAST PESAN");

        txtBroadcastPesan.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txtBroadcastPesanActionPerformed(evt);
            }
        });

        btnBroadcast.setText("BROADCAST");
        btnBroadcast.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnBroadcastActionPerformed(evt);
            }
        });

        jLabel8.setText("DATA MEMBER");

        jLabel6.setText("PESAN KELUAR & MASUK");

        txtPesanLog.setColumns(20);
        txtPesanLog.setRows(5);
        jScrollPane2.setViewportView(txtPesanLog);

        jButton2.setText("KELOLA KATA KUNCI");

        jButton3.setText("DATABASE PESAN");

        jButton4.setText("KELUAR");

        btnKelolaMember.setText("Kelola Member");
        btnKelolaMember.addActionListener(evt -> {
            new MemberForm().setVisible(true);
        });

        jLabel9.setText("Login:");

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(13, 13, 13)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                        .addComponent(jLabel1)
                        .addGap(156, 156, 156)
                        .addComponent(jLabel9)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(btnKelolaMember)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(jButton7))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(layout.createSequentialGroup()
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addComponent(jLabel3)
                                    .addComponent(jLabel4))
                                .addGap(34, 34, 34)
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                                    .addComponent(txtUsername, javax.swing.GroupLayout.DEFAULT_SIZE, 175, Short.MAX_VALUE)
                                    .addComponent(txtNomorHP)))
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(jLabel5)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addGroup(layout.createSequentialGroup()
                                        .addComponent(btnDaftar)
                                        .addGap(18, 18, 18)
                                        .addComponent(btnClean)
                                        .addGap(18, 18, 18)
                                        .addComponent(btnHapus)
                                        .addGap(18, 18, 18)
                                        .addComponent(btnEdit))
                                    .addComponent(txtChatID, javax.swing.GroupLayout.PREFERRED_SIZE, 175, javax.swing.GroupLayout.PREFERRED_SIZE)))
                            .addComponent(jLabel2)
                            .addComponent(jLabel7))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                .addComponent(jLabel8)
                                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 360, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addComponent(btnRefresh, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, 87, javax.swing.GroupLayout.PREFERRED_SIZE)))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                        .addComponent(txtBroadcastPesan)
                        .addGap(18, 18, 18)
                        .addComponent(btnBroadcast, javax.swing.GroupLayout.PREFERRED_SIZE, 109, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addComponent(jScrollPane2)
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(jButton2, javax.swing.GroupLayout.PREFERRED_SIZE, 179, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(18, 18, 18)
                                .addComponent(jButton3, javax.swing.GroupLayout.PREFERRED_SIZE, 187, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(18, 18, 18)
                                .addComponent(jButton4, javax.swing.GroupLayout.PREFERRED_SIZE, 178, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addComponent(jLabel6))
                        .addGap(0, 0, Short.MAX_VALUE)))
                .addGap(22, 22, 22))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(19, 19, 19)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel1)
                    .addComponent(jButton7)
                    .addComponent(btnKelolaMember)
                    .addComponent(jLabel9))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel2)
                    .addComponent(jLabel8))
                .addGap(17, 17, 17)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel3)
                            .addComponent(txtNomorHP, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel4)
                            .addComponent(txtUsername, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel5)
                            .addComponent(txtChatID, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                        .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 102, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(6, 6, 6)))
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(btnDaftar)
                            .addComponent(btnClean)
                            .addComponent(btnHapus)
                            .addComponent(btnEdit))
                        .addGap(18, 18, 18)
                        .addComponent(jLabel7))
                    .addGroup(layout.createSequentialGroup()
                        .addGap(20, 20, 20)
                        .addComponent(btnRefresh)))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(txtBroadcastPesan, javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(btnBroadcast, javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addComponent(jLabel6)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, 186, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jButton2)
                    .addComponent(jButton3)
                    .addComponent(jButton4))
                .addContainerGap(18, Short.MAX_VALUE))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    // No need to define these again, as they are already linked in the constructor
    // private void btnRefreshActionPerformed(java.awt.event.ActionEvent evt) {}
    // private void txtBroadcastPesanActionPerformed(java.awt.event.ActionEvent evt) {}

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(MainForm.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(MainForm.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(MainForm.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(MainForm.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new MainForm().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnBroadcast;
    private javax.swing.JButton btnClean;
    private javax.swing.JButton btnDaftar;
    private javax.swing.JButton btnEdit;
    private javax.swing.JButton btnHapus;
    private javax.swing.JButton btnKelolaMember;
    private javax.swing.JButton btnRefresh;
    private javax.swing.JButton jButton1;
    private javax.swing.JButton jButton2;
    private javax.swing.JButton jButton3;
    private javax.swing.JButton jButton4;
    private javax.swing.JButton jButton7;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JLabel jLabel7;
    private javax.swing.JLabel jLabel8;
    private javax.swing.JLabel jLabel9;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JTable tblMember;
    private javax.swing.JTextField txtBroadcastPesan;
    private javax.swing.JTextField txtChatID;
    private javax.swing.JTextField txtNomorHP;
    private javax.swing.JTextArea txtPesanLog;
    private javax.swing.JTextField txtUsername;
    // End of variables declaration//GEN-END:variables
}
