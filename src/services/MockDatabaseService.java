/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package services;

import models.Member;
import models.Keyword;
import models.BotMessage;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList; // Thread-safe list

/**
 *
 * @author cahya
 */
public abstract class MockDatabaseService implements DatabaseService {
    // Using CopyOnWriteArrayList for thread safety, as data might be accessed from UI and bot threads
    private final List<Member> members = new CopyOnWriteArrayList<>();
    private final List<Keyword> keywords = new CopyOnWriteArrayList<>();
    private final List<BotMessage> messages = new CopyOnWriteArrayList<>();

    public MockDatabaseService() {
        // Add some dummy data for testing
        members.add(new Member(1, "081234567890", "user1", "123456789", "ver"));
        members.add(new Member(2, "087654321098", "user2", "987654321", "ver"));
        members.add(new Member(3, "085000000000", "bot_tester", "112233445", "ver"));

        // Add some dummy keywords
        keywords.add(new Keyword("ramen", "Ramen pedas adalah salah satu hidangan mie kuah Jepang yang sangat populer."));
        keywords.add(new Keyword("corndog", "Korean Corndog adalah jajanan street food Korea berupa sosis atau keju yang ditusuk."));
        keywords.add(new Keyword("sushi", "Sushi fusion menggabungkan elemen sushi tradisional dengan bahan dan teknik masakan dari budaya lain."));
    }

    @Override
    public List<Member> getAllMembers() throws Exception {
        // Simulate a small delay for database operation
        Thread.sleep(100);
        return new ArrayList<>(members);
    }

    @Override
    public Member getMemberByChatID(String chatID) throws Exception {
        Thread.sleep(50);
        return members.stream()
                      .filter(m -> m.getChatID().equals(chatID))
                      .findFirst()
                      .orElse(null);
    }

    @Override
    public void addMember(Member member) throws Exception {
        Thread.sleep(100);
        if (getMemberByChatID(member.getChatID()) != null) {
            throw new IllegalArgumentException("Anggota dengan Chat ID " + member.getChatID() + " sudah terdaftar.");
        }
        members.add(member);
    }

    @Override
    public void updateMember(String oldChatID, Member updatedMember) throws Exception {
        Thread.sleep(100);
        boolean found = false;
        for (int i = 0; i < members.size(); i++) {
            if (members.get(i).getChatID().equals(oldChatID)) {
                if (!oldChatID.equals(updatedMember.getChatID()) && getMemberByChatID(updatedMember.getChatID()) != null) {
                    throw new IllegalArgumentException("Chat ID baru " + updatedMember.getChatID() + " sudah digunakan oleh anggota lain.");
                }
                members.set(i, updatedMember);
                found = true;
                break;
            }
        }
        if (!found) {
            throw new IllegalArgumentException("Anggota dengan Chat ID " + oldChatID + " tidak ditemukan.");
        }
    }

    @Override
    public void deleteMember(String chatID) throws Exception {
        Thread.sleep(100);
        boolean removed = members.removeIf(m -> m.getChatID().equals(chatID));
        if (!removed) {
            throw new IllegalArgumentException("Anggota dengan Chat ID " + chatID + " tidak ditemukan.");
        }
    }

    @Override
    public List<Keyword> getAllKeywords() throws Exception {
        Thread.sleep(100);
        return new ArrayList<>(keywords);
    }

    @Override
    public void addKeyword(Keyword keyword) throws Exception {
        Thread.sleep(100);
        if (keywords.stream().anyMatch(k -> k.getKeyword().equalsIgnoreCase(keyword.getKeyword()))) {
            throw new IllegalArgumentException("Keyword '" + keyword.getKeyword() + "' sudah ada.");
        }
        keywords.add(keyword);
    }

    @Override
    public void updateKeyword(String oldKeyword, Keyword updatedKeyword) throws Exception {
        Thread.sleep(100);
        boolean found = false;
        for (int i = 0; i < keywords.size(); i++) {
            if (keywords.get(i).getKeyword().equalsIgnoreCase(oldKeyword)) {
                keywords.set(i, updatedKeyword);
                found = true;
                break;
            }
        }
        if (!found) {
            throw new IllegalArgumentException("Keyword '" + oldKeyword + "' tidak ditemukan.");
        }
    }

    @Override
    public void deleteKeyword(String keyword) throws Exception {
        Thread.sleep(100);
        boolean removed = keywords.removeIf(k -> k.getKeyword().equalsIgnoreCase(keyword));
        if (!removed) {
            throw new IllegalArgumentException("Keyword '" + keyword + "' tidak ditemukan.");
        }
    }

    @Override
    public List<BotMessage> getAllMessages() throws Exception {
        Thread.sleep(100);
        return new ArrayList<>(messages);
    }

    @Override
    public List<BotMessage> getMessagesByDateRange(String startDate, String endDate) throws Exception {
        Thread.sleep(100);
        List<BotMessage> filteredMessages = new ArrayList<>();
        for (BotMessage msg : messages) {
            String createdAt = msg.getCreatedAt();
            if (createdAt != null && !createdAt.isEmpty()) {
                // Compare date strings (assuming format "yyyy-MM-dd HH:mm:ss")
                String datePart = createdAt.split(" ")[0];
                if (datePart.compareTo(startDate) >= 0 && datePart.compareTo(endDate) <= 0) {
                    filteredMessages.add(msg);
                }
            }
        }
        return filteredMessages;
    }

    @Override
    public void addMessage(BotMessage message) throws Exception {
        Thread.sleep(50);
        messages.add(message);
    }

    // Implement the new methods from DatabaseService interface
    @Override
    public void addBroadcast(String message) throws Exception {
        // For mock, just log or store in messages list
        System.out.println("Mock addBroadcast called with message: " + message);
    }

    @Override
    public void addMessageOutgoing(int userId, String message) throws Exception {
        // For mock, just log or store in messages list
        System.out.println("Mock addMessageOutgoing called for userId: " + userId + " message: " + message);
    }

    // Implement the missing getRandomTip() method
    @Override
    public String getRandomTip() throws Exception {
        if (keywords.isEmpty()) {
            return "Tidak ada tips tersedia saat ini.";
        }
        int index = (int) (Math.random() * keywords.size());
        return keywords.get(index).getResponse();
    }
}
