/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package ui;

import models.Keyword;
import services.DatabaseService;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.util.List;

/**
 *
 * @author cahya
 */
public class KeywordManagementForm extends JFrame {

    private DatabaseService databaseService;
    private JTable tableKeywords;
    private DefaultTableModel tableModel;

    private JTextField tfKeyword;
    private JTextArea taResponse;

    public KeywordManagementForm(DatabaseService databaseService) {
        this.databaseService = databaseService;
        setTitle("Kelola Kata Kunci & Jawaban");
        setSize(600, 400);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(DISPOSE_ON_CLOSE);

        initComponents();
        loadKeywords();
    }

    private void initComponents() {
        tfKeyword = new JTextField();
        taResponse = new JTextArea(5, 20);
        taResponse.setLineWrap(true);
        taResponse.setWrapStyleWord(true);

        JButton btnAdd = new JButton("Tambah");
        JButton btnUpdate = new JButton("Update");
        JButton btnDelete = new JButton("Hapus");
        JButton btnClear = new JButton("Clear");

        tableModel = new DefaultTableModel(new Object[]{"Keyword", "Response"}, 0) {
            @Override
            public boolean isCellEditable(int row, int column) {
                return false; // Disable direct editing
            }
        };
        tableKeywords = new JTable(tableModel);
        JScrollPane scrollTable = new JScrollPane(tableKeywords);
        JScrollPane scrollResponse = new JScrollPane(taResponse);

        JPanel inputPanel = new JPanel(new GridBagLayout());
        GridBagConstraints gbc = new GridBagConstraints();

        gbc.insets = new Insets(5,5,5,5);
        gbc.gridx = 0; gbc.gridy = 0; gbc.anchor = GridBagConstraints.WEST;
        inputPanel.add(new JLabel("Keyword:"), gbc);
        gbc.gridx = 1; gbc.fill = GridBagConstraints.HORIZONTAL; gbc.weightx = 1.0;
        inputPanel.add(tfKeyword, gbc);

        gbc.gridx = 0; gbc.gridy = 1; gbc.fill = GridBagConstraints.NONE; gbc.weightx = 0;
        inputPanel.add(new JLabel("Response:"), gbc);
        gbc.gridx = 1; gbc.fill = GridBagConstraints.BOTH; gbc.weightx = 1.0; gbc.weighty = 1.0;
        inputPanel.add(scrollResponse, gbc);

        JPanel buttonPanel = new JPanel();
        buttonPanel.add(btnAdd);
        buttonPanel.add(btnUpdate);
        buttonPanel.add(btnDelete);
        buttonPanel.add(btnClear);

        setLayout(new BorderLayout());
        add(inputPanel, BorderLayout.NORTH);
        add(scrollTable, BorderLayout.CENTER);
        add(buttonPanel, BorderLayout.SOUTH);

        btnAdd.addActionListener(e -> addKeyword());
        btnUpdate.addActionListener(e -> updateKeyword());
        btnDelete.addActionListener(e -> deleteKeyword());
        btnClear.addActionListener(e -> clearForm());

        tableKeywords.getSelectionModel().addListSelectionListener(e -> {
            if (!e.getValueIsAdjusting()) {
                int selectedRow = tableKeywords.getSelectedRow();
                if (selectedRow >= 0) {
                    tfKeyword.setText(tableModel.getValueAt(selectedRow, 0).toString());
                    taResponse.setText(tableModel.getValueAt(selectedRow, 1).toString());
                }
            }
        });
    }

    private void loadKeywords() {
        try {
            List<Keyword> keywords = databaseService.getAllKeywords();
            tableModel.setRowCount(0);
            for (Keyword k : keywords) {
                tableModel.addRow(new Object[]{k.getKeyword(), k.getResponse()});
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(this, "Gagal memuat data kata kunci: " + e.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void addKeyword() {
        String keyword = tfKeyword.getText().trim();
        String response = taResponse.getText().trim();
        if (keyword.isEmpty() || response.isEmpty()) {
            JOptionPane.showMessageDialog(this, "Keyword dan Response harus diisi.", "Warning", JOptionPane.WARNING_MESSAGE);
            return;
        }
        try {
            databaseService.addKeyword(new Keyword(keyword, response));
            loadKeywords();
            clearForm();
            JOptionPane.showMessageDialog(this, "Keyword berhasil ditambahkan.");
        } catch (Exception e) {
            JOptionPane.showMessageDialog(this, "Gagal menambahkan keyword: " + e.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void updateKeyword() {
        int selectedRow = tableKeywords.getSelectedRow();
        if (selectedRow < 0) {
            JOptionPane.showMessageDialog(this, "Pilih keyword yang akan diupdate.", "Warning", JOptionPane.WARNING_MESSAGE);
            return;
        }
        String oldKeyword = tableModel.getValueAt(selectedRow, 0).toString();
        String newKeyword = tfKeyword.getText().trim();
        String newResponse = taResponse.getText().trim();
        if (newKeyword.isEmpty() || newResponse.isEmpty()) {
            JOptionPane.showMessageDialog(this, "Keyword dan Response harus diisi.", "Warning", JOptionPane.WARNING_MESSAGE);
            return;
        }
        try {
            databaseService.updateKeyword(oldKeyword, new Keyword(newKeyword, newResponse));
            loadKeywords();
            clearForm();
            JOptionPane.showMessageDialog(this, "Keyword berhasil diupdate.");
        } catch (Exception e) {
            JOptionPane.showMessageDialog(this, "Gagal mengupdate keyword: " + e.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void deleteKeyword() {
        int selectedRow = tableKeywords.getSelectedRow();
        if (selectedRow < 0) {
            JOptionPane.showMessageDialog(this, "Pilih keyword yang akan dihapus.", "Warning", JOptionPane.WARNING_MESSAGE);
            return;
        }
        String keyword = tableModel.getValueAt(selectedRow, 0).toString();
        int confirm = JOptionPane.showConfirmDialog(this, "Apakah Anda yakin ingin menghapus keyword '" + keyword + "'?", "Konfirmasi", JOptionPane.YES_NO_OPTION);
        if (confirm == JOptionPane.YES_OPTION) {
            try {
                databaseService.deleteKeyword(keyword);
                loadKeywords();
                clearForm();
                JOptionPane.showMessageDialog(this, "Keyword berhasil dihapus.");
            } catch (Exception e) {
                JOptionPane.showMessageDialog(this, "Gagal menghapus keyword: " + e.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
            }
        }
    }

    private void clearForm() {
        tfKeyword.setText("");
        taResponse.setText("");
        tableKeywords.clearSelection();
    }
}
