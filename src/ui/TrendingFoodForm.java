package ui;

import bot.ResponTopikService;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

/**
 * GUI form to display trending food data fetched from ResponTopikService API.
 */
public class TrendingFoodForm extends JFrame {

    private JTextArea textArea;
    private JButton btnRefresh;

    public TrendingFoodForm() {
        setTitle("Trending Food");
        setSize(500, 400);
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        setLocationRelativeTo(null);

        textArea = new JTextArea();
        textArea.setEditable(false);
        textArea.setLineWrap(true);
        textArea.setWrapStyleWord(true);

        btnRefresh = new JButton("Refresh Trending Food");
        btnRefresh.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                loadTrendingFood();
            }
        });

        getContentPane().setLayout(new BorderLayout());
        getContentPane().add(new JScrollPane(textArea), BorderLayout.CENTER);
        getContentPane().add(btnRefresh, BorderLayout.SOUTH);

        loadTrendingFood();
    }

    private void loadTrendingFood() {
        String trendingFood = ResponTopikService.getTrendingFoodsFromJson();
        if (trendingFood == null || trendingFood.isEmpty() || trendingFood.contains("Gagal")) {
            // fallback to database keywords
            trendingFood = loadTrendingFoodFromDatabase();
        }
        textArea.setText(trendingFood);
    }

    private String loadTrendingFoodFromDatabase() {
        StringBuilder sb = new StringBuilder();
        try (java.sql.Connection conn = db.DBConnection.getConnection()) {
            java.sql.PreparedStatement ps = conn.prepareStatement("SELECT response FROM keywords LIMIT 5");
            java.sql.ResultSet rs = ps.executeQuery();
            sb.append("🍽️ Trending Food from Database:\n\n");
            while (rs.next()) {
                sb.append("- ").append(rs.getString("response")).append("\n");
            }
        } catch (Exception e) {
            sb.append("Gagal mengambil data dari database: ").append(e.getMessage());
        }
        return sb.toString();
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            TrendingFoodForm form = new TrendingFoodForm();
            form.setVisible(true);
        });
    }
}
