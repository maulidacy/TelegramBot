package models;

/**
 * Model class representing a bot message for logging purposes.
 */
public class BotMessage {
    public enum Type {
        INCOMING,
        OUTGOING
    }

    private Type type;
    private String chatID;
    private String message;
    private String createdAt;

    public BotMessage() {
    }

    public BotMessage(Type type, String chatID, String message, String createdAt) {
        this.type = type;
        this.chatID = chatID;
        this.message = message;
        this.createdAt = createdAt;
    }

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    public String getChatID() {
        return chatID;
    }

    public void setChatID(String chatID) {
        this.chatID = chatID;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }
}
