package models;

/**
 * Model class representing a keyword and its associated response.
 */
public class Keyword {
    private String keyword;
    private String response;

    public Keyword() {
    }

    public Keyword(String keyword, String response) {
        this.keyword = keyword;
        this.response = response;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public String getResponse() {
        return response;
    }

    public void setResponse(String response) {
        this.response = response;
    }
}
