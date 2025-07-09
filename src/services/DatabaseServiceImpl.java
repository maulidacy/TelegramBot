package services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import db.DBConnection;
import models.Member;
import models.Keyword;
import models.BotMessage;

public class DatabaseServiceImpl implements DatabaseService {

    @Override
    public List<Member> getAllMembers() throws Exception {
        List<Member> members = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT id, phone, username, telegram_id, status FROM users";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String phoneNumber = rs.getString("phone");
                String username = rs.getString("username");
                String chatId = rs.getString("telegram_id");
                String status = rs.getString("status");
                members.add(new Member(id, phoneNumber != null ? phoneNumber : "-", username, chatId, status));
            }
        }
        return members;
    }

    @Override
    public models.Member getMemberByChatID(String chatId) throws Exception {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT id, phone, username, telegram_id, status FROM users WHERE telegram_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, chatId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("id");
                String phoneNumber = rs.getString("phone");
                String username = rs.getString("username");
                String telegramId = rs.getString("telegram_id");
                String status = rs.getString("status");
                return new Member(id, phoneNumber != null ? phoneNumber : "-", username, telegramId, status);
            } else {
                return null;
            }
        }
    }

    @Override
    public void addMember(Member member) throws Exception {
        try (Connection conn = DBConnection.getConnection()) {
            // Check if member with telegram_id exists
            String checkSql = "SELECT id FROM users WHERE telegram_id = ?";
            PreparedStatement checkPs = conn.prepareStatement(checkSql);
            checkPs.setString(1, member.getChatID());
            ResultSet rs = checkPs.executeQuery();
            if (rs.next()) {
                // Member exists, update record
                String updateSql = "UPDATE users SET phone = ?, username = ?, status = 'verified' WHERE telegram_id = ?";
                PreparedStatement updatePs = conn.prepareStatement(updateSql);
                updatePs.setString(1, member.getNomorHP());
                updatePs.setString(2, member.getUsername());
                updatePs.setString(3, member.getChatID());
                updatePs.executeUpdate();
            } else {
                // Insert new member
                String insertSql = "INSERT INTO users (phone, username, telegram_id, status) VALUES (?, ?, ?, 'verified')";
                PreparedStatement insertPs = conn.prepareStatement(insertSql);
                insertPs.setString(1, member.getNomorHP());
                insertPs.setString(2, member.getUsername());
                insertPs.setString(3, member.getChatID());
                insertPs.executeUpdate();
            }
        }
    }

    @Override
    public void deleteMember(String chatId) throws Exception {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "DELETE FROM users WHERE telegram_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, chatId);
            ps.executeUpdate();
        }
    }

    @Override
    public void updateMember(String oldChatId, Member updatedMember) throws Exception {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE users SET phone = ?, username = ?, telegram_id = ? WHERE telegram_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, updatedMember.getNomorHP());
            ps.setString(2, updatedMember.getUsername());
            ps.setString(3, updatedMember.getChatID());
            ps.setString(4, oldChatId);
            ps.executeUpdate();
        }
    }

    @Override
    public void updateMemberStatus(String chatId, String status) throws Exception {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE users SET status = ? WHERE telegram_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setString(2, chatId);
            ps.executeUpdate();
        }
    }

    @Override
    public void addMessage(BotMessage message) throws Exception {
        // TODO: Implement if needed
    }

    @Override
    public List<Keyword> getAllKeywords() throws Exception {
        List<Keyword> keywords = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT keyword, response FROM keywords";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String keyword = rs.getString("keyword");
                String response = rs.getString("response");
                keywords.add(new Keyword(keyword, response));
            }
        }
        return keywords;
    }

    @Override
    public void addKeyword(Keyword keyword) throws Exception {
        try (Connection conn = DBConnection.getConnection()) {
            // Check if keyword already exists
            String checkSql = "SELECT COUNT(*) FROM keywords WHERE keyword = ?";
            PreparedStatement checkPs = conn.prepareStatement(checkSql);
            checkPs.setString(1, keyword.getKeyword());
            ResultSet rs = checkPs.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                throw new Exception("Keyword sudah ada: " + keyword.getKeyword());
            }
            String sql = "INSERT INTO keywords (keyword, response) VALUES (?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, keyword.getKeyword());
            ps.setString(2, keyword.getResponse());
            ps.executeUpdate();
        }
    }

    @Override
    public void updateKeyword(String oldKeyword, Keyword updatedKeyword) throws Exception {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE keywords SET response = ? WHERE keyword = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, updatedKeyword.getResponse());
            ps.setString(2, oldKeyword);
            int affectedRows = ps.executeUpdate();
            if (affectedRows == 0) {
                throw new Exception("Keyword tidak ditemukan: " + oldKeyword);
            }
        }
    }

    @Override
    public void deleteKeyword(String keyword) throws Exception {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "DELETE FROM keywords WHERE keyword = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, keyword);
            int affectedRows = ps.executeUpdate();
            if (affectedRows == 0) {
                throw new Exception("Keyword tidak ditemukan: " + keyword);
            }
        }
    }

    @Override
    public List<BotMessage> getAllMessages() throws Exception {
        List<BotMessage> messages = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT m.direction, u.telegram_id, m.message, m.created_at " +
                         "FROM messages m " +
                         "JOIN users u ON m.user_id = u.id " +
                         "ORDER BY m.created_at DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String direction = rs.getString("direction");
                BotMessage.Type type = "in".equalsIgnoreCase(direction) ? BotMessage.Type.INCOMING : BotMessage.Type.OUTGOING;
                String telegramId = rs.getString("telegram_id");
                String message = rs.getString("message");
                String createdAt = rs.getString("created_at");
                BotMessage botMessage = new BotMessage(type, telegramId, message, createdAt);
                messages.add(botMessage);
            }
        }
        return messages;
    }

    @Override
    public List<BotMessage> getMessagesByDateRange(String startDate, String endDate) throws Exception {
        List<BotMessage> messages = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT m.direction, u.telegram_id, m.message, m.created_at " +
                         "FROM messages m " +
                         "JOIN users u ON m.user_id = u.id " +
                         "WHERE m.created_at BETWEEN ? AND ? " +
                         "ORDER BY m.created_at DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, startDate + " 00:00:00");
            ps.setString(2, endDate + " 23:59:59");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String direction = rs.getString("direction");
                BotMessage.Type type = "in".equalsIgnoreCase(direction) ? BotMessage.Type.INCOMING : BotMessage.Type.OUTGOING;
                String telegramId = rs.getString("telegram_id");
                String message = rs.getString("message");
                String createdAt = rs.getString("created_at");
                BotMessage botMessage = new BotMessage(type, telegramId, message, createdAt);
                messages.add(botMessage);
            }
        }
        return messages;
    }

    public void addBroadcast(String message) throws Exception {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO broadcasts (message, created_at) VALUES (?, NOW())";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, message);
            ps.executeUpdate();
        }
    }

    public void addMessageOutgoing(int userId, String message) throws Exception {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO messages (user_id, direction, message) VALUES (?, 'out', ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setString(2, message);
            ps.executeUpdate();
        }
    }

    @Override
    public String getRandomTip() throws Exception {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT response FROM keywords WHERE keyword LIKE '%tip%' ORDER BY RAND() LIMIT 1";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String tip = rs.getString("response");
                if (tip == null || tip.isEmpty()) {
                    return "Maaf, tidak ada tips kuliner saat ini.";
                }
                return tip;
            } else {
                return "Maaf, tidak ada tips kuliner saat ini.";
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Gagal mengambil tips kuliner dari database: " + e.getMessage());
        }
    }
}
