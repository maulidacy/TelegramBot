/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package ui;

import models.BotMessage;
import services.DatabaseService;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.util.List;

/**
 *
 * @author cahya
 */

public class MessageHistoryForm extends JFrame {

    private DatabaseService databaseService;
    private JTable tableMessages;
    private DefaultTableModel tableModel;

    // New UI components for date filtering
    private JTextField txtStartDate;
    private JTextField txtEndDate;
    private JButton btnFilter;
    private JButton btnRefresh;

    public MessageHistoryForm(DatabaseService databaseService) {
        this.databaseService = databaseService;
        setTitle("Database Pesan");
        setSize(900, 450);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(DISPOSE_ON_CLOSE);

        initComponents();
        loadMessages(null, null);
    }

    private void initComponents() {
        tableModel = new DefaultTableModel(new Object[]{"Type", "Chat ID", "Message", "Waktu"}, 0) {
            @Override
            public boolean isCellEditable(int row, int column) {
                return false; // Disable direct editing
            }
        };
        tableMessages = new JTable(tableModel);
        JScrollPane scrollTable = new JScrollPane(tableMessages);

        // Date filter panel
        JPanel filterPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
        filterPanel.add(new JLabel("Start Date (YYYY-MM-DD):"));
        txtStartDate = new JTextField(10);
        filterPanel.add(txtStartDate);

        filterPanel.add(new JLabel("End Date (YYYY-MM-DD):"));
        txtEndDate = new JTextField(10);
        filterPanel.add(txtEndDate);

        btnFilter = new JButton("Filter");
        btnFilter.addActionListener(e -> onFilterClicked());
        filterPanel.add(btnFilter);

        btnRefresh = new JButton("Refresh");
        btnRefresh.addActionListener(e -> onRefreshClicked());
        filterPanel.add(btnRefresh);

        setLayout(new BorderLayout());
        add(filterPanel, BorderLayout.NORTH);
        add(scrollTable, BorderLayout.CENTER);
    }

    private void loadMessages(String startDate, String endDate) {
        try {
            List<BotMessage> messages;
            if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
                messages = databaseService.getMessagesByDateRange(startDate, endDate);
            } else {
                messages = databaseService.getAllMessages();
            }
            tableModel.setRowCount(0);
            for (BotMessage msg : messages) {
                tableModel.addRow(new Object[]{msg.getType().name(), msg.getChatID(), msg.getMessage(), msg.getCreatedAt()});
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(this, "Gagal memuat data pesan: " + e.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void onFilterClicked() {
        String startDate = txtStartDate.getText().trim();
        String endDate = txtEndDate.getText().trim();
        if (startDate.isEmpty() || endDate.isEmpty()) {
            JOptionPane.showMessageDialog(this, "Mohon isi kedua tanggal mulai dan tanggal akhir.", "Peringatan", JOptionPane.WARNING_MESSAGE);
            return;
        }
        // Basic validation for date format could be added here if needed
        loadMessages(startDate, endDate);
    }

    private void onRefreshClicked() {
        txtStartDate.setText("");
        txtEndDate.setText("");
        loadMessages(null, null);
    }
}
