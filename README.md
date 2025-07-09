# TelegramBot

# 🤖 Telegram Food Recipe Bot (Dashboard Admin)

Proyek ini adalah bot Telegram berbasis Java yang dirancang untuk membantu pengguna menemukan resep masakan Indonesia yang sedang tren, mendapatkan tips memasak, dan merekomendasikan hidangan berdasarkan kategori atau bahan-bahan yang tersedia. Dilengkapi dengan **Dashboard Admin** berbasis Swing yang komprehensif untuk mengelola anggota, kata kunci, melihat riwayat pesan, dan mengirim siaran (broadcast).

-----

## ✨ Fitur-fitur

  * **Interaksi Bot Telegram:**

      * 🔍 **Pencarian Resep:** Cari resep masakan Indonesia berdasarkan nama makanan.
      * 🔥 **Makanan Trending:** Temukan hidangan Indonesia populer dan sedang tren.
      * 🍽️ **Rekomendasi Resep:** Dapatkan rekomendasi berdasarkan kategori (misalnya, pedas, sehat, *cheesy*, manis).
      * 📦 **Pake Bahan yang Ada** untuk saran resep dari bahan yang tersedia.
      * 🧂 **Tips Memasak:** Dapatkan tips memasak secara acak.
      * ✅ **Pendaftaran & Verifikasi Pengguna:** Pengguna baru dapat mendaftar via perintah `/daftar` dan membagikan informasi kontak mereka, menunggu persetujuan admin untuk akses penuh.

### 🛠️ Dashboard Admin
- 🔐 **Login Admin**
- 📋 **Manajemen Anggota**
- 📢 **Broadcast**
- 🧠 **Manajemen Keyword**
- 💬 **Riwayat Pesan**
- 🥘 **Viewer Makanan Trending**


  * **Dashboard Admin (UI Swing):**

      * 🔐 **Sistem Login:** Login aman untuk administrator.
      * 📋 **Manajemen Anggota:** Lihat, tambah, edit, hapus, setujui, dan tolak pendaftaran pengguna.
      * 📢 **Pesan Siaran (Broadcast):** Kirim pesan ke semua pengguna bot yang terverifikasi.
      * 🧠 **Manajemen Kata Kunci:** Tambah, perbarui, dan hapus pasangan kata kunci-respons kustom untuk balasan standar bot.
      * 💬 **Riwayat Pesan:** Lihat log semua pesan masuk dan keluar dengan pengguna.
      * 🍽️ **Penampil Makanan Trending:** Lihat daftar makanan trending terkini yang diambil oleh bot.
      * 🔒 **Perlindungan Instansi Tunggal:** Memastikan hanya satu instansi dashboard admin (dan bot) yang dapat berjalan pada satu waktu.

-----

## 🚀 Memulai Proyek

Petunjuk ini akan membantumu mendapatkan salinan proyek ini dan menjalankannya di mesin lokalmu untuk keperluan pengembangan dan pengujian.

### Prasyarat

  * **Java Development Kit (JDK) 8 atau yang lebih baru:** Pastikan Java sudah terinstal dan terkonfigurasi di sistemmu.
  * **Database MySQL:** Proyek ini menggunakan MySQL untuk menyimpan data pengguna, pesan, dan kata kunci.
  * **Apache Maven (Opsional tapi Direkomendasikan):** Untuk manajemen dependensi dan *build* yang mudah.
  * **Token Bot Telegram:** Dapatkan token bot dari [@BotFather](https://t.me/BotFather) di Telegram.
  * **ID Chat Admin Telegram:** Untuk menerima notifikasi pendaftaran pengguna, kamu memerlukan ID Chat Telegram-mu sendiri. Kamu bisa mendapatkannya dari bot seperti `@userinfobot`.

### Pengaturan Database

1.  **Buat database MySQL** dengan nama `telegram_chatbot`.

2.  **Jalankan skema SQL berikut** untuk membuat tabel-tabel yang diperlukan:

    ```sql
    -- Tabel untuk pengguna bot (anggota)
    CREATE TABLE users (
        id INT AUTO_INCREMENT PRIMARY KEY,
        telegram_id VARCHAR(255) UNIQUE NOT NULL,
        username VARCHAR(255),
        phone VARCHAR(20),
        status VARCHAR(50) DEFAULT 'unv', -- 'unv' (belum terverifikasi), 'pending', 'verified', 'blocked'
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

    -- Tabel untuk pasangan kata kunci-respons
    CREATE TABLE keywords (
        id INT AUTO_INCREMENT PRIMARY KEY,
        keyword VARCHAR(255) UNIQUE NOT NULL,
        response TEXT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

    -- Tabel untuk mencatat pesan
    CREATE TABLE messages (
        id INT AUTO_INCREMENT PRIMARY KEY,
        user_id INT,
        direction ENUM('in', 'out') NOT NULL, -- 'in' untuk masuk, 'out' untuk keluar
        message TEXT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users(id)
    );

    -- Tabel untuk pesan siaran yang dikirim dari panel admin
    CREATE TABLE broadcasts (
        id INT AUTO_INCREMENT PRIMARY KEY,
        message TEXT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

    -- Tabel untuk pengguna admin (untuk login dashboard)
    CREATE TABLE admins (
        id INT AUTO_INCREMENT PRIMARY KEY,
        username VARCHAR(100) UNIQUE NOT NULL,
        password VARCHAR(255) NOT NULL, -- Simpan MD5 hash
        nama_lengkap VARCHAR(255),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

    -- Masukkan pengguna admin default (password 'admin' MD5 hash adalah 21232f297a57a5a743894a0e4a801fc3)
    INSERT INTO admins (username, password, nama_lengkap) VALUES ('admin', '21232f297a57a5a743894a0e4a801fc3', 'Administrator');

    -- Masukkan beberapa tips awal (opsional, untuk getRandomTip)
    INSERT INTO keywords (keyword, response) VALUES ('tip_umum', 'Pastikan untuk selalu mencicipi masakan Anda di setiap langkah untuk menyesuaikan rasa.');
    INSERT INTO keywords (keyword, response) VALUES ('tip_rempah', 'Sangrai rempah utuh sebelum dihaluskan untuk aroma yang lebih kuat.');
    INSERT INTO keywords (keyword, response) VALUES ('tip_daging', 'Istirahatkan daging setelah dimasak agar sarinya menyebar dan daging lebih empuk.');
    ```

### Pengaturan Proyek

1.  **Kloning repositori:**
    ```bash
    git clone https://github.com/your-username/telegram-food-recipe-bot.git
    cd telegram-food-recipe-bot
    ```
2.  **Konfigurasi Koneksi Database:**
    * Buka `src/main/java/db/DBConnection.java`.
    * Perbarui `DB_URL`, `DB_USER`, dan `DB_PASS` dengan kredensial database MySQL-mu.
    ```java
    private static final String DB_URL = "jdbc:mysql://localhost:3306/telegram_chatbot";
    private static final String DB_USER = "root";
    private static final String DB_PASS = ""; // Kata sandi MySQL-mu
    ```
3.  **Konfigurasi Token Bot dan Username:**
    * Buka `src/main/java/telegrambot/TelegramBot.java`.
    * Perbarui `getBotUsername()` dan `getBotToken()`:
    ```java
    @Override
    public String getBotUsername() {
        return "NamaPenggunaBotmu"; // Contoh: "MyResepBot"
    }

    @Override
    public String getBotToken() {
        return "TOKEN_BOT_ANDA_DI_SINI"; // Contoh: "123456:ABC-DEF1234ghIkl-zyx57W2E1u"
    }
    ```
    * Juga, perbarui di `TelegramBotService.java`:
    ```java
    String botToken = "TOKEN_BOT_ANDA_DI_SINI";
    String botUsername = "NamaPenggunaBotmu";
    ```
4.  **Atur ID Chat Admin:**
    ```java
    long[] adminChatIds = {ID_CHAT_ADMIN_ANDA_DI_SINI_SEBAGAI_LONG}; // Contoh: {123456789L}
    ```
5.  **Tambahkan Dataset JSON:**
    - Buat folder `dataset/` dan tambahkan file seperti `Indonesian_Food.json`, `pedas.json`, `sehat.json`, dll.

### Build dan Jalankan

#### Dengan Maven
```bash
mvn clean install
mvn exec:java -Dexec.mainClass="ui.FrmLogin"
```

####
```bash
Tanpa Maven
javac -d out -cp "lib/*" src/main/java/**/*.java
java -cp "out:lib/*" ui.FrmLogin
```

## 📚 Referensi

- [Telegram Bot API](https://core.telegram.org/bots/api)
- [TelegramBots (Java Library)](https://github.com/rubenlagus/TelegramBots)
- [Dataset Resep Indonesia - Kaggle](https://www.kaggle.com/datasets/canggih/indonesian-food-recipes)
- [Gson Docs](https://github.com/google/gson/blob/master/UserGuide.md)
- [Baeldung JDBC Java](https://www.baeldung.com/java-jdbc)

---

## 🤝 Kontribusi

1. Fork repositori
2. Buat branch: `feature/namafitur`
3. Commit: `git commit -m "Tambah fitur"`
4. Pull Request

---

