/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package db;

import java.sql.*;

/**
 *
 * @author cahya
 */
public class DBConnection {
    // Ubah sesuai koneksi lokalmu
    private static final String DB_URL = "jdbc:mysql://localhost:3306/telegram_chatbot";
    private static final String DB_USER = "root";
    private static final String DB_PASS = ""; 
    
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
    }

    public static boolean isMember(String userId) {
        try (Connection conn = getConnection()) {
            String sql = "SELECT * FROM users WHERE telegram_id = ? AND status = 'verified'";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, userId);
            ResultSet rs = stmt.executeQuery();
            return rs.next(); // true jika ditemukan
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static void saveIncoming(String userId, String message) {
        try (Connection conn = getConnection()) {
            String sql = "INSERT INTO messages (user_id, direction, message) VALUES ((SELECT id FROM users WHERE telegram_id = ?), 'in', ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, userId);
            stmt.setString(2, message);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void saveOutgoing(String userId, String message) {
        try (Connection conn = getConnection()) {
            String sql = "INSERT INTO messages (user_id, direction, message) VALUES ((SELECT id FROM users WHERE telegram_id = ?), 'out', ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, userId);
            stmt.setString(2, message);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static java.util.List<models.BotMessage> getAllMessages() {
        java.util.List<models.BotMessage> messages = new java.util.ArrayList<>();
        String sql = "SELECT m.direction, u.telegram_id, m.message " +
                     "FROM messages m " +
                     "JOIN users u ON m.user_id = u.id " +
                     "ORDER BY m.id DESC";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                String direction = rs.getString("direction");
                String telegramId = rs.getString("telegram_id");
                String message = rs.getString("message");
                models.BotMessage botMessage = new models.BotMessage();
                botMessage.setType(models.BotMessage.Type.valueOf(direction.toUpperCase()));
                botMessage.setChatID(telegramId);
                botMessage.setMessage(message);
                messages.add(botMessage);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return messages;
    }

    public static void testConnection() {
        try (Connection conn = getConnection()) {
            if (conn != null) {
                System.out.println("✅ Koneksi ke database berhasil!");
            }
        } catch (SQLException e) {
            System.err.println("❌ Gagal koneksi ke database: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        // Contoh penggunaan
        testConnection();
        // Tambahkan logika lain jika diperlukan
    }

    public static java.util.List<String> getPendingUserChatIds() {
        java.util.List<String> pendingUsers = new java.util.ArrayList<>();
        String sql = "SELECT telegram_id FROM users WHERE status = 'pending'";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                pendingUsers.add(rs.getString("telegram_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pendingUsers;
    }

    public static boolean updateUserStatus(String chatId, String status) {
        String sql = "UPDATE users SET status = ? WHERE telegram_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, chatId);
            int affected = ps.executeUpdate();
            return affected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
