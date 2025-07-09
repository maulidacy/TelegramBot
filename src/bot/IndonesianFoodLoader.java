package bot;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.io.FileReader;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class IndonesianFoodLoader {

    public static class Food {
        public String title;
        public String category;
        public String description;
        public String ingredients;
        public String steps;
        public String url;
        public boolean trending = false;
    }

    private static final String JSON_PATH = "dataset/Indonesian_Food.json";
    private static final String TRENDING_JSON_PATH = "dataset/new_trending_foods.json";

    private static List<Food> foodList = null;

    public static void loadFoodData() throws Exception {
        if (foodList != null) {
            return; // already loaded
        }
        Gson gson = new Gson();
        Type listType = new TypeToken<List<Food>>() {}.getType();
        List<Food> mainList = new ArrayList<>();
        List<Food> trendingList = new ArrayList<>();
        try (var reader = IndonesianFoodLoader.class.getClassLoader().getResourceAsStream(JSON_PATH)) {
            if (reader == null) {
                System.err.println("Resource not found: " + JSON_PATH);
                // Fallback to load from filesystem
                try (var fileReader = new java.io.FileReader(JSON_PATH)) {
                    mainList = gson.fromJson(fileReader, listType);
                    System.out.println("Loaded main food data from filesystem fallback: " + JSON_PATH);
                } catch (Exception ex) {
                    System.err.println("Fallback loading from filesystem failed: " + ex.getMessage());
                    ex.printStackTrace();
                }
            } else {
                java.io.InputStreamReader isr = new java.io.InputStreamReader(reader);
                mainList = gson.fromJson(isr, listType);
                System.out.println("Loaded main food data from resource: " + JSON_PATH);
            }
        } catch (Exception e) {
            System.err.println("Error loading food data from JSON: " + e.getMessage());
            e.printStackTrace();
        }
        System.out.println("Loaded main food titles:");
        for (Food food : mainList) {
            System.out.println(" - " + food.title);
        }
        try (var readerTrending = IndonesianFoodLoader.class.getClassLoader().getResourceAsStream(TRENDING_JSON_PATH)) {
            if (readerTrending == null) {
                System.err.println("Resource not found: " + TRENDING_JSON_PATH);
                // Fallback to load from filesystem
                try (var fileReaderTrending = new java.io.FileReader(TRENDING_JSON_PATH)) {
                    trendingList = gson.fromJson(fileReaderTrending, listType);
                    System.out.println("Loaded trending food data from filesystem fallback: " + TRENDING_JSON_PATH);
                } catch (Exception ex) {
                    System.err.println("Fallback loading trending from filesystem failed: " + ex.getMessage());
                    ex.printStackTrace();
                }
            } else {
                java.io.InputStreamReader isrTrending = new java.io.InputStreamReader(readerTrending);
                trendingList = gson.fromJson(isrTrending, listType);
                System.out.println("Loaded trending food data from resource: " + TRENDING_JSON_PATH);
            }
        } catch (Exception e) {
            System.err.println("Error loading trending food data from JSON: " + e.getMessage());
            e.printStackTrace();
        }
        System.out.println("Loaded trending food titles:");
        for (Food food : trendingList) {
            System.out.println(" - " + food.title);
        }
        // Merge lists, avoid duplicates by normalized title
        for (Food trendingFood : trendingList) {
            boolean exists = false;
            String trendingTitleNormalized = trendingFood.title == null ? "" : trendingFood.title.trim().toLowerCase();
            for (Food mainFood : mainList) {
                String mainTitleNormalized = mainFood.title == null ? "" : mainFood.title.trim().toLowerCase();
                if (!mainTitleNormalized.isEmpty() && mainTitleNormalized.equals(trendingTitleNormalized)) {
                    exists = true;
                    break;
                }
            }
            if (!exists) {
                mainList.add(trendingFood);
            }
        }
        foodList = mainList;
    }

    public static void clearCache() {
        foodList = null;
    }

    public static List<Food> searchFoods(String keyword) throws Exception {
        loadFoodData();
        String lowerKeyword = keyword.toLowerCase();
        return foodList.stream()
                .filter(f -> f.title.toLowerCase().contains(lowerKeyword))
                .collect(Collectors.toList());
    }

    // New method for fuzzy search using Levenshtein distance
    public static List<Food> searchFoodsFuzzy(String keyword) throws Exception {
        loadFoodData();
        String lowerKeyword = keyword.toLowerCase();
        List<Food> results = new ArrayList<>();
        int threshold = 3; // max distance allowed for fuzzy match

        for (Food food : foodList) {
            String titleLower = food.title.toLowerCase();
            int distance = levenshteinDistance(lowerKeyword, titleLower);
            if (distance <= threshold || titleLower.contains(lowerKeyword)) {
                results.add(food);
            }
        }
        return results;
    }

    // Levenshtein distance implementation
    public static int levenshteinDistance(String s1, String s2) {
        int[] costs = new int[s2.length() + 1];
        for (int i = 0; i <= s2.length(); i++) {
            costs[i] = i;
        }
        for (int i = 1; i <= s1.length(); i++) {
            costs[0] = i;
            int nw = i - 1;
            for (int j = 1; j <= s2.length(); j++) {
                int cj = Math.min(1 + Math.min(costs[j], costs[j - 1]),
                        s1.charAt(i - 1) == s2.charAt(j - 1) ? nw : nw + 1);
                nw = costs[j];
                costs[j] = cj;
            }
        }
        return costs[s2.length()];
    }

    public static List<Food> getTrendingFoods() throws Exception {
        loadFoodData();
        return foodList.stream()
                .filter(f -> f.trending)
                .collect(Collectors.toList());
    }

    public static Food getFoodByTitle(String title) throws Exception {
        loadFoodData();
        String lowerTitle = title.toLowerCase();
        for (Food f : foodList) {
            if (f.title.toLowerCase().equals(lowerTitle)) {
                return f;
            }
        }
        return null;
    }
}
