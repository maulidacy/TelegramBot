package bot;

import models.Recipe;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.ArrayList;

public class ResponTopikService {

    public static List<IndonesianFoodLoader.Food> getFoodList() {
        loadFoodList();
        return foodList;
    }

    private static List<IndonesianFoodLoader.Food> foodList = null;

    private static void loadFoodList() {
        if (foodList != null) {
            return;
        }
        try {
            foodList = IndonesianFoodLoader.searchFoods("");
        } catch (Exception e) {
            e.printStackTrace();
            foodList = new ArrayList<>();
        }
    }

    public static void reloadFoodList() {
        foodList = null;
        loadFoodList();
    }

    public static String searchRecipesByKeyword(String userInput) {
        loadFoodList();
        if (userInput == null || userInput.trim().isEmpty()) {
            return "Masukkan kata kunci untuk mencari resep.";
        }
        String keyword = extractKeyword(userInput);
        List<IndonesianFoodLoader.Food> matchedFoods = new ArrayList<>();
        String keywordLower = keyword.toLowerCase();

        for (IndonesianFoodLoader.Food food : foodList) {
            if (food.title != null && food.title.toLowerCase().contains(keywordLower)) {
                matchedFoods.add(food);
            }
        }

        if (matchedFoods.isEmpty()) {
            return "Maaf, tidak ditemukan resep untuk kata kunci \"" + keyword + "\".";
        } else if (matchedFoods.size() == 1) {
            return getRecipeDetails(matchedFoods.get(0).title);
        } else {
            StringBuilder sb = new StringBuilder();
            sb.append("Ditemukan beberapa resep untuk \"").append(keyword).append("\":\n");
            for (int i = 0; i < matchedFoods.size(); i++) {
                sb.append(i + 1).append(". ").append(matchedFoods.get(i).title).append("\n");
            }
            sb.append("Ketik nomor resep untuk melihat detail.");
            return sb.toString();
        }
    }

    // Removed duplicate method searchFoodsByKeywordList to fix compilation error

    public static List<IndonesianFoodLoader.Food> searchRecipesByIngredients(String ingredients) {
        loadFoodList();
        List<IndonesianFoodLoader.Food> matchedFoods = new ArrayList<>();
        List<String> ingredientList = new ArrayList<>();
        for (String ing : ingredients.toLowerCase().split(",")) {
            ingredientList.add(ing.trim());
        }
        for (IndonesianFoodLoader.Food food : foodList) {
            String foodIngredients = food.ingredients.toLowerCase();
            boolean allMatch = true;
            for (String ing : ingredientList) {
                if (!foodIngredients.contains(ing)) {
                    allMatch = false;
                    break;
                }
            }
            if (allMatch) {
                matchedFoods.add(food);
            }
        }
        return matchedFoods;
    }

    public static List<IndonesianFoodLoader.Food> searchFoodsByKeywordList(String keyword) {
        loadFoodList();
        String keywordLower = keyword.toLowerCase();
        List<IndonesianFoodLoader.Food> matchedFoods = new ArrayList<>();
        for (IndonesianFoodLoader.Food food : foodList) {
            if (food.title != null && food.title.toLowerCase().contains(keywordLower)) {
                matchedFoods.add(food);
            }
        }
        return matchedFoods;
    }

    public static String extractKeyword(String userInput) {
        // Simple extraction: remove common phrases like "aku mau masak", "saya ingin masak", etc.
        String lower = userInput.toLowerCase();
        lower = lower.replaceAll("aku mau masak", "");
        lower = lower.replaceAll("saya ingin masak", "");
        lower = lower.replaceAll("mau masak", "");
        lower = lower.replaceAll("masak", "");
        lower = lower.trim();
        return lower;
    }

    public static boolean fuzzyMatch(String text, String keyword) {
        // Improved fuzzy match using Levenshtein distance from IndonesianFoodLoader
        try {
            int distance = bot.IndonesianFoodLoader.levenshteinDistance(text, keyword);
            int threshold = 5; // increased threshold from 3 to 5
            return distance <= threshold || text.contains(keyword);
        } catch (Exception e) {
            // fallback to contains if error occurs
            return text.contains(keyword);
        }
    }

    private static String formatFoodListResponse(List<IndonesianFoodLoader.Food> foods, String keyword) {
        if (foods == null || foods.isEmpty()) {
            return "Maaf, tidak ditemukan makanan terkait \"" + keyword + "\".";
        }
        StringBuilder sb = new StringBuilder();
        sb.append("Daftar makanan terkait \"").append(keyword).append("\":\n");
        IntStream.range(0, foods.size()).forEach(i -> {
            sb.append(i + 1).append(". ").append(foods.get(i).title).append("\n");
        });
        sb.append("Ketik nomor makanan untuk melihat detail.");
        return sb.toString();
    }

    private static String escapeMarkdown(String text) {
        if (text == null) {
            return "";
        }
        return text.replace("_", "\\_")
                   .replace("*", "\\*")
                   .replace("[", "\\[")
                   .replace("]", "\\]")
                   .replace("(", "\\(")
                   .replace(")", "\\)")
                   .replace("~", "\\~")
                   .replace("`", "\\`")
                   .replace(">", "\\>")
                   .replace("#", "\\#")
                   .replace("+", "\\+")
                   .replace("-", "\\-")
                   .replace("=", "\\=")
                   .replace("|", "\\|")
                   .replace("{", "\\{")
                   .replace("}", "\\}")
                   .replace(".", "\\.")
                   .replace("!", "\\!");
    }

    private static String formatFoodDetailResponse(IndonesianFoodLoader.Food food) {
        if (food == null) {
            return "Maaf, detail makanan tidak ditemukan.";
        }
        String escapedUrl = escapeMarkdown(food.url);
        String imageSection = "";
        // Check if food has an image field (assuming added)
        try {
            java.lang.reflect.Field imageField = food.getClass().getDeclaredField("image");
            imageField.setAccessible(true);
            Object imageValue = imageField.get(food);
            if (imageValue != null && !imageValue.toString().isEmpty()) {
                imageSection = "\n\n🖼️ Gambar: " + imageValue.toString();
            }
        } catch (Exception e) {
            // No image field or error, ignore
        }
        return String.format(
            "🍽️ *%s*\n\n" +
            "📂 Kategori: %s\n" +
            "📝 Deskripsi: %s\n\n" +
            "📋 Bahan-bahan:\n%s\n\n" +
            "📖 Cara membuat:\n%s%s\n\n" +
            "🔗 Sumber: [%s](%s)",
            food.title,
            food.category,
            food.description,
            food.ingredients,
            food.steps,
            imageSection,
            escapedUrl,
            food.url
        );
    }

    public static String getTrendingFoodsFromJson() {
        loadFoodList();
        List<IndonesianFoodLoader.Food> trendingFoods = foodList.stream()
            .filter(f -> f.trending)
            .collect(Collectors.toList());
        if (trendingFoods.isEmpty()) {
            return "Maaf, tidak ada makanan trending saat ini.";
        }
        StringBuilder sb = new StringBuilder();
        sb.append("🔥 *MAKANAN TRENDING BULAN INI* 🔥\n");
        IntStream.range(0, trendingFoods.size()).forEach(i -> {
            sb.append(i + 1).append(". ").append(trendingFoods.get(i).title).append("\n");
        });
        sb.append("Ketik nomor makanan untuk melihat detail.");
        return sb.toString();
    }

    public static List<IndonesianFoodLoader.Food> getTrendingFoodsList() {
        loadFoodList();
        return foodList.stream()
            .filter(f -> f.trending)
            .collect(Collectors.toList());
    }

    public static String getRecipeListByKeyword(String keyword) {
        loadFoodList();
        List<IndonesianFoodLoader.Food> matchedFoods = foodList.stream()
            .filter(f -> f.title.toLowerCase().contains(keyword.toLowerCase()))
            .collect(Collectors.toList());
        return formatFoodListResponse(matchedFoods, keyword);
    }

    public static String getRecipeDetails(String title) {
        loadFoodList();
        String trimmedTitle = title.trim();
        for (IndonesianFoodLoader.Food food : foodList) {
            if (food.title != null && food.title.trim().equalsIgnoreCase(trimmedTitle)) {
                return formatFoodDetailResponse(food);
            }
        }
        return "Maaf, detail makanan untuk '" + title + "' tidak ditemukan.";
    }

    // Deprecated method to avoid compilation error in TelegramBot.java
    public static String getRecipe(String name) {
        return getRecipeDetails(name);
    }
}
