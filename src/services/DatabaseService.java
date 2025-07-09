/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package services;

import models.Member;
import models.Keyword;
import models.BotMessage;
import java.util.List;
/**
 *
 * @author cahya
 */
import java.util.List;
import models.Member;

public interface DatabaseService {
    List<Member> getAllMembers() throws Exception;

    void addBroadcast(String message) throws Exception;

    void addMessageOutgoing(int userId, String message) throws Exception;
    Member getMemberByChatID(String chatID) throws Exception;
    void addMember(Member member) throws Exception;
    void updateMember(String oldChatID, Member updatedMember) throws Exception;
    void deleteMember(String chatID) throws Exception;

    // New method to update member status
    void updateMemberStatus(String chatID, String status) throws Exception;

    List<Keyword> getAllKeywords() throws Exception;
    void addKeyword(Keyword keyword) throws Exception;
    void updateKeyword(String oldKeyword, Keyword updatedKeyword) throws Exception;
    void deleteKeyword(String keyword) throws Exception;

    List<BotMessage> getAllMessages() throws Exception;
    void addMessage(BotMessage message) throws Exception;

    // New method for date range filtered messages
    List<BotMessage> getMessagesByDateRange(String startDate, String endDate) throws Exception;

    // New method to get a random tip from keywords table
    String getRandomTip() throws Exception;
}
