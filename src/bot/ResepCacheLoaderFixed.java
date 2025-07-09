package bot;

import com.opencsv.CSVReader;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.io.*;
import java.lang.reflect.Type;
import java.nio.file.*;
import java.util.*;

public class ResepCacheLoaderFixed {

    public static class Resep {
        public String title;
        public String ingredients;
        public String steps;
        public String url;
        public String category;
    }

    private static final String CSV_PATH = "dataset/Indonesian_Food_Recipes.csv";
    private static final String JSON_PATH = "dataset/resep_cache.json";

    public static void generateJsonCache() throws Exception {
        List<Resep> resepList = new ArrayList<>();

        try (CSVReader reader = new CSVReader(new FileReader(CSV_PATH))) {
            String[] line;
            reader.readNext(); // skip header
            while ((line = reader.readNext()) != null) {
                if (line.length >= 6) {
                    Resep r = new Resep();
                    r.title = line[0].trim();
                    r.ingredients = line[1].trim();
                    r.steps = line[2].trim();
                    r.url = line[4].trim();
                    r.category = line[5].trim();
                    resepList.add(r);
                }
            }
        }

        Gson gson = new Gson();
        String json = gson.toJson(resepList);
        Files.write(Paths.get(JSON_PATH), json.getBytes());

        System.out.println("✅ JSON cache dibuat di " + JSON_PATH);
    }

    public static List<Resep> loadCachedResep() throws Exception {
        String json = Files.readString(Paths.get(JSON_PATH));
        Type listType = new TypeToken<List<Resep>>() {}.getType();
        return new Gson().fromJson(json, listType);
    }

    public static void main(String[] args) throws Exception {
        generateJsonCache();
        List<Resep> hasil = loadCachedResep();
        System.out.println("Contoh: " + hasil.get(0).title);
    }
}
