-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 05 Jul 2025 pada 09.13
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `telegram_chatbot`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nama_lengkap` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `admins`
--

INSERT INTO `admins` (`id`, `username`, `password`, `nama_lengkap`, `created_at`) VALUES
(1, 'maulida', '0192023a7bbd73250516f069df18b500', 'Alo Maul', '2025-06-27 23:24:26');

-- --------------------------------------------------------

--
-- Struktur dari tabel `broadcasts`
--

CREATE TABLE `broadcasts` (
  `id` int(11) NOT NULL,
  `message` text NOT NULL,
  `sent_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `broadcast_targets`
--

CREATE TABLE `broadcast_targets` (
  `id` int(11) NOT NULL,
  `broadcast_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` enum('sent','failed') DEFAULT 'sent'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `keywords`
--

CREATE TABLE `keywords` (
  `id` int(11) NOT NULL,
  `keyword` varchar(255) NOT NULL,
  `response` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `keywords`
--

INSERT INTO `keywords` (`id`, `keyword`, `response`) VALUES
(1, 'halo', 'Halo! Ada yang bisa saya bantu?'),
(2, 'makanan', 'Makanan favorit saya adalah nasi goreng!'),
(3, 'menu', 'Menu hari ini tersedia nasi goreng, mie ayam, dan sate.'),
(4, 'terima kasih', 'Sama-sama! Senang bisa membantu.'),
(5, 'bantuan', 'Silakan ketik pertanyaan Anda, saya akan mencoba membantu.'),
(6, 'tips', '🧂 Gunakan api kecil saat menumis bumbu agar lebih harum dan matang. Tambahkan sedikit gula untuk menyeimbangkan rasa.'),
(7, 'tips', '🍳 Pastikan wajan benar-benar panas sebelum menggoreng agar hasil tidak lembek.'),
(8, 'tips', '🥩 Pukul daging dengan alat pemukul sebelum dimasak untuk hasil lebih empuk.'),
(9, 'tips', '🍚 Tambahkan minyak kelapa ke nasi putih agar lebih pulen dan harum.'),
(10, 'tips', '🥬 Simpan daun bawang dalam botol tertutup di kulkas agar tahan lebih lama.'),
(11, 'tips', '🍞 Roti tawar keras? Kukus sebentar agar kembali empuk!'),
(12, 'tips', '🧄 Tumis bawang putih lebih dulu daripada bawang merah agar aroma lebih keluar.'),
(13, 'tips', '🧊 Masukkan cabai ke freezer agar awet dan tidak mudah busuk.'),
(14, 'tips', '🥚 Rebus telur dengan sedikit garam agar cangkangnya mudah dikupas.'),
(15, 'tips', '🧂 Tambahkan sedikit cuka ke dalam air rebusan agar sayur tetap hijau.'),
(16, 'tips', '🍗 Gunakan air kelapa untuk merebus ayam agar lebih gurih.'),
(17, 'tips', '🥘 Tambahkan asam jawa untuk memperkuat rasa kuah sayur asem.'),
(18, 'tips', '🍛 Jangan terlalu sering membuka tutup panci saat memasak nasi agar hasilnya matang merata.'),
(19, 'tips', '🧴 Gunakan minyak wijen di akhir masakan untuk aroma khas oriental.'),
(20, 'tips', '🍠 Kukus singkong sebelum digoreng agar lebih lembut di dalam.'),
(21, 'tips', '🧂 Campurkan garam ke tepung goreng agar hasil lebih renyah dan berasa.'),
(22, 'tips', '🌽 Blender jagung bersama susu kental untuk membuat jasuke (jagung susu keju) yang creamy.'),
(23, 'tips', '🥫 Simpan sisa saus kalengan di wadah kaca agar tidak berkarat dan tahan lama.'),
(24, 'tips', '🍳 Tambahkan sedikit air ke telur dadar agar hasilnya lebih fluffy.'),
(25, 'tips', '🧊 Gunakan air es saat mengadon tepung goreng untuk hasil renyah tahan lama.'),
(26, 'tips', '🧅 Iris bawang dengan pisau tajam agar tidak banyak air mata.'),
(27, 'tips', '🥣 Gunakan kaldu bubuk tanpa MSG untuk rasa lebih sehat dan ringan.'),
(28, 'tips', '🧽 Cuci beras hingga air bening untuk menghilangkan sisa zat kimia dan pati berlebih.'),
(29, 'tips', '🥦 Rendam brokoli dalam air garam agar ulat dan kotoran keluar.'),
(30, 'tips', '🧀 Simpan keju di dalam kertas roti agar tidak lembab dan berjamur.'),
(31, 'tips', '🥥 Parutan kelapa bisa dibekukan agar awet hingga 1 minggu.'),
(32, 'tips', '🍋 Gunakan perasan lemon untuk mengurangi bau amis ikan sebelum digoreng.'),
(33, 'tips', '🥔 Rebus kentang dengan kulitnya agar kandungan nutrisi tetap terjaga.'),
(34, 'tips', '🍜 Tambahkan bawang goreng dan seledri untuk memperkaya rasa bakso.'),
(35, 'tips', '🍰 Simpan kue dalam wadah kedap udara agar tidak cepat kering.'),
(36, 'tips', '🥓 Panggang sosis dengan sedikit minyak agar lebih kering dan gurih.'),
(37, 'tips', '🥕 Parut wortel dan simpan di toples kaca untuk bekal sup mingguan.'),
(38, 'tips', '🧊 Es batu dari air matang lebih bening dan tahan lama di freezer.'),
(39, 'tips', '🌶️ Jangan terlalu sering membalik gorengan agar tidak menyerap minyak.'),
(40, 'tips', '🥬 Masukkan sayur hijau saat air mendidih, bukan dari awal, agar tetap segar.'),
(41, 'tips', '🍮 Tambahkan sedikit vanila untuk memperkaya aroma adonan kue.'),
(42, 'tips', '🧂 Garam bisa menyerap bau tak sedap di kulkas jika diletakkan di mangkuk terbuka.'),
(43, 'tips', '🍫 Simpan coklat di suhu ruang, bukan kulkas, agar tidak mengembun dan berubah rasa.'),
(44, 'tips', '🍚 Untuk nasi goreng yang enak, gunakan nasi dingin sisa semalam.'),
(45, 'tips', '🍗 Balur ayam goreng dengan margarin sebelum dipanggang untuk kulit renyah.'),
(46, 'tips', '🧄 Cincang bawang putih dengan garam agar tidak lengket di pisau.'),
(47, 'tips', '🍝 Tambahkan minyak zaitun ke pasta agar tidak menempel saat ditiriskan.'),
(48, 'tips', '🧊 Letakkan nasi panas di dekat kipas sebelum disimpan di kulkas agar tidak basi.'),
(49, 'tips', '🍋 Peras jeruk nipis ke atas seafood agar rasanya lebih segar.'),
(50, 'tips', '🧽 Gunakan spons khusus dapur untuk mencuci peralatan agar tidak kontaminasi sabun biasa.'),
(51, 'tips', '🧂 Taburi sedikit garam di talenan agar tidak licin saat memotong.'),
(52, 'tips', '🥣 Tambahkan santan terakhir saat membuat sayur agar tidak pecah minyak.'),
(53, 'tips', '🍲 Rebus tulang sapi minimal 3 jam agar kaldunya maksimal.'),
(54, 'tips', '🥛 Tambahkan sedikit susu cair untuk melembutkan mashed potato.'),
(55, 'tips', '🍜 Masukkan mie ke air mendidih, bukan saat masih dingin agar hasil kenyal.'),
(56, 'tips', '🥢 Gunakan sumpit bambu saat menggoreng gorengan kecil agar lebih mudah dibalik.'),
(57, 'tips', '🧅 Rendam bawang bombay di air dingin agar tidak terlalu pedas di salad.'),
(58, 'tips', '🥘 Jangan menutup panci saat menggoreng agar tidak timbul uap minyak berlebih.'),
(59, 'tips', '🥫 Simpan bahan kering seperti tepung dan gula di wadah kedap udara.'),
(60, 'tips', '🍠 Gunakan oven toaster kecil untuk memanggang camilan tanpa listrik besar.'),
(61, 'tips', '🍶 Simpan minyak goreng bekas yang sudah disaring dalam botol khusus agar bisa dipakai ulang.'),
(62, 'tips', '🍰 Tambahkan telur satu per satu saat membuat adonan cake untuk tekstur merata.'),
(63, 'tips', '🥣 Gunakan whisk logam untuk mengocok putih telur agar lebih kaku.'),
(64, 'tips', '🥘 Tambahkan sedikit terasi saat membuat sambal agar lebih gurih.'),
(65, 'tips', '🍞 Masukkan roti ke oven beberapa menit agar teksturnya kembali garing.'),
(66, 'tips', '🧊 Gunakan gelas stainless untuk membuat es kopi agar dinginnya tahan lama.'),
(67, 'tips', '🌽 Tambahkan sedikit margarin ke jagung rebus untuk rasa gurih alami.'),
(68, 'tips', '🍯 Simpan madu di tempat gelap dan tidak lembab agar tidak mengkristal.'),
(69, 'tips', '🍳 Pecahkan telur di mangkuk terpisah sebelum masuk ke adonan untuk cegah telur busuk.'),
(70, 'tips', '🥩 Gunakan potongan daging yang sesuai: brisket untuk rawon, tenderloin untuk steak.'),
(71, 'tips', '🧂 Tambahkan garam di akhir saat masak sup agar rasa tidak over jika kuah menyusut.'),
(72, 'tips', '🥬 Jangan mencuci jamur dengan air terlalu lama, cukup lap lembab agar tidak lembek.'),
(73, 'tips', '🍜 Sajikan mie ramen dengan telur setengah matang dan daun bawang agar lebih autentik.'),
(74, 'tips', '🧊 Letakkan nasi di wadah datar sebelum disimpan agar cepat dingin dan tidak basi.'),
(75, 'tips', '🍗 Tusuk-tusuk ayam bakar sebelum dipanggang agar bumbu meresap hingga dalam.'),
(76, 'tips', '🥣 Gunakan saringan halus untuk mendapatkan kaldu bening.'),
(77, 'tips', '🍚 Simpan nasi di rice cooker dengan mode hangat, bukan memasak ulang, agar tidak kering.'),
(78, 'tips', '🧄 Goreng bawang putih dengan api kecil agar hasilnya renyah dan tidak pahit.'),
(79, 'tips', '🥘 Untuk tumisan sayur, masukkan garam terakhir agar warna tetap cerah.'),
(80, 'tips', '🥥 Tambahkan parutan kelapa muda ke dalam kue tradisional agar lebih legit.'),
(81, 'tips', '🍤 Cuci udang dengan air jeruk nipis untuk mengurangi bau amis.'),
(82, 'tips', '🍛 Sajikan nasi uduk dengan daun pandan dan taburan bawang goreng agar harum maksimal.'),
(83, 'tips', '🧅 Simpan bawang merah dan putih di tempat sejuk dan kering agar tidak cepat tumbuh tunas.'),
(84, 'tips', '🍚 Gunakan sisa nasi untuk membuat nasi goreng agar tidak mubazir.'),
(85, 'tips', '🍳 Gunakan margarin atau mentega untuk aroma khas telur dadar restoran.'),
(86, 'tips', '🍜 Rebus mie instan terpisah dari bumbunya agar kuah tidak berminyak.'),
(87, 'tips', '🍶 Gunakan botol semprot minyak untuk menumis dengan minyak lebih sedikit (lebih sehat).'),
(88, 'tips', '🥗 Tambahkan perasan lemon pada salad buah agar segar dan tidak cepat coklat.'),
(89, 'tips', '🥣 Masak sup dengan api kecil di akhir proses untuk menjaga rasa kaldu tetap stabil.'),
(90, 'tips', '🍠 Simpan kentang di tempat gelap agar tidak cepat bertunas.'),
(91, 'tips', '🍜 Tambahkan potongan daun bawang dan cabai rawit segar untuk mie kuah yang lebih nikmat.'),
(92, 'tips', '🍰 Dinginkan kue sebelum dipotong agar tidak hancur bentuknya.'),
(93, 'tips', '🧂 Jangan tambahkan garam terlalu awal pada masakan kacang-kacangan agar empuk.');

-- --------------------------------------------------------

--
-- Struktur dari tabel `logs`
--

CREATE TABLE `logs` (
  `id` int(11) NOT NULL,
  `modul` varchar(100) DEFAULT NULL,
  `keterangan` text DEFAULT NULL,
  `waktu` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `direction` enum('in','out') NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `messages`
--

INSERT INTO `messages` (`id`, `user_id`, `direction`, `message`, `created_at`) VALUES
(1, NULL, 'in', '/daftar', '2025-06-28 08:24:55'),
(2, NULL, 'in', '/daftar', '2025-06-28 08:31:50'),
(3, NULL, 'in', '/daftar', '2025-06-28 08:34:38'),
(4, NULL, 'in', '/start', '2025-06-28 08:35:08'),
(5, NULL, 'out', 'Halo @maulidacy! Selamat datang di *Bot Makanan Trending*! 🍽️', '2025-06-28 08:35:08'),
(6, NULL, 'out', 'Silahkan klik menu di bawah ini untuk memilih opsi yang tersedia.', '2025-06-28 08:35:09'),
(7, NULL, 'in', 'Makanan Trending', '2025-06-28 08:35:18'),
(8, NULL, 'in', 'Tips Masak', '2025-06-28 08:35:58'),
(9, NULL, 'in', '/daftar', '2025-06-28 08:37:46'),
(10, NULL, 'in', '/start', '2025-06-28 08:38:15'),
(11, NULL, 'out', 'Halo @maulidacy! Selamat datang di *Bot Makanan Trending*! 🍽️', '2025-06-28 08:38:15'),
(12, NULL, 'out', 'Silahkan klik menu di bawah ini untuk memilih opsi yang tersedia.', '2025-06-28 08:38:16'),
(13, NULL, 'in', 'Makanan Trending', '2025-06-28 08:38:17'),
(14, NULL, 'in', '/start', '2025-06-28 08:41:10'),
(15, NULL, 'out', 'Halo @maulidacy! Selamat datang di *Bot Makanan Trending*! 🍽️', '2025-06-28 08:41:10'),
(16, NULL, 'out', 'Silahkan klik menu di bawah ini untuk memilih opsi yang tersedia.', '2025-06-28 08:41:11'),
(17, NULL, 'in', 'Makanan Trending', '2025-06-28 08:41:12'),
(18, NULL, 'out', '🔥 *MAKANAN TRENDING BULAN INI* 🔥\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\nKetik nomor makanan untuk melihat detail.', '2025-06-28 08:41:12'),
(19, NULL, 'in', '2', '2025-06-28 08:41:17'),
(20, NULL, 'in', 'Rekomendasi Hari Ini', '2025-06-28 08:41:25'),
(21, NULL, 'out', 'Lagi mau masak yang gimana?', '2025-06-28 08:41:26'),
(22, NULL, 'in', '🔥 Pedas', '2025-06-28 08:41:28'),
(23, NULL, 'in', '/start', '2025-06-28 08:45:18'),
(24, NULL, 'out', 'Halo @maulidacy! Selamat datang di *Bot Makanan Trending*! 🍽️', '2025-06-28 08:45:19'),
(25, NULL, 'out', 'Silahkan klik menu di bawah ini untuk memilih opsi yang tersedia.', '2025-06-28 08:45:19'),
(26, NULL, 'in', 'Makanan Trending', '2025-06-28 08:45:20'),
(27, NULL, 'out', '🔥 *MAKANAN TRENDING BULAN INI* 🔥\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\nKetik nomor makanan untuk melihat detail.', '2025-06-28 08:45:21'),
(28, NULL, 'in', '1', '2025-06-28 08:45:23'),
(29, NULL, 'in', 'Cari Makanan', '2025-06-28 08:45:26'),
(30, NULL, 'out', 'Silahkan tulis makanan yang ingin anda cari', '2025-06-28 08:45:26'),
(31, NULL, 'in', 'Gado gado', '2025-06-28 08:45:33'),
(32, NULL, 'in', '/start', '2025-06-28 09:50:53'),
(33, NULL, 'out', 'Halo @maulidacy! Selamat datang di *Bot Makanan Trending*! 🍽️', '2025-06-28 09:50:54'),
(34, NULL, 'out', 'Silahkan klik menu di bawah ini untuk memilih opsi yang tersedia.', '2025-06-28 09:50:55'),
(35, NULL, 'in', 'Makanan Trending', '2025-06-28 09:51:10'),
(36, NULL, 'out', '🔥 *MAKANAN TRENDING BULAN INI* 🔥\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\nKetik nomor makanan untuk melihat detail.', '2025-06-28 09:51:10'),
(37, NULL, 'in', '1', '2025-06-28 09:51:14'),
(38, NULL, 'out', '😊 Wah, sepertinya aku belum paham maksud kamu. \n➡️ Yuk, pilih menu di bawah ini ya:', '2025-06-28 09:51:14'),
(39, NULL, 'in', 'Tips Masak', '2025-06-28 09:51:21'),
(40, NULL, 'out', '👩‍🍳 *Tips Masak Hari Ini!* 🧂\n\n🔸 _🧂 Taburi sedikit garam di talenan agar tidak licin saat memotong._\n\nCoba praktikkan hari ini, ya! 😋\nIngin tips lain? Ketik *tips* atau klik tombol \"Tips Masak\".', '2025-06-28 09:51:21'),
(41, NULL, 'in', 'Rekomendasi Hari Ini', '2025-06-28 09:51:26'),
(42, NULL, 'out', 'Lagi mau masak yang gimana?', '2025-06-28 09:51:27'),
(43, NULL, 'in', 'Gado gado', '2025-06-28 09:51:32'),
(44, NULL, 'in', '🧀 Cheesy', '2025-06-28 09:51:39'),
(45, NULL, 'out', '🌶️ Resep cheesy untukmu:\n\n1. Macaroni Schotel Panggang Super Cheesy (estimasi waktu)\nKetik nomor untuk melihat detail resep!', '2025-06-28 09:51:40'),
(46, NULL, 'in', '1', '2025-06-28 09:51:47'),
(47, NULL, 'out', '🍽️ *Macaroni Schotel Panggang Super Cheesy*\n\n📂 Kategori: Makanan Ringan\n📝 Deskripsi: Macaroni schotel panggang dengan saus putih, taburan keju leleh—teksturnya creamy dan sangat cheesy.\n\n📋 Bahan-bahan:\n250 gr macaroni rebus al dente\n7 sdm tepung terigu\n5 sdm mentega\n750 ml susu cair\n60 gr keju cheddar\n70 gr keju mozzarella\n3 butir telur\n85 gr kornet sapi\ndaun seledri, pala, garam, merica\n\n📖 Cara membuat:\n1) Tumis kornet dan seledri hingga harum, sisihkan.\n2) Buat saus putih: masak mentega + terigu, tuang susu, masak hingga mengental, bumbui pala, garam, merica.\n3) Matikan api, tambahkan sebagian keju parut dan telur, aduk cepat.\n4) Campur macaroni, saus, kornet.\n5) Tuang ke loyang, tabur keju mozzarella.\n6) Panggang dalam oven 180 °C ±20 menit hingga keju meleleh dan berwarna keemasan.\n\n🔗 Sumber: https://cookpad.com/id/resep/559393-super-cheesy-macaroni-schotel-panggang', '2025-06-28 09:51:47'),
(48, NULL, 'in', 'Cari Makanan', '2025-06-28 09:51:50'),
(49, NULL, 'out', 'Silahkan tulis makanan yang ingin anda cari', '2025-06-28 09:51:50'),
(50, NULL, 'in', 'Gado gado', '2025-06-28 09:51:54'),
(51, NULL, 'out', '😊 Wah, sepertinya aku belum paham maksud kamu. \n➡️ Yuk, pilih menu di bawah ini ya:', '2025-06-28 09:51:55'),
(52, NULL, 'in', 'Makanan Trending', '2025-06-28 09:51:59'),
(53, NULL, 'out', '🔥 *MAKANAN TRENDING BULAN INI* 🔥\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\nKetik nomor makanan untuk melihat detail.', '2025-06-28 09:51:59'),
(54, NULL, 'in', '1', '2025-06-28 09:52:02'),
(55, NULL, 'out', '😊 Wah, sepertinya aku belum paham maksud kamu. \n➡️ Yuk, pilih menu di bawah ini ya:', '2025-06-28 09:52:03'),
(56, NULL, 'in', '/start', '2025-06-28 09:54:14'),
(57, NULL, 'out', 'Halo @maulidacy! Selamat datang di *Bot Makanan Trending*! 🍽️', '2025-06-28 09:54:14'),
(58, NULL, 'out', 'Silahkan klik menu di bawah ini untuk memilih opsi yang tersedia.', '2025-06-28 09:54:15'),
(59, NULL, 'in', 'Makanan Trending', '2025-06-28 09:54:16'),
(60, NULL, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-06-28 09:54:17'),
(61, NULL, 'in', '1', '2025-06-28 09:54:19'),
(62, NULL, 'out', '🍽️ *Tempe sandal jepit*\n\n📂 Kategori: Camilan\n📝 Deskripsi: Tempe goreng dengan bentuk unik seperti sandal jepit, renyah dan gurih.\n\n📋 Bahan-bahan:\nTempe, tepung bumbu, minyak goreng\n\n📖 Cara membuat:\n1) Potong tempe tipis memanjang menyerupai sandal jepit.\n2) Lumuri dengan tepung bumbu.\n3) Goreng hingga kuning keemasan dan renyah.\n4) Sajikan hangat.\n\n🔗 Sumber: ', '2025-06-28 09:54:20'),
(63, NULL, 'in', 'Makanan Trending', '2025-06-28 09:54:24'),
(64, NULL, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-06-28 09:54:24'),
(65, NULL, 'in', '7', '2025-06-28 09:54:27'),
(66, NULL, 'out', '🍽️ *Rendang sapi melted*\n\n📂 Kategori: Daging\n📝 Deskripsi: Rendang sapi dengan keju meleleh, perpaduan rasa pedas dan gurih.\n\n📋 Bahan-bahan:\nDaging sapi, keju, santan, bumbu rendang\n\n📖 Cara membuat:\n1) Masak rendang hingga empuk.\n2) Tambahkan keju leleh di atasnya.\n3) Sajikan hangat.\n\n🔗 Sumber: ', '2025-06-28 09:54:27'),
(67, NULL, 'in', 'Cari Makanan', '2025-06-28 09:54:30'),
(68, NULL, 'out', 'Silahkan tulis makanan yang ingin anda cari', '2025-06-28 09:54:30'),
(69, NULL, 'in', 'Gado gado', '2025-06-28 09:54:36'),
(70, NULL, 'out', '😊 Wah, sepertinya aku belum paham maksud kamu. \n➡️ Yuk, pilih menu di bawah ini ya:', '2025-06-28 09:54:37'),
(71, NULL, 'in', '/start', '2025-06-28 10:07:03'),
(72, NULL, 'out', 'Halo @maulidacy! Selamat datang di *Bot Makanan Trending*! 🍽️', '2025-06-28 10:07:04'),
(73, NULL, 'out', 'Silahkan klik menu di bawah ini untuk memilih opsi yang tersedia.', '2025-06-28 10:07:05'),
(74, NULL, 'in', 'Cari Makanan', '2025-06-28 10:07:06'),
(75, NULL, 'out', 'Silahkan tulis makanan yang ingin anda cari', '2025-06-28 10:07:06'),
(76, NULL, 'in', 'Gado gado', '2025-06-28 10:07:10'),
(77, NULL, 'in', 'Gado-gado', '2025-06-28 10:07:17'),
(78, NULL, 'out', '😊 Wah, sepertinya aku belum paham maksud kamu. \n➡️ Yuk, pilih menu di bawah ini ya:', '2025-06-28 10:07:18'),
(79, NULL, 'in', 'Cari Makanan', '2025-06-28 10:07:19'),
(80, NULL, 'out', 'Silahkan tulis makanan yang ingin anda cari', '2025-06-28 10:07:19'),
(81, NULL, 'in', 'Gado-gado', '2025-06-28 10:07:23'),
(82, NULL, 'in', 'Cari Makanan', '2025-06-28 10:07:27'),
(83, NULL, 'out', 'Silahkan tulis makanan yang ingin anda cari', '2025-06-28 10:07:27'),
(84, NULL, 'in', 'Ayam geprek', '2025-06-28 10:07:32'),
(85, NULL, 'in', '/start', '2025-06-28 10:11:35'),
(86, NULL, 'out', 'Halo @maulidacy! Selamat datang di *Bot Makanan Trending*! 🍽️', '2025-06-28 10:11:36'),
(87, NULL, 'out', 'Silahkan klik menu di bawah ini untuk memilih opsi yang tersedia.', '2025-06-28 10:11:36'),
(88, NULL, 'in', 'Cari Makanan', '2025-06-28 10:11:39'),
(89, NULL, 'out', 'Silahkan tulis makanan yang ingin anda cari', '2025-06-28 10:11:39'),
(90, NULL, 'in', 'Gado gado', '2025-06-28 10:11:44'),
(91, NULL, 'in', 'Cari Makanan', '2025-06-28 10:11:47'),
(92, NULL, 'out', 'Silahkan tulis makanan yang ingin anda cari', '2025-06-28 10:11:48'),
(93, NULL, 'in', 'Ayam geprek', '2025-06-28 10:11:55'),
(94, NULL, 'in', '/start', '2025-06-28 10:13:40'),
(95, NULL, 'out', 'Halo @maulidacy! Selamat datang di *Bot Makanan Trending*! 🍽️', '2025-06-28 10:13:41'),
(96, NULL, 'out', 'Silahkan klik menu di bawah ini untuk memilih opsi yang tersedia.', '2025-06-28 10:13:41'),
(97, NULL, 'in', 'Cari Makanan', '2025-06-28 10:13:42'),
(98, NULL, 'out', 'Silahkan tulis makanan yang ingin anda cari', '2025-06-28 10:13:43'),
(99, NULL, 'in', 'Gado gado', '2025-06-28 10:13:46'),
(100, NULL, 'in', 'Cari Makanan', '2025-06-28 10:13:50'),
(101, NULL, 'out', 'Silahkan tulis makanan yang ingin anda cari', '2025-06-28 10:13:51'),
(102, NULL, 'in', 'Ayam geprek', '2025-06-28 10:13:56'),
(103, NULL, 'in', 'Rekomendasi Hari Ini', '2025-06-28 10:13:58'),
(104, NULL, 'out', 'Lagi mau masak yang gimana?', '2025-06-28 10:13:58'),
(105, NULL, 'in', '🔥 Pedas', '2025-06-28 10:14:00'),
(106, NULL, 'out', '🌶️ Resep pedas untukmu:\n\n1. Ayam Geprek Ganas (estimasi waktu)\n2. Ayam Geprek Sambel Judes (estimasi waktu)\n3. Ayam Rica-Rica Pedas (estimasi waktu)\nKetik nomor untuk melihat detail resep!', '2025-06-28 10:14:00'),
(107, NULL, 'in', '2', '2025-06-28 10:14:04'),
(108, NULL, 'out', '🍽️ *Ayam Geprek Sambel Judes*\n\n📂 Kategori: Ayam\n📝 Deskripsi: Ayam geprek dengan sambal judes (juara pedes) untuk pecinta pedas sejati.\n\n📋 Bahan-bahan:\n1 kg ayam broiler\n150 gr tepung crispy\n30 buah cabe rawit\n20 buah cabe keriting\n8 siung bawang putih\n2 sdt garam\n1 sdt gula merah\nMinyak goreng\n\n📖 Cara membuat:\n1) Potong ayam, bumbui dan goreng crispy\n2) Ulek cabe rawit, cabe keriting, bawang putih\n3) Tambahkan garam dan gula merah\n4) Geprek ayam dengan banyak sambal\n5) Aduk rata hingga ayam tertutup sambal\n\n🔗 Sumber: https://cookpad.com/id/resep/4235891-ayam-geprek-sambel-judes-juara-pedes', '2025-06-28 10:14:05'),
(109, NULL, 'in', 'Rekomendasi Hari Ini', '2025-06-28 10:14:10'),
(110, NULL, 'out', 'Lagi mau masak yang gimana?', '2025-06-28 10:14:10'),
(111, NULL, 'in', '🥕 Pake bahan yang ada', '2025-06-28 10:14:11'),
(112, NULL, 'in', 'Ayam, tepung', '2025-06-28 10:14:17'),
(113, NULL, 'out', 'Resep dengan bahan yang Anda miliki:\n\n1. Ayam Geprek (estimasi waktu)\n2. Ayam Geprek Bensu (estimasi waktu)\n3. Ayam Geprek Ganas (estimasi waktu)\nKetik nomor untuk melihat detail resep!', '2025-06-28 10:14:17'),
(114, NULL, 'in', '1', '2025-06-28 10:14:20'),
(115, NULL, 'out', '🍽️ *Ayam Geprek*\n\n📂 Kategori: Ayam\n📝 Deskripsi: Ayam goreng krispi yang digeprek dengan sambal pedas. Cocok untuk makan siang praktis.\n\n📋 Bahan-bahan:\n250 gr daging ayam\n1 bungkus tepung ayam goreng instan\n5 siung bawang putih\n10 cabai rawit merah\n1 sdt garam\n1 sdt gula\nMinyak goreng secukupnya\n\n📖 Cara membuat:\n1) Lumuri ayam dengan tepung, goreng hingga krispi.\n2) Ulek bawang putih, cabai, garam, dan gula.\n3) Geprek ayam di atas sambal.\n4) Sajikan dengan nasi hangat.\n\n🔗 Sumber: https://cookpad.com/id/resep/4473023-ayam-geprek', '2025-06-28 10:14:21'),
(116, NULL, 'in', 'Tips Masak', '2025-06-28 10:14:22'),
(117, NULL, 'out', '👩‍🍳 *Tips Masak Hari Ini!* 🧂\n\n🔸 _🍫 Simpan coklat di suhu ruang, bukan kulkas, agar tidak mengembun dan berubah rasa._\n\nCoba praktikkan hari ini, ya! 😋\nIngin tips lain? Ketik *tips* atau klik tombol \"Tips Masak\".', '2025-06-28 10:14:23'),
(118, NULL, 'in', 'Makanan Trending', '2025-06-28 10:14:24'),
(119, NULL, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-06-28 10:14:25'),
(120, NULL, 'in', '5', '2025-06-28 10:14:29'),
(121, NULL, 'out', '🍽️ *Bakso bomber*\n\n📂 Kategori: Camilan\n📝 Deskripsi: Bakso besar dengan isian daging dan keju, gurih dan mengenyangkan.\n\n📋 Bahan-bahan:\nDaging sapi, keju, tepung, bumbu\n\n📖 Cara membuat:\n1) Campur daging dan bumbu.\n2) Bentuk bola besar dengan isian keju.\n3) Rebus hingga matang.\n4) Sajikan hangat.\n\n🔗 Sumber: ', '2025-06-28 10:14:29'),
(122, NULL, 'in', 'Cari Makanan', '2025-06-28 10:14:30'),
(123, NULL, 'out', 'Silahkan tulis makanan yang ingin anda cari', '2025-06-28 10:14:31'),
(124, NULL, 'in', 'Ayam geprek', '2025-06-28 10:14:34'),
(125, NULL, 'in', '/start', '2025-06-28 10:17:51'),
(126, NULL, 'out', 'Halo @maulidacy! Selamat datang di *Bot Makanan Trending*! 🍽️', '2025-06-28 10:17:51'),
(127, NULL, 'out', 'Silahkan klik menu di bawah ini untuk memilih opsi yang tersedia.', '2025-06-28 10:17:51'),
(128, NULL, 'in', 'Cari Makanan', '2025-06-28 10:17:53'),
(129, NULL, 'out', 'Silahkan ketik nama makanan yang ingin Anda cari', '2025-06-28 10:17:53'),
(130, NULL, 'in', 'Ayam geprek', '2025-06-28 10:17:58'),
(131, NULL, 'out', 'Resep ditemukan:\n\n1. Ayam Geprek\n2. Ayam Geprek Bensu\n3. Ayam Geprek Ganas\n4. Ayam Geprek Sambal Matah\n5. Ayam Geprek Ala Preksu Jogja\nKetik nomor untuk melihat detail resep!', '2025-06-28 10:17:58'),
(132, NULL, 'in', '1', '2025-06-28 10:18:01'),
(133, NULL, 'out', '🍽️ *Ayam Geprek*\n\n📂 Kategori: Ayam\n📝 Deskripsi: Ayam goreng krispi yang digeprek dengan sambal pedas. Cocok untuk makan siang praktis.\n\n📋 Bahan-bahan:\n250 gr daging ayam\n1 bungkus tepung ayam goreng instan\n5 siung bawang putih\n10 cabai rawit merah\n1 sdt garam\n1 sdt gula\nMinyak goreng secukupnya\n\n📖 Cara membuat:\n1) Lumuri ayam dengan tepung, goreng hingga krispi.\n2) Ulek bawang putih, cabai, garam, dan gula.\n3) Geprek ayam di atas sambal.\n4) Sajikan dengan nasi hangat.\n\n🔗 Sumber: https://cookpad.com/id/resep/4473023-ayam-geprek', '2025-06-28 10:18:02'),
(134, NULL, 'in', 'Cari Makanan', '2025-06-28 10:18:05'),
(135, NULL, 'out', 'Silahkan ketik nama makanan yang ingin Anda cari', '2025-06-28 10:18:05'),
(136, NULL, 'in', 'Soto', '2025-06-28 10:18:08'),
(137, NULL, 'out', 'Resep ditemukan:\n\n1. Soto Ayam\nKetik nomor untuk melihat detail resep!', '2025-06-28 10:18:08'),
(138, NULL, 'in', '1', '2025-06-28 10:18:11'),
(139, NULL, 'out', '🍽️ *Soto Ayam*\n\n📂 Kategori: Sup\n📝 Deskripsi: Sup ayam bening dengan kuah yang segar dan bumbu rempah yang harum.\n\n📋 Bahan-bahan:\n1 ekor ayam\n200 gr tauge\n100 gr soun\n3 butir telur rebus\n5 siung bawang merah\n4 siung bawang putih\n3 cm jahe\n2 cm kunyit\n1 sdt ketumbar\n2 lembar daun salam\n2 batang serai\n2 sdt garam\n1 sdt merica\nBawang goreng dan kerupuk untuk pelengkap\n\n📖 Cara membuat:\n1) Rebus ayam hingga empuk, suwir-suwir, sisihkan kaldu\n2) Haluskan bawang merah, bawang putih, jahe, kunyit, ketumbar\n3) Tumis bumbu halus hingga harum\n4) Masukkan bumbu tumis ke dalam kaldu ayam\n5) Tambahkan daun salam, serai, garam, merica\n6) Masak hingga mendidih dan bumbu meresap\n7) Seduh soun dengan air panas\n8) Tata soun, tauge, ayam suwir, telur di mangkuk\n9) Siram dengan kuah panas\n10) Taburi bawang goreng dan sajikan dengan kerupuk\n\n🔗 Sumber: https://cookpad.com/id/resep/3456123-soto-ayam-kuah-bening', '2025-06-28 10:18:11'),
(140, NULL, 'in', 'Cari Makanan', '2025-06-28 10:18:14'),
(141, NULL, 'out', 'Silahkan ketik nama makanan yang ingin Anda cari', '2025-06-28 10:18:15'),
(142, NULL, 'in', 'Sate', '2025-06-28 10:18:18'),
(143, NULL, 'in', 'Cari Makanan', '2025-06-28 10:18:23'),
(144, NULL, 'out', 'Silahkan ketik nama makanan yang ingin Anda cari', '2025-06-28 10:18:23'),
(145, NULL, 'in', 'Gado gado', '2025-06-28 10:18:35'),
(146, NULL, 'in', 'Cari Makanan', '2025-06-28 10:18:39'),
(147, NULL, 'out', 'Silahkan ketik nama makanan yang ingin Anda cari', '2025-06-28 10:18:39'),
(148, NULL, 'in', 'Gado-gado', '2025-06-28 10:18:47'),
(149, NULL, 'out', 'Resep ditemukan:\n\n1. Gado-Gado\nKetik nomor untuk melihat detail resep!', '2025-06-28 10:18:47'),
(150, NULL, 'in', '1', '2025-06-28 10:18:56'),
(151, NULL, 'out', '🍽️ *Gado-Gado*\n\n📂 Kategori: Salad\n📝 Deskripsi: Salad sayuran rebus dengan bumbu kacang yang gurih dan segar.\n\n📋 Bahan-bahan:\n200 gr kangkung\n200 gr kol\n200 gr tauge\n2 buah tahu goreng\n2 buah tempe goreng\n2 butir telur rebus\n1 buah mentimun\n200 gr kacang tanah sangrai\n3 buah cabe rawit\n2 siung bawang putih\n2 sdm gula merah\n1 sdt garam\n2 sdm air asam jawa\nKerupuk untuk pelengkap\n\n📖 Cara membuat:\n1) Rebus kangkung, kol, dan tauge hingga matang, tiriskan\n2) Sangrai kacang tanah hingga matang, haluskan\n3) Haluskan cabe rawit, bawang putih, gula merah, garam\n4) Campur kacang halus dengan bumbu halus\n5) Tambahkan air asam jawa, aduk rata\n6) Potong tahu, tempe, telur, mentimun\n7) Tata semua sayuran dan pelengkap di piring\n8) Siram dengan bumbu kacang\n9) Sajikan dengan kerupuk\n\n🔗 Sumber: https://cookpad.com/id/resep/4567890-gado-gado-betawi', '2025-06-28 10:18:57'),
(152, NULL, 'in', 'Cari Makanan', '2025-06-28 10:19:24'),
(153, NULL, 'out', 'Silahkan ketik nama makanan yang ingin Anda cari', '2025-06-28 10:19:24'),
(154, NULL, 'in', 'Gudeg jogja', '2025-06-28 10:19:29'),
(155, NULL, 'out', 'Resep ditemukan:\n\n1. Gudeg Jogja\nKetik nomor untuk melihat detail resep!', '2025-06-28 10:19:29'),
(156, NULL, 'in', '1', '2025-06-28 10:19:40'),
(157, NULL, 'out', '🍽️ *Gudeg Jogja*\n\n📂 Kategori: Sayuran\n📝 Deskripsi: Makanan khas Yogyakarta berbahan dasar nangka muda yang dimasak dengan santan dan gula jawa.\n\n📋 Bahan-bahan:\n1 kg nangka muda potong-potong\n500 ml santan kental\n200 gr gula jawa\n10 siung bawang merah\n6 siung bawang putih\n3 cm kencur\n2 lembar daun salam\n3 lembar daun jeruk\n2 sdt garam\n1 sdt ketumbar\n\n📖 Cara membuat:\n1) Rebus nangka muda hingga setengah matang\n2) Haluskan bawang merah, bawang putih, kencur, ketumbar\n3) Tumis bumbu halus hingga harum\n4) Masukkan nangka, santan, gula jawa, daun salam, daun jeruk\n5) Masak dengan api kecil hingga kuah mengental dan nangka empuk\n6) Koreksi rasa, masak hingga kuah menyusut\n7) Sajikan dengan nasi, ayam areh, dan krecek\n\n🔗 Sumber: https://cookpad.com/id/resep/5678901-gudeg-jogja-manis', '2025-06-28 10:19:40'),
(158, NULL, 'in', 'Cari Makanan', '2025-06-28 10:19:43'),
(159, NULL, 'out', 'Silahkan ketik nama makanan yang ingin Anda cari', '2025-06-28 10:19:43'),
(160, NULL, 'in', '/start', '2025-06-28 10:21:10'),
(161, NULL, 'out', 'Halo @maulidacy! Selamat datang di *Bot Makanan Trending*! 🍽️', '2025-06-28 10:21:10'),
(162, NULL, 'out', 'Silahkan klik menu di bawah ini untuk memilih opsi yang tersedia.', '2025-06-28 10:21:11'),
(163, NULL, 'in', 'Cari Makanan', '2025-06-28 10:21:12'),
(164, NULL, 'out', 'Silahkan ketik nama makanan yang ingin Anda cari', '2025-06-28 10:21:12'),
(165, NULL, 'in', 'Gado-gado', '2025-06-28 10:21:20'),
(166, NULL, 'in', 'Cari Makanan', '2025-06-28 10:21:22'),
(167, NULL, 'out', 'Silahkan ketik nama makanan yang ingin Anda cari', '2025-06-28 10:21:22'),
(168, NULL, 'in', 'Gado gado', '2025-06-28 10:21:26'),
(169, NULL, 'out', 'Resep ditemukan:\n\n1. Gado Gado\nKetik nomor untuk melihat detail resep!', '2025-06-28 10:21:27'),
(170, NULL, 'in', '1', '2025-06-28 10:21:30'),
(171, NULL, 'out', '🍽️ *Gado Gado*\n\n📂 Kategori: Salad\n📝 Deskripsi: Salad sayuran rebus dengan bumbu kacang yang gurih dan segar.\n\n📋 Bahan-bahan:\n200 gr kangkung\n200 gr kol\n200 gr tauge\n2 buah tahu goreng\n2 buah tempe goreng\n2 butir telur rebus\n1 buah mentimun\n200 gr kacang tanah sangrai\n3 buah cabe rawit\n2 siung bawang putih\n2 sdm gula merah\n1 sdt garam\n2 sdm air asam jawa\nKerupuk untuk pelengkap\n\n📖 Cara membuat:\n1) Rebus kangkung, kol, dan tauge hingga matang, tiriskan\n2) Sangrai kacang tanah hingga matang, haluskan\n3) Haluskan cabe rawit, bawang putih, gula merah, garam\n4) Campur kacang halus dengan bumbu halus\n5) Tambahkan air asam jawa, aduk rata\n6) Potong tahu, tempe, telur, mentimun\n7) Tata semua sayuran dan pelengkap di piring\n8) Siram dengan bumbu kacang\n9) Sajikan dengan kerupuk\n\n🔗 Sumber: https://cookpad.com/id/resep/4567890-gado-gado-betawi', '2025-06-28 10:21:30'),
(172, NULL, 'in', '/start', '2025-06-28 10:23:18'),
(173, NULL, 'out', 'Halo @maulidacy! Selamat datang di *Bot Makanan Trending*! 🍽️', '2025-06-28 10:23:18'),
(174, NULL, 'out', 'Silahkan klik menu di bawah ini untuk memilih opsi yang tersedia.', '2025-06-28 10:23:19'),
(175, NULL, 'in', 'Cari Makanan', '2025-06-28 10:23:20'),
(176, NULL, 'out', 'Silahkan ketik nama makanan yang ingin Anda cari', '2025-06-28 10:23:21'),
(177, NULL, 'in', 'Gado-gado', '2025-06-28 10:23:25'),
(178, NULL, 'out', 'Resep ditemukan:\n\n1. Gado-gado\nKetik nomor untuk melihat detail resep!', '2025-06-28 10:23:25'),
(179, NULL, 'in', 'Cari Makanan', '2025-06-28 10:23:26'),
(180, NULL, 'out', 'Silahkan ketik nama makanan yang ingin Anda cari', '2025-06-28 10:23:27'),
(181, NULL, 'in', 'Gado gado', '2025-06-28 10:23:30'),
(182, NULL, 'out', 'Resep ditemukan:\n\n1. Gado-gado\nKetik nomor untuk melihat detail resep!', '2025-06-28 10:23:30'),
(183, NULL, 'in', '1', '2025-06-28 10:23:34'),
(184, NULL, 'out', '🍽️ *Gado-gado*\n\n📂 Kategori: Salad\n📝 Deskripsi: Salad sayuran rebus dengan bumbu kacang yang gurih dan segar.\n\n📋 Bahan-bahan:\n200 gr kangkung\n200 gr kol\n200 gr tauge\n2 buah tahu goreng\n2 buah tempe goreng\n2 butir telur rebus\n1 buah mentimun\n200 gr kacang tanah sangrai\n3 buah cabe rawit\n2 siung bawang putih\n2 sdm gula merah\n1 sdt garam\n2 sdm air asam jawa\nKerupuk untuk pelengkap\n\n📖 Cara membuat:\n1) Rebus kangkung, kol, dan tauge hingga matang, tiriskan\n2) Sangrai kacang tanah hingga matang, haluskan\n3) Haluskan cabe rawit, bawang putih, gula merah, garam\n4) Campur kacang halus dengan bumbu halus\n5) Tambahkan air asam jawa, aduk rata\n6) Potong tahu, tempe, telur, mentimun\n7) Tata semua sayuran dan pelengkap di piring\n8) Siram dengan bumbu kacang\n9) Sajikan dengan kerupuk\n\n🔗 Sumber: https://cookpad.com/id/resep/4567890-gado-gado-betawi', '2025-06-28 10:23:34'),
(185, NULL, 'in', 'Rekomendasi Hari Ini', '2025-06-28 10:23:36'),
(186, NULL, 'out', 'Lagi mau masak yang gimana?', '2025-06-28 10:23:36'),
(187, NULL, 'in', '🧀 Cheesy', '2025-06-28 10:23:37'),
(188, NULL, 'out', '🌶️ Resep cheesy untukmu:\n\n1. Macaroni Schotel Panggang Super Cheesy (estimasi waktu)\nKetik nomor untuk melihat detail resep!', '2025-06-28 10:23:38'),
(189, NULL, 'in', '1', '2025-06-28 10:23:41'),
(190, NULL, 'out', '🍽️ *Macaroni Schotel Panggang Super Cheesy*\n\n📂 Kategori: Makanan Ringan\n📝 Deskripsi: Macaroni schotel panggang dengan saus putih, taburan keju leleh—teksturnya creamy dan sangat cheesy.\n\n📋 Bahan-bahan:\n250 gr macaroni rebus al dente\n7 sdm tepung terigu\n5 sdm mentega\n750 ml susu cair\n60 gr keju cheddar\n70 gr keju mozzarella\n3 butir telur\n85 gr kornet sapi\ndaun seledri, pala, garam, merica\n\n📖 Cara membuat:\n1) Tumis kornet dan seledri hingga harum, sisihkan.\n2) Buat saus putih: masak mentega + terigu, tuang susu, masak hingga mengental, bumbui pala, garam, merica.\n3) Matikan api, tambahkan sebagian keju parut dan telur, aduk cepat.\n4) Campur macaroni, saus, kornet.\n5) Tuang ke loyang, tabur keju mozzarella.\n6) Panggang dalam oven 180 °C ±20 menit hingga keju meleleh dan berwarna keemasan.\n\n🔗 Sumber: https://cookpad.com/id/resep/559393-super-cheesy-macaroni-schotel-panggang', '2025-06-28 10:23:42'),
(191, NULL, 'in', 'Tips Masak', '2025-06-28 10:23:43'),
(192, NULL, 'out', '👩‍🍳 *Tips Masak Hari Ini!* 🧂\n\n🔸 _🥘 Tambahkan sedikit terasi saat membuat sambal agar lebih gurih._\n\nCoba praktikkan hari ini, ya! 😋\nIngin tips lain? Ketik *tips* atau klik tombol \"Tips Masak\".', '2025-06-28 10:23:44'),
(193, NULL, 'in', 'Makanan Trending', '2025-06-28 10:23:46'),
(194, NULL, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-06-28 10:23:46'),
(195, NULL, 'in', '6', '2025-06-28 10:23:50'),
(196, NULL, 'out', '🍽️ *Sushi gulung martabak*\n\n📂 Kategori: Camilan\n📝 Deskripsi: Martabak dengan isian ala sushi gulung, unik dan lezat.\n\n📋 Bahan-bahan:\nTepung, telur, nasi, nori, isian sushi\n\n📖 Cara membuat:\n1) Buat kulit martabak tipis.\n2) Tata nasi dan isian sushi.\n3) Gulung dan goreng hingga matang.\n4) Sajikan hangat.\n\n🔗 Sumber: ', '2025-06-28 10:23:50'),
(197, NULL, 'in', '/daftar', '2025-06-28 10:26:41'),
(198, NULL, 'in', '/start', '2025-06-28 10:27:25'),
(199, NULL, 'out', 'Halo @maulidacy! Selamat datang di *Bot Makanan Trending*! 🍽️', '2025-06-28 10:27:25'),
(200, NULL, 'out', 'Silahkan klik menu di bawah ini untuk memilih opsi yang tersedia.', '2025-06-28 10:27:26'),
(201, NULL, 'in', 'Makanan Trending', '2025-06-28 10:27:27'),
(202, NULL, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-06-28 10:27:28'),
(203, NULL, 'in', '/daftar', '2025-06-28 11:00:59'),
(204, NULL, 'in', '/start', '2025-06-28 11:01:43'),
(205, NULL, 'out', 'Halo @maulidacy! Selamat datang di *Bot Makanan Trending*! 🍽️', '2025-06-28 11:01:44'),
(206, NULL, 'out', 'Silahkan klik menu di bawah ini untuk memilih opsi yang tersedia.', '2025-06-28 11:01:45'),
(207, NULL, 'in', 'Makanan Trending', '2025-06-28 11:01:47'),
(208, NULL, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-06-28 11:01:48'),
(209, NULL, 'in', '1', '2025-06-28 11:01:52'),
(210, NULL, 'out', '🍽️ *Tempe sandal jepit*\n\n📂 Kategori: Camilan\n📝 Deskripsi: Tempe goreng dengan bentuk unik seperti sandal jepit, renyah dan gurih.\n\n📋 Bahan-bahan:\nTempe, tepung bumbu, minyak goreng\n\n📖 Cara membuat:\n1) Potong tempe tipis memanjang menyerupai sandal jepit.\n2) Lumuri dengan tepung bumbu.\n3) Goreng hingga kuning keemasan dan renyah.\n4) Sajikan hangat.\n\n🔗 Sumber: ', '2025-06-28 11:01:52'),
(211, NULL, 'in', '/daftar', '2025-06-28 11:09:39'),
(212, NULL, 'in', '/start', '2025-06-28 11:11:52'),
(213, NULL, 'in', '/start', '2025-06-28 11:12:08'),
(214, NULL, 'in', '/daftar', '2025-06-28 11:12:30'),
(215, NULL, 'in', '/start', '2025-06-28 11:12:57'),
(216, NULL, 'out', 'Halo @maulidacy! Selamat datang di *Bot Makanan Trending*! 🍽️', '2025-06-28 11:12:57'),
(217, NULL, 'out', 'Silahkan klik menu di bawah ini untuk memilih opsi yang tersedia.', '2025-06-28 11:12:58'),
(218, NULL, 'in', 'Makanan Trending', '2025-06-28 11:12:59'),
(219, NULL, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-06-28 11:13:00'),
(220, NULL, 'in', '1', '2025-06-28 11:13:03'),
(221, NULL, 'out', '🍽️ *Tempe sandal jepit*\n\n📂 Kategori: Camilan\n📝 Deskripsi: Tempe goreng dengan bentuk unik seperti sandal jepit, renyah dan gurih.\n\n📋 Bahan-bahan:\nTempe, tepung bumbu, minyak goreng\n\n📖 Cara membuat:\n1) Potong tempe tipis memanjang menyerupai sandal jepit.\n2) Lumuri dengan tepung bumbu.\n3) Goreng hingga kuning keemasan dan renyah.\n4) Sajikan hangat.\n\n🔗 Sumber: ', '2025-06-28 11:13:03'),
(222, NULL, 'in', '/daftar', '2025-06-28 11:15:55'),
(223, NULL, 'in', '/daftar', '2025-06-28 11:17:52'),
(224, NULL, 'in', '/daftar', '2025-06-28 11:23:10'),
(225, NULL, 'in', '/start', '2025-06-28 11:33:35'),
(226, NULL, 'out', 'Halo @maulidacy! Selamat datang di *Bot Makanan Trending*! 🍽️', '2025-06-28 11:33:36'),
(227, NULL, 'out', 'Silahkan klik menu di bawah ini untuk memilih opsi yang tersedia.', '2025-06-28 11:33:37'),
(228, NULL, 'in', 'Makanan Trending', '2025-06-28 11:33:38'),
(229, NULL, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-06-28 11:33:38'),
(230, NULL, 'in', 'Rekomendasi Hari Ini', '2025-06-28 11:33:48'),
(231, NULL, 'out', 'Lagi mau masak yang gimana?', '2025-06-28 11:33:49'),
(232, NULL, 'in', '🔥 Pedas', '2025-06-28 11:33:50'),
(233, NULL, 'out', '🌶️ Resep pedas untukmu:\n\n1. Ayam Geprek Ganas (estimasi waktu)\n2. Ayam Geprek Sambel Judes (estimasi waktu)\n3. Ayam Rica-Rica Pedas (estimasi waktu)\nKetik nomor untuk melihat detail resep!', '2025-06-28 11:33:50'),
(234, NULL, 'in', 'Makanan Trending', '2025-06-28 11:33:51'),
(235, NULL, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-06-28 11:33:52'),
(236, NULL, 'in', '1', '2025-06-28 11:34:00'),
(237, NULL, 'out', '🍽️ *Tempe sandal jepit*\n\n📂 Kategori: Camilan\n📝 Deskripsi: Tempe goreng dengan bentuk unik seperti sandal jepit, renyah dan gurih.\n\n📋 Bahan-bahan:\nTempe, tepung bumbu, minyak goreng\n\n📖 Cara membuat:\n1) Potong tempe tipis memanjang menyerupai sandal jepit.\n2) Lumuri dengan tepung bumbu.\n3) Goreng hingga kuning keemasan dan renyah.\n4) Sajikan hangat.\n\n🔗 Sumber: ', '2025-06-28 11:34:00'),
(238, NULL, 'in', '/start', '2025-06-28 11:34:41'),
(239, NULL, 'out', 'Halo @maulidacy! Selamat datang di *Bot Makanan Trending*! 🍽️', '2025-06-28 11:34:42'),
(240, NULL, 'out', 'Silahkan klik menu di bawah ini untuk memilih opsi yang tersedia.', '2025-06-28 11:34:42'),
(241, NULL, 'in', 'Makanan Trending', '2025-06-28 11:34:44'),
(242, NULL, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-06-28 11:34:45'),
(243, NULL, 'in', 'Tips Masak', '2025-06-28 11:34:47'),
(244, NULL, 'out', '👩‍🍳 *Tips Masak Hari Ini!* 🧂\n\n🔸 _🧅 Rendam bawang bombay di air dingin agar tidak terlalu pedas di salad._\n\nCoba praktikkan hari ini, ya! 😋\nIngin tips lain? Ketik *tips* atau klik tombol \"Tips Masak\".', '2025-06-28 11:34:47'),
(245, NULL, 'in', 'Tips', '2025-06-28 11:34:53'),
(246, NULL, 'in', 'Tips Masak', '2025-06-28 11:35:01'),
(247, NULL, 'out', '👩‍🍳 *Tips Masak Hari Ini!* 🧂\n\n🔸 _🥫 Simpan bahan kering seperti tepung dan gula di wadah kedap udara._\n\nCoba praktikkan hari ini, ya! 😋\nIngin tips lain? Ketik *tips* atau klik tombol \"Tips Masak\".', '2025-06-28 11:35:02'),
(248, NULL, 'in', 'tips', '2025-06-28 11:35:06'),
(249, NULL, 'out', '🧂 Gunakan api kecil saat menumis bumbu agar lebih harum dan matang. Tambahkan sedikit gula untuk menyeimbangkan rasa.', '2025-06-28 11:35:06'),
(250, NULL, 'in', 'tips', '2025-06-28 11:35:14'),
(251, NULL, 'out', '🧂 Gunakan api kecil saat menumis bumbu agar lebih harum dan matang. Tambahkan sedikit gula untuk menyeimbangkan rasa.', '2025-06-28 11:35:14'),
(252, NULL, 'in', 'Rekomendasi Hari Ini', '2025-06-28 11:35:16'),
(253, NULL, 'out', 'Lagi mau masak yang gimana?', '2025-06-28 11:35:17'),
(254, NULL, 'in', '🔥 Pedas', '2025-06-28 11:35:19'),
(255, NULL, 'out', '🌶️ Resep pedas untukmu:\n\n1. Ayam Geprek Ganas (estimasi waktu)\n2. Ayam Geprek Sambel Judes (estimasi waktu)\n3. Ayam Rica-Rica Pedas (estimasi waktu)\nKetik nomor untuk melihat detail resep!', '2025-06-28 11:35:20'),
(256, NULL, 'in', '1', '2025-06-28 11:35:22'),
(257, NULL, 'out', '🍽️ *Ayam Geprek Ganas*\n\n📂 Kategori: Ayam\n📝 Deskripsi: Ayam geprek dengan level kepedasan yang ganas, cocok untuk pecinta pedas.\n\n📋 Bahan-bahan:\n1 kg ayam potong\n200 gr tepung bumbu siap pakai\n25 buah cabe rawit\n10 siung bawang putih\n2 sdt garam\n1 sdt gula\nMinyak untuk menggoreng\n\n📖 Cara membuat:\n1) Bersihkan ayam, lumuri garam\n2) Balur dengan tepung bumbu, goreng hingga krispi\n3) Ulek cabe rawit, bawang putih, garam, gula hingga halus\n4) Geprek ayam goreng di atas sambal\n5) Aduk rata hingga bumbu meresap\n\n🔗 Sumber: https://cookpad.com/id/resep/4026468', '2025-06-28 11:35:22'),
(258, NULL, 'in', 'Makanan Trending', '2025-06-28 11:36:15'),
(259, NULL, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-06-28 11:36:16'),
(260, NULL, 'in', 'Rekomendasi Hari Ini', '2025-06-28 11:38:19'),
(261, NULL, 'in', '/start', '2025-06-28 11:39:15'),
(262, NULL, 'in', '/start', '2025-06-28 11:43:21'),
(263, NULL, 'in', '/start', '2025-06-28 11:47:37'),
(264, NULL, 'out', 'Halo @maulidacy! Selamat datang di *Bot Makanan Trending*! 🍽️', '2025-06-28 11:47:38'),
(265, NULL, 'out', 'Silahkan klik menu di bawah ini untuk memilih opsi yang tersedia.', '2025-06-28 11:47:38'),
(266, NULL, 'in', 'Makanan Trending', '2025-06-28 11:47:39'),
(267, NULL, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-06-28 11:47:40'),
(268, 20, 'in', '/daftar', '2025-06-28 11:47:52'),
(269, 20, 'in', '/start', '2025-06-28 11:48:17'),
(270, 20, 'out', 'Halo @maulidacy! Selamat datang di *Bot Makanan Trending*! 🍽️', '2025-06-28 11:48:17'),
(271, 20, 'out', 'Silahkan klik menu di bawah ini untuk memilih opsi yang tersedia.', '2025-06-28 11:48:17'),
(272, 20, 'in', 'Makanan Trending', '2025-06-28 11:48:18'),
(273, 20, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-06-28 11:48:18'),
(274, 20, 'in', 'Rekomendasi Hari Ini', '2025-06-28 12:20:50'),
(275, 20, 'out', 'Lagi mau masak yang gimana?', '2025-06-28 12:20:51'),
(276, 20, 'in', '🥗 Sehat', '2025-06-28 12:20:53'),
(277, 20, 'out', '🌶️ Resep sehat untukmu:\n\n1. Kale Salad With Grilled Chicken (estimasi waktu)\n2. Kale Apple Salad (estimasi waktu)\nKetik nomor untuk melihat detail resep!', '2025-06-28 12:20:53'),
(278, 20, 'in', '/start', '2025-06-29 07:52:05'),
(279, 20, 'in', '/start', '2025-06-29 07:55:53'),
(280, 20, 'out', 'Halo @maulidacy! Selamat datang di *Bot Makanan Trending*! 🍽️', '2025-06-29 07:55:53'),
(281, 20, 'out', 'Silahkan klik menu di bawah ini untuk memilih opsi yang tersedia.', '2025-06-29 07:55:54'),
(282, 20, 'in', 'Rekomendasi Hari Ini', '2025-06-29 07:55:57'),
(283, 20, 'out', 'Lagi mau masak yang gimana?', '2025-06-29 07:55:57'),
(284, 20, 'in', '🥕 Pake bahan yang ada', '2025-06-29 07:58:39'),
(285, 20, 'in', '/start', '2025-06-29 07:59:20'),
(286, 20, 'in', '/start', '2025-06-29 07:59:50'),
(287, 20, 'out', 'Halo @maulidacy! Selamat datang di *Bot Makanan Trending*! 🍽️', '2025-06-29 07:59:50'),
(288, 20, 'out', 'Silahkan klik menu di bawah ini untuk memilih opsi yang tersedia.', '2025-06-29 07:59:51'),
(289, 20, 'in', 'Cari Makanan', '2025-06-29 07:59:58'),
(290, 20, 'out', 'Silahkan ketik nama makanan yang ingin Anda cari', '2025-06-29 07:59:58'),
(291, 20, 'in', 'Rekomendasi Hari Ini', '2025-06-29 08:00:00'),
(292, 20, 'out', 'Lagi mau masak yang gimana?', '2025-06-29 08:00:01'),
(293, 20, 'in', '🥕 Pake bahan yang ada', '2025-06-29 08:00:02'),
(294, 20, 'in', '🥗 Sehat', '2025-06-29 08:00:12'),
(295, 20, 'out', '🌶️ Resep sehat untukmu:\n\n1. Kale Salad With Grilled Chicken (estimasi waktu)\n2. Kale Apple Salad (estimasi waktu)\nKetik nomor untuk melihat detail resep!', '2025-06-29 08:00:12'),
(296, 20, 'in', 'Rekomendasi Hari Ini', '2025-06-29 08:00:14'),
(297, 20, 'out', 'Lagi mau masak yang gimana?', '2025-06-29 08:00:14'),
(298, 20, 'in', '🔥 Pedas', '2025-06-29 08:00:25'),
(299, 20, 'out', '🌶️ Resep pedas untukmu:\n\n1. Ayam Geprek Ganas (estimasi waktu)\n2. Ayam Geprek Sambel Judes (estimasi waktu)\n3. Ayam Rica-Rica Pedas (estimasi waktu)\nKetik nomor untuk melihat detail resep!', '2025-06-29 08:00:25'),
(300, 20, 'in', '1', '2025-06-29 08:00:30'),
(301, 20, 'out', '🍽️ *Ayam Geprek Ganas*\n\n📂 Kategori: Ayam\n📝 Deskripsi: Ayam geprek dengan level kepedasan yang ganas, cocok untuk pecinta pedas.\n\n📋 Bahan-bahan:\n1 kg ayam potong\n200 gr tepung bumbu siap pakai\n25 buah cabe rawit\n10 siung bawang putih\n2 sdt garam\n1 sdt gula\nMinyak untuk menggoreng\n\n📖 Cara membuat:\n1) Bersihkan ayam, lumuri garam\n2) Balur dengan tepung bumbu, goreng hingga krispi\n3) Ulek cabe rawit, bawang putih, garam, gula hingga halus\n4) Geprek ayam goreng di atas sambal\n5) Aduk rata hingga bumbu meresap\n\n🔗 Sumber: https://cookpad.com/id/resep/4026468', '2025-06-29 08:00:31'),
(302, 20, 'in', 'Rekomendasi Hari Ini', '2025-06-29 08:00:34'),
(303, 20, 'out', 'Lagi mau masak yang gimana?', '2025-06-29 08:00:34'),
(304, 20, 'in', '🔥 Pedas', '2025-06-29 08:00:35'),
(305, 20, 'out', '🌶️ Resep pedas untukmu:\n\n1. Ayam Geprek Ganas (estimasi waktu)\n2. Ayam Geprek Sambel Judes (estimasi waktu)\n3. Ayam Rica-Rica Pedas (estimasi waktu)\nKetik nomor untuk melihat detail resep!', '2025-06-29 08:00:36'),
(306, 20, 'in', 'Rekomendasi Hari Ini', '2025-06-29 08:00:38'),
(307, 20, 'out', 'Lagi mau masak yang gimana?', '2025-06-29 08:00:38'),
(308, 20, 'in', '🥗 Sehat', '2025-06-29 08:00:39'),
(309, 20, 'out', '🌶️ Resep sehat untukmu:\n\n1. Kale Salad With Grilled Chicken (estimasi waktu)\n2. Kale Apple Salad (estimasi waktu)\nKetik nomor untuk melihat detail resep!', '2025-06-29 08:00:40'),
(310, 20, 'in', 'Rekomendasi Hari Ini', '2025-06-29 08:00:43'),
(311, 20, 'out', 'Lagi mau masak yang gimana?', '2025-06-29 08:00:43'),
(312, 20, 'in', '🧀 Cheesy', '2025-06-29 08:00:44'),
(313, 20, 'out', '🌶️ Resep cheesy untukmu:\n\n1. Macaroni Schotel Panggang Super Cheesy (estimasi waktu)\nKetik nomor untuk melihat detail resep!', '2025-06-29 08:00:45'),
(314, 20, 'in', 'Rekomendasi Hari Ini', '2025-06-29 08:00:49'),
(315, 20, 'out', 'Lagi mau masak yang gimana?', '2025-06-29 08:00:49'),
(316, 20, 'in', '🍣 manis', '2025-06-29 08:00:51'),
(317, 20, 'out', '🌶️ Resep manis untukmu:\n\n1. Brownies Kukus ala amanda (estimasi waktu)\n2. Cheese cake (estimasi waktu)\nKetik nomor untuk melihat detail resep!', '2025-06-29 08:00:51'),
(318, 20, 'in', '1', '2025-06-29 08:00:54'),
(319, 20, 'out', '🍽️ *Brownies Kukus ala amanda*\n\n📂 Kategori: Kue\n📝 Deskripsi: Brownies kukus moist dengan coklat yang kaya rasa.\n\n📋 Bahan-bahan:\n4 telur\n150 gr gula pasir\n2 sdt emulsifier (SP)\n80 gr tepung terigu\n35 gr coklat bubuk\n100 gr dark cooking chocolate\n120 ml susu kental manis coklat\n120 gr mentega\n\n📖 Cara membuat:\n1) Mixer telur, gula, dan SP hingga mengembang dan pucat.\n2) Lelehkan mentega dan dark chocolate, campur dengan adonan.\n3) Ayak tepung dan coklat bubuk, masukkan secara bertahap sambil aduk rata.\n4) Tambahkan SKM, aduk balik pelan.\n5) Tuang ke loyang, kukus selama ±30 menit.\n6) Dinginkan sebelum potong, sajikan.\n\n🔗 Sumber: https://cookpad.com/id/resep/3435103-brownies-kukus', '2025-06-29 08:00:55'),
(320, 20, 'in', 'Rekomendasi Hari Ini', '2025-06-29 08:01:05'),
(321, 20, 'out', 'Lagi mau masak yang gimana?', '2025-06-29 08:01:06'),
(322, 20, 'in', '🥕 Pake bahan yang ada', '2025-06-29 08:01:07'),
(323, 20, 'in', 'Tepung, tempe', '2025-06-29 08:01:18'),
(324, 20, 'out', 'Resep dengan bahan yang Anda miliki:\n\n1. Tempe sandal jepit (estimasi waktu)\nKetik nomor untuk melihat detail resep!', '2025-06-29 08:01:19'),
(325, 20, 'in', 'tips', '2025-06-29 08:03:48'),
(326, 20, 'in', 'Rekomendasi Hari Ini', '2025-06-29 08:08:16'),
(327, 20, 'out', 'Lagi mau masak yang gimana?', '2025-06-29 08:08:16'),
(328, 20, 'in', '🥗 Sehat', '2025-06-29 08:08:18'),
(329, 20, 'out', '🌶️ Resep sehat untukmu:\n\n1. Kale Salad With Grilled Chicken (estimasi waktu)\n2. Kale Apple Salad (estimasi waktu)\nKetik nomor untuk melihat detail resep!', '2025-06-29 08:08:18'),
(330, NULL, 'in', '/daftar', '2025-06-29 08:15:10'),
(331, NULL, 'in', '/start', '2025-06-29 08:17:37'),
(332, NULL, 'out', 'Halo @Fiacahyasnack! Selamat datang di *Bot Makanan Trending*! 🍽️', '2025-06-29 08:17:38'),
(333, NULL, 'out', 'Silahkan klik menu di bawah ini untuk memilih opsi yang tersedia.', '2025-06-29 08:17:39'),
(334, NULL, 'in', '/daftar', '2025-06-29 11:21:05'),
(335, NULL, 'in', '/start', '2025-06-29 11:21:27'),
(336, NULL, 'out', 'Halo @null! Selamat datang di *Bot Makanan Trending*! 🍽️', '2025-06-29 11:21:27'),
(337, NULL, 'out', 'Silahkan klik menu di bawah ini untuk memilih opsi yang tersedia.', '2025-06-29 11:21:27'),
(338, NULL, 'in', 'Rekomendasi Hari Ini', '2025-06-29 11:21:30'),
(339, NULL, 'out', 'Lagi mau masak yang gimana?', '2025-06-29 11:21:31'),
(340, NULL, 'in', '🔥 Pedas', '2025-06-29 11:21:33'),
(341, NULL, 'out', '🌶️ Resep pedas untukmu:\n\n1. Ayam Geprek Ganas (estimasi waktu)\n2. Ayam Geprek Sambel Judes (estimasi waktu)\n3. Ayam Rica-Rica Pedas (estimasi waktu)\nKetik nomor untuk melihat detail resep!', '2025-06-29 11:21:33'),
(342, NULL, 'in', '2', '2025-06-29 11:21:36'),
(343, NULL, 'out', '🍽️ *Ayam Geprek Sambel Judes*\n\n📂 Kategori: Ayam\n📝 Deskripsi: Ayam geprek dengan sambal judes (juara pedes) untuk pecinta pedas sejati.\n\n📋 Bahan-bahan:\n1 kg ayam broiler\n150 gr tepung crispy\n30 buah cabe rawit\n20 buah cabe keriting\n8 siung bawang putih\n2 sdt garam\n1 sdt gula merah\nMinyak goreng\n\n📖 Cara membuat:\n1) Potong ayam, bumbui dan goreng crispy\n2) Ulek cabe rawit, cabe keriting, bawang putih\n3) Tambahkan garam dan gula merah\n4) Geprek ayam dengan banyak sambal\n5) Aduk rata hingga ayam tertutup sambal\n\n🔗 Sumber: https://cookpad.com/id/resep/4235891-ayam-geprek-sambel-judes-juara-pedes', '2025-06-29 11:21:37'),
(344, NULL, 'in', 'Makanan Trending', '2025-06-29 11:21:45'),
(345, NULL, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-06-29 11:21:45'),
(346, NULL, 'in', '2', '2025-06-29 11:21:48'),
(347, NULL, 'out', '🍽️ *Cheese cake*\n\n📂 Kategori: Kue\n📝 Deskripsi: Kue keju lembut dan creamy, cocok untuk pencuci mulut.\n\n📋 Bahan-bahan:\nKeju, tepung, telur, gula, mentega\n\n📖 Cara membuat:\n1) Campur bahan kue.\n2) Panggang hingga matang dan berwarna keemasan.\n3) Dinginkan dan sajikan.\n\n🔗 Sumber: ', '2025-06-29 11:21:49'),
(348, NULL, 'in', 'Tips Masak', '2025-06-29 11:21:51'),
(349, NULL, 'out', '👩‍🍳 *Tips Masak Hari Ini!* 🧂\n\n🔸 _🧊 Gunakan air es saat mengadon tepung goreng untuk hasil renyah tahan lama._\n\nCoba praktikkan hari ini, ya! 😋\nIngin tips lain? Ketik *tips* atau klik tombol \"Tips Masak\".', '2025-06-29 11:21:51'),
(350, NULL, 'in', 'tips', '2025-06-29 11:21:58'),
(351, NULL, 'out', '🧂 Gunakan api kecil saat menumis bumbu agar lebih harum dan matang. Tambahkan sedikit gula untuk menyeimbangkan rasa.', '2025-06-29 11:21:59'),
(352, NULL, 'in', 'Cari Makanan', '2025-06-29 11:22:00'),
(353, NULL, 'out', 'Silahkan ketik nama makanan yang ingin Anda cari', '2025-06-29 11:22:01'),
(354, NULL, 'in', 'Gado gado', '2025-06-29 11:22:05'),
(355, NULL, 'out', 'Resep ditemukan:\n\n1. Gado-gado\nKetik nomor untuk melihat detail resep!', '2025-06-29 11:22:05'),
(356, NULL, 'in', '1', '2025-06-29 11:22:09'),
(357, NULL, 'out', '🍽️ *Gado-gado*\n\n📂 Kategori: Salad\n📝 Deskripsi: Salad sayuran rebus dengan bumbu kacang yang gurih dan segar.\n\n📋 Bahan-bahan:\n200 gr kangkung\n200 gr kol\n200 gr tauge\n2 buah tahu goreng\n2 buah tempe goreng\n2 butir telur rebus\n1 buah mentimun\n200 gr kacang tanah sangrai\n3 buah cabe rawit\n2 siung bawang putih\n2 sdm gula merah\n1 sdt garam\n2 sdm air asam jawa\nKerupuk untuk pelengkap\n\n📖 Cara membuat:\n1) Rebus kangkung, kol, dan tauge hingga matang, tiriskan\n2) Sangrai kacang tanah hingga matang, haluskan\n3) Haluskan cabe rawit, bawang putih, gula merah, garam\n4) Campur kacang halus dengan bumbu halus\n5) Tambahkan air asam jawa, aduk rata\n6) Potong tahu, tempe, telur, mentimun\n7) Tata semua sayuran dan pelengkap di piring\n8) Siram dengan bumbu kacang\n9) Sajikan dengan kerupuk\n\n🔗 Sumber: https://cookpad.com/id/resep/4567890-gado-gado-betawi', '2025-06-29 11:22:10'),
(358, 20, 'in', '/start', '2025-06-30 01:54:47'),
(359, 20, 'out', 'Halo @maulidacy! Selamat datang di *Bot Makanan Trending*! 🍽️', '2025-06-30 01:54:48'),
(360, 20, 'out', 'Silahkan klik menu di bawah ini untuk memilih opsi yang tersedia.', '2025-06-30 01:54:49'),
(361, 20, 'in', 'Rekomendasi Hari Ini', '2025-06-30 01:54:50'),
(362, 20, 'out', 'Lagi mau masak yang gimana?', '2025-06-30 01:54:50'),
(363, 20, 'in', '🔥 Pedas', '2025-06-30 01:54:52'),
(364, 20, 'out', '🌶️ Resep pedas untukmu:\n\n1. Ayam Geprek Ganas (estimasi waktu)\n2. Ayam Geprek Sambel Judes (estimasi waktu)\n3. Ayam Rica-Rica Pedas (estimasi waktu)\nKetik nomor untuk melihat detail resep!', '2025-06-30 01:54:53'),
(365, 20, 'in', '1', '2025-06-30 01:54:57'),
(366, 20, 'out', '🍽️ *Ayam Geprek Ganas*\n\n📂 Kategori: Ayam\n📝 Deskripsi: Ayam geprek dengan level kepedasan yang ganas, cocok untuk pecinta pedas.\n\n📋 Bahan-bahan:\n1 kg ayam potong\n200 gr tepung bumbu siap pakai\n25 buah cabe rawit\n10 siung bawang putih\n2 sdt garam\n1 sdt gula\nMinyak untuk menggoreng\n\n📖 Cara membuat:\n1) Bersihkan ayam, lumuri garam\n2) Balur dengan tepung bumbu, goreng hingga krispi\n3) Ulek cabe rawit, bawang putih, garam, gula hingga halus\n4) Geprek ayam goreng di atas sambal\n5) Aduk rata hingga bumbu meresap\n\n🔗 Sumber: https://cookpad.com/id/resep/4026468', '2025-06-30 01:54:58'),
(367, 20, 'in', '/start', '2025-06-30 02:06:55'),
(368, 20, 'out', 'Halo @maulidacy! Selamat datang di *Bot Makanan Trending*! 🍽️', '2025-06-30 02:06:55'),
(369, 20, 'out', 'Silahkan klik menu di bawah ini untuk memilih opsi yang tersedia.', '2025-06-30 02:06:56'),
(370, 20, 'in', 'Cari Makanan', '2025-06-30 02:06:56'),
(371, 20, 'out', 'Silahkan ketik nama makanan yang ingin Anda cari', '2025-06-30 02:06:57'),
(372, 20, 'in', 'Makanan Trending', '2025-06-30 02:06:57'),
(373, 20, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-06-30 02:06:58'),
(374, 20, 'in', 'Makanan Trending', '2025-06-30 02:09:55'),
(375, 20, 'out', '🍽️ Makanan Trending:\n\n\nKetik nomor untuk melihat detail resep!', '2025-06-30 02:09:55'),
(376, 20, 'in', '/start', '2025-06-30 02:17:12'),
(377, 20, 'out', 'Halo @maulidacy! Selamat datang di *Bot Makanan Trending*! 🍽️', '2025-06-30 02:17:12'),
(378, 20, 'out', 'Silahkan klik menu di bawah ini untuk memilih opsi yang tersedia.', '2025-06-30 02:17:13'),
(379, NULL, 'in', '/daftar', '2025-06-30 02:53:45'),
(380, NULL, 'in', '/daftar', '2025-06-30 03:45:22'),
(381, NULL, 'in', '/start', '2025-06-30 03:45:50'),
(382, NULL, 'out', 'Halo @ajibsusanto! Selamat datang di *Bot Makanan Trending*! 🍽️', '2025-06-30 03:45:50'),
(383, NULL, 'out', 'Silahkan klik menu di bawah ini untuk memilih opsi yang tersedia.', '2025-06-30 03:45:51'),
(384, NULL, 'in', 'Makanan Trending', '2025-06-30 03:45:54'),
(385, NULL, 'out', '🍽️ Makanan Trending:\n\n\nKetik nomor untuk melihat detail resep!', '2025-06-30 03:45:54'),
(386, NULL, 'in', 'Rekomendasi Hari Ini', '2025-06-30 03:46:07'),
(387, NULL, 'out', 'Lagi mau masak yang gimana?', '2025-06-30 03:46:09'),
(388, NULL, 'in', '🔥 Pedas', '2025-06-30 03:46:11'),
(389, NULL, 'in', '🥗 Sehat', '2025-06-30 03:46:15'),
(390, NULL, 'out', '😊 Wah, sepertinya aku belum paham maksud kamu. \n➡️ Yuk, pilih menu di bawah ini ya:', '2025-06-30 03:46:15'),
(391, NULL, 'in', 'Menu', '2025-06-30 03:46:45'),
(392, NULL, 'out', 'Menu hari ini tersedia nasi goreng, mie ayam, dan sate.', '2025-06-30 03:46:46'),
(393, NULL, 'in', 'Tips', '2025-06-30 03:46:58'),
(394, NULL, 'out', '🧂 Gunakan api kecil saat menumis bumbu agar lebih harum dan matang. Tambahkan sedikit gula untuk menyeimbangkan rasa.', '2025-06-30 03:46:59'),
(395, NULL, 'in', 'Tips Masak', '2025-06-30 03:47:10'),
(396, NULL, 'out', '👩‍🍳 *Tips Masak Hari Ini!* 🧂\n\n🔸 _🥬 Jangan mencuci jamur dengan air terlalu lama, cukup lap lembab agar tidak lembek._\n\nCoba praktikkan hari ini, ya! 😋\nIngin tips lain? Ketik *tips* atau klik tombol \"Tips Masak\".', '2025-06-30 03:47:10'),
(397, NULL, 'in', 'Cari Makanan', '2025-06-30 03:47:39'),
(398, NULL, 'out', 'Silahkan ketik nama makanan yang ingin Anda cari', '2025-06-30 03:47:40'),
(399, NULL, 'in', 'Mangut', '2025-06-30 03:48:03'),
(400, 20, 'in', 'Cari Makanan', '2025-06-30 03:48:09'),
(401, 20, 'out', 'Silahkan ketik nama makanan yang ingin Anda cari', '2025-06-30 03:48:12'),
(402, NULL, 'in', 'Cari Makanan', '2025-06-30 03:48:14'),
(403, NULL, 'out', 'Silahkan ketik nama makanan yang ingin Anda cari', '2025-06-30 03:48:15'),
(404, 20, 'in', 'Ayam geprek', '2025-06-30 03:48:17');
INSERT INTO `messages` (`id`, `user_id`, `direction`, `message`, `created_at`) VALUES
(405, 20, 'in', 'Cari Makanan', '2025-06-30 03:48:22'),
(406, 20, 'out', 'Silahkan ketik nama makanan yang ingin Anda cari', '2025-06-30 03:48:23'),
(407, 20, 'in', 'Gado gado', '2025-06-30 03:48:25'),
(408, NULL, 'in', 'Ayam Geprek', '2025-06-30 03:48:29'),
(409, 20, 'in', 'Makanan Trending', '2025-06-30 03:50:27'),
(410, 20, 'out', '🍽️ Makanan Trending:\n\n\nKetik nomor untuk melihat detail resep!', '2025-06-30 03:50:28'),
(411, 20, 'in', 'Rekomendasi Hari Ini', '2025-06-30 03:50:31'),
(412, 20, 'out', 'Lagi mau masak yang gimana?', '2025-06-30 03:50:32'),
(413, 20, 'in', '🔥 Pedas', '2025-06-30 03:50:34'),
(414, 20, 'in', '🥗 Sehat', '2025-06-30 03:50:38'),
(415, 20, 'out', '😊 Wah, sepertinya aku belum paham maksud kamu. \n➡️ Yuk, pilih menu di bawah ini ya:', '2025-06-30 03:50:39'),
(416, 20, 'in', 'Cari Makanan', '2025-06-30 03:50:42'),
(417, 20, 'out', 'Silahkan ketik nama makanan yang ingin Anda cari', '2025-06-30 03:50:43'),
(418, 20, 'in', 'Tips Masak', '2025-06-30 03:51:35'),
(419, 20, 'out', '👩‍🍳 *Tips Masak Hari Ini!* 🧂\n\n🔸 _🌶️ Jangan terlalu sering membalik gorengan agar tidak menyerap minyak._\n\nCoba praktikkan hari ini, ya! 😋\nIngin tips lain? Ketik *tips* atau klik tombol \"Tips Masak\".', '2025-06-30 03:51:36'),
(420, 20, 'in', 'Rekomendasi Hari Ini', '2025-06-30 03:51:42'),
(421, 20, 'out', 'Lagi mau masak yang gimana?', '2025-06-30 03:51:46'),
(422, 20, 'in', '🥗 Sehat', '2025-06-30 03:51:47'),
(423, 20, 'in', '🔥 Pedas', '2025-06-30 03:52:37'),
(424, 20, 'out', '😊 Wah, sepertinya aku belum paham maksud kamu. \n➡️ Yuk, pilih menu di bawah ini ya:', '2025-06-30 03:52:38'),
(425, 20, 'in', 'Makanan Trending', '2025-06-30 03:52:42'),
(426, 20, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-06-30 03:52:43'),
(427, 20, 'in', '1', '2025-06-30 03:52:51'),
(428, 20, 'out', '🍽️ *Tempe sandal jepit*\n\n📂 Kategori: Camilan\n📝 Deskripsi: Tempe goreng dengan bentuk unik seperti sandal jepit, renyah dan gurih.\n\n📋 Bahan-bahan:\nTempe, tepung bumbu, minyak goreng\n\n📖 Cara membuat:\n1) Potong tempe tipis memanjang menyerupai sandal jepit.\n2) Lumuri dengan tepung bumbu.\n3) Goreng hingga kuning keemasan dan renyah.\n4) Sajikan hangat.\n\n🔗 Sumber: ', '2025-06-30 03:52:51'),
(429, 20, 'in', 'Makanan Trending', '2025-06-30 03:54:04'),
(430, 20, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-06-30 03:54:05'),
(431, 20, 'in', '1', '2025-06-30 03:54:08'),
(432, 20, 'out', '🍽️ *Tempe sandal jepit*\n\n📂 Kategori: Camilan\n📝 Deskripsi: Tempe goreng dengan bentuk unik seperti sandal jepit, renyah dan gurih.\n\n📋 Bahan-bahan:\nTempe, tepung bumbu, minyak goreng\n\n📖 Cara membuat:\n1) Potong tempe tipis memanjang menyerupai sandal jepit.\n2) Lumuri dengan tepung bumbu.\n3) Goreng hingga kuning keemasan dan renyah.\n4) Sajikan hangat.\n\n🔗 Sumber: ', '2025-06-30 03:54:09'),
(433, 20, 'in', 'Cari Makanan', '2025-06-30 03:54:27'),
(434, 20, 'out', 'Silahkan ketik nama makanan yang ingin Anda cari', '2025-06-30 03:54:28'),
(435, 20, 'in', 'Gado gado', '2025-06-30 03:54:31'),
(436, 20, 'out', 'Resep ditemukan:\n\n1. Gado-gado\nKetik nomor untuk melihat detail resep!', '2025-06-30 03:54:31'),
(437, 20, 'in', '1', '2025-06-30 03:54:36'),
(438, 20, 'out', '🍽️ *Gado-gado*\n\n📂 Kategori: Salad\n📝 Deskripsi: Salad sayuran rebus dengan bumbu kacang yang gurih dan segar.\n\n📋 Bahan-bahan:\n200 gr kangkung\n200 gr kol\n200 gr tauge\n2 buah tahu goreng\n2 buah tempe goreng\n2 butir telur rebus\n1 buah mentimun\n200 gr kacang tanah sangrai\n3 buah cabe rawit\n2 siung bawang putih\n2 sdm gula merah\n1 sdt garam\n2 sdm air asam jawa\nKerupuk untuk pelengkap\n\n📖 Cara membuat:\n1) Rebus kangkung, kol, dan tauge hingga matang, tiriskan\n2) Sangrai kacang tanah hingga matang, haluskan\n3) Haluskan cabe rawit, bawang putih, gula merah, garam\n4) Campur kacang halus dengan bumbu halus\n5) Tambahkan air asam jawa, aduk rata\n6) Potong tahu, tempe, telur, mentimun\n7) Tata semua sayuran dan pelengkap di piring\n8) Siram dengan bumbu kacang\n9) Sajikan dengan kerupuk\n\n🔗 Sumber: https://cookpad.com/id/resep/4567890-gado-gado-betawi', '2025-06-30 03:54:37'),
(439, 20, 'in', 'Alo', '2025-06-30 03:57:40'),
(440, 20, 'in', 'Alo', '2025-06-30 03:57:46'),
(441, 20, 'out', 'Halo! Ada yang bisa saya bantu?', '2025-06-30 03:57:48'),
(442, 20, 'in', '/start', '2025-06-30 03:57:48'),
(443, 20, 'out', 'Halo! Ada yang bisa saya bantu?', '2025-06-30 03:57:49'),
(444, 20, 'in', '/start', '2025-06-30 03:57:49'),
(445, 20, 'out', 'Halo @maulidacy! Selamat datang di *Bot Makanan Trending*! 🍽️', '2025-06-30 03:57:49'),
(446, 20, 'out', 'Halo @maulidacy! Selamat datang di *Bot Makanan Trending*! 🍽️', '2025-06-30 03:57:50'),
(447, 20, 'out', 'Silahkan klik menu di bawah ini untuk memilih opsi yang tersedia.', '2025-06-30 03:57:50'),
(448, 20, 'out', 'Silahkan klik menu di bawah ini untuk memilih opsi yang tersedia.', '2025-06-30 03:57:51'),
(449, 20, 'in', 'Makanan Trending', '2025-06-30 03:57:53'),
(450, 20, 'in', 'Makanan Trending', '2025-06-30 03:57:53'),
(451, 20, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-06-30 03:57:54'),
(452, 20, 'out', '🍽️ Makanan Trending:\n\n\nKetik nomor untuk melihat detail resep!', '2025-06-30 03:57:54'),
(453, 20, 'in', '1', '2025-06-30 03:58:03'),
(454, 20, 'in', '1', '2025-06-30 03:58:03'),
(455, 20, 'out', '🍽️ *Tempe sandal jepit*\n\n📂 Kategori: Camilan\n📝 Deskripsi: Tempe goreng dengan bentuk unik seperti sandal jepit, renyah dan gurih.\n\n📋 Bahan-bahan:\nTempe, tepung bumbu, minyak goreng\n\n📖 Cara membuat:\n1) Potong tempe tipis memanjang menyerupai sandal jepit.\n2) Lumuri dengan tepung bumbu.\n3) Goreng hingga kuning keemasan dan renyah.\n4) Sajikan hangat.\n\n🔗 Sumber: ', '2025-06-30 03:58:11'),
(456, NULL, 'in', '/daftar', '2025-07-05 05:30:26'),
(457, NULL, 'in', '/daftar', '2025-07-05 05:35:09'),
(458, NULL, 'in', '/start', '2025-07-05 05:35:38'),
(459, NULL, 'out', 'Halo @Fiacahyasnack! Selamat datang di *Bot Makanan Trending*! 🍽️', '2025-07-05 05:35:38'),
(460, NULL, 'out', 'Silahkan klik menu di bawah ini untuk memilih opsi yang tersedia.', '2025-07-05 05:35:38'),
(461, NULL, 'in', '/start', '2025-07-05 05:35:52'),
(462, NULL, 'out', 'Halo @Fiacahyasnack! Selamat datang di *Bot Makanan Trending*! 🍽️', '2025-07-05 05:35:52'),
(463, NULL, 'out', 'Silahkan klik menu di bawah ini untuk memilih opsi yang tersedia.', '2025-07-05 05:35:53'),
(464, NULL, 'in', '/trending', '2025-07-05 05:36:10'),
(465, NULL, 'out', '😊 Wah, sepertinya aku belum paham maksud kamu. \n➡️ Yuk, pilih menu di bawah ini ya:', '2025-07-05 05:36:10'),
(466, NULL, 'in', '/start', '2025-07-05 05:36:22'),
(467, NULL, 'out', 'Halo @Fiacahyasnack! Selamat datang di *Bot Makanan Trending*! 🍽️', '2025-07-05 05:36:22'),
(468, NULL, 'out', 'Silahkan klik menu di bawah ini untuk memilih opsi yang tersedia.', '2025-07-05 05:36:23'),
(469, NULL, 'in', 'Makanan Trending', '2025-07-05 05:36:27'),
(470, NULL, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 05:36:28'),
(471, NULL, 'in', '4', '2025-07-05 05:36:41'),
(472, NULL, 'out', '🍽️ *Es pisang ijo*\n\n📂 Kategori: Minuman\n📝 Deskripsi: Minuman segar dari pisang yang dibalut dengan adonan hijau dan disajikan dengan sirup manis.\n\n📋 Bahan-bahan:\nPisang, tepung beras, santan, gula merah, es batu\n\n📖 Cara membuat:\n1) Balut pisang dengan adonan tepung beras hijau.\n2) Kukus hingga matang.\n3) Sajikan dengan sirup gula merah dan es batu.\n\n🔗 Sumber: ', '2025-07-05 05:36:42'),
(473, NULL, 'in', 'Makanan Trending', '2025-07-05 05:40:24'),
(474, NULL, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 05:40:25'),
(475, NULL, 'in', '1', '2025-07-05 05:40:29'),
(476, NULL, 'out', '🍽️ *Tempe sandal jepit*\n\n📂 Kategori: Camilan\n📝 Deskripsi: Tempe goreng dengan bentuk unik seperti sandal jepit, renyah dan gurih.\n\n📋 Bahan-bahan:\nTempe, tepung bumbu, minyak goreng\n\n📖 Cara membuat:\n1) Potong tempe tipis memanjang menyerupai sandal jepit.\n2) Lumuri dengan tepung bumbu.\n3) Goreng hingga kuning keemasan dan renyah.\n4) Sajikan hangat.\n\n🔗 Sumber: ', '2025-07-05 05:40:29'),
(477, NULL, 'in', 'Makanan Trending', '2025-07-05 05:40:37'),
(478, NULL, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 05:40:37'),
(479, NULL, 'in', '4', '2025-07-05 05:40:41'),
(480, NULL, 'out', '🍽️ *Es pisang ijo*\n\n📂 Kategori: Minuman\n📝 Deskripsi: Minuman segar dari pisang yang dibalut dengan adonan hijau dan disajikan dengan sirup manis.\n\n📋 Bahan-bahan:\nPisang, tepung beras, santan, gula merah, es batu\n\n📖 Cara membuat:\n1) Balut pisang dengan adonan tepung beras hijau.\n2) Kukus hingga matang.\n3) Sajikan dengan sirup gula merah dan es batu.\n\n🔗 Sumber: ', '2025-07-05 05:40:41'),
(481, NULL, 'in', 'Makanan Trending', '2025-07-05 05:42:11'),
(482, NULL, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 05:42:13'),
(483, NULL, 'in', 'Makanan Trending', '2025-07-05 05:43:02'),
(484, NULL, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 05:43:03'),
(485, NULL, 'in', '4', '2025-07-05 05:43:06'),
(486, NULL, 'out', '🍽️ *Es pisang ijo*\n\n📂 Kategori: Minuman\n📝 Deskripsi: Minuman segar dari pisang yang dibalut dengan adonan hijau dan disajikan dengan sirup manis.\n\n📋 Bahan-bahan:\nPisang, tepung beras, santan, gula merah, es batu\n\n📖 Cara membuat:\n1) Balut pisang dengan adonan tepung beras hijau.\n2) Kukus hingga matang.\n3) Sajikan dengan sirup gula merah dan es batu.\n\n🔗 Sumber: https://cookpad.com/id/resep/24706698?ref=search&search_term=es+pisang+ijo', '2025-07-05 05:43:06'),
(487, NULL, 'in', 'Makanan Trending', '2025-07-05 05:43:19'),
(488, NULL, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 05:43:19'),
(489, NULL, 'in', '/start', '2025-07-05 05:44:58'),
(490, NULL, 'out', 'Halo @Fiacahyasnack! Selamat datang di *Bot Makanan Trending*! 🍽️', '2025-07-05 05:44:59'),
(491, NULL, 'out', 'Silahkan klik menu di bawah ini untuk memilih opsi yang tersedia.', '2025-07-05 05:45:00'),
(492, NULL, 'in', 'Makanan Trending', '2025-07-05 05:45:01'),
(493, NULL, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 05:45:01'),
(494, NULL, 'in', '4', '2025-07-05 05:45:04'),
(495, NULL, 'out', '🍽️ *Es pisang ijo*\n\n📂 Kategori: Minuman\n📝 Deskripsi: Minuman segar dari pisang yang dibalut dengan adonan hijau dan disajikan dengan sirup manis.\n\n📋 Bahan-bahan:\nPisang, tepung beras, santan, gula merah, es batu\n\n📖 Cara membuat:\n1) Balut pisang dengan adonan tepung beras hijau.\n2) Kukus hingga matang.\n3) Sajikan dengan sirup gula merah dan es batu.\n\n🔗 Sumber: https://cookpad.com/id/resep/24706698?ref=search&search_term=es+pisang+ijo', '2025-07-05 05:45:04'),
(496, NULL, 'in', 'Makanan Trending', '2025-07-05 05:46:17'),
(497, NULL, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 05:46:17'),
(498, NULL, 'in', '4', '2025-07-05 05:46:20'),
(499, NULL, 'out', '🍽️ *Es pisang ijo*\n\n📂 Kategori: Minuman\n📝 Deskripsi: Minuman segar dari pisang yang dibalut dengan adonan hijau dan disajikan dengan sirup manis.\n\n📋 Bahan-bahan:\nPisang, tepung beras, santan, gula merah, es batu\n\n📖 Cara membuat:\n1) Balut pisang dengan adonan tepung beras hijau.\n2) Kukus hingga matang.\n3) Sajikan dengan sirup gula merah dan es batu.\n\n🔗 Sumber: [https://cookpad\\.com/id/resep/24706698?ref\\=search&search\\_term\\=es\\+pisang\\+ijo](https://cookpad.com/id/resep/24706698?ref=search&search_term=es+pisang+ijo)', '2025-07-05 05:46:20'),
(500, NULL, 'in', 'Makanan Trending', '2025-07-05 05:50:22'),
(501, NULL, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 05:50:23'),
(502, NULL, 'in', '1', '2025-07-05 05:50:26'),
(503, NULL, 'out', '🍽️ *Tempe sandal jepit*\n\n📂 Kategori: Camilan\n📝 Deskripsi: Tempe goreng dengan bentuk unik seperti sandal jepit, renyah dan gurih.\n\n📋 Bahan-bahan:\nTempe, tepung bumbu, minyak goreng\n\n📖 Cara membuat:\n1) Potong tempe tipis memanjang menyerupai sandal jepit.\n2) Lumuri dengan tepung bumbu.\n3) Goreng hingga kuning keemasan dan renyah.\n4) Sajikan hangat.\n\n🔗 Sumber: []()', '2025-07-05 05:50:26'),
(504, NULL, 'in', 'Makanan Trending', '2025-07-05 05:56:01'),
(505, NULL, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n8. Cheesecake\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 05:56:02'),
(506, NULL, 'in', '1', '2025-07-05 05:56:05'),
(507, NULL, 'out', '🍽️ *Tempe sandal jepit*\n\n📂 Kategori: Camilan\n📝 Deskripsi: Tempe goreng dengan bentuk unik seperti sandal jepit, renyah dan gurih.\n\n📋 Bahan-bahan:\nTempe, tepung bumbu, minyak goreng\n\n📖 Cara membuat:\n1) Potong tempe tipis memanjang menyerupai sandal jepit.\n2) Lumuri dengan tepung bumbu.\n3) Goreng hingga kuning keemasan dan renyah.\n4) Sajikan hangat.\n\n🔗 Sumber: []()', '2025-07-05 05:56:05'),
(508, NULL, 'in', 'Makanan Trending', '2025-07-05 05:59:26'),
(509, NULL, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n8. Cheesecake\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 05:59:26'),
(510, NULL, 'in', '1', '2025-07-05 05:59:29'),
(511, NULL, 'out', '🍽️ *Tempe sandal jepit*\n\n📂 Kategori: Camilan\n📝 Deskripsi: Tempe goreng dengan bentuk unik seperti sandal jepit, renyah dan gurih.\n\n📋 Bahan-bahan:\nTempe, tepung bumbu, minyak goreng\n\n📖 Cara membuat:\n1) Potong tempe tipis memanjang menyerupai sandal jepit.\n2) Lumuri dengan tepung bumbu.\n3) Goreng hingga kuning keemasan dan renyah.\n4) Sajikan hangat.\n\n🔗 Sumber: []()', '2025-07-05 05:59:29'),
(512, NULL, 'in', 'Makanan Trending', '2025-07-05 05:59:35'),
(513, NULL, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n8. Cheesecake\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 05:59:35'),
(514, NULL, 'in', '3', '2025-07-05 05:59:46'),
(515, NULL, 'out', '🍽️ *Bolu ketan hitam keju lumer*\n\n📂 Kategori: Kue\n📝 Deskripsi: Bolu ketan hitam dengan topping keju yang meleleh, manis dan lezat.\n\n📋 Bahan-bahan:\nTepung ketan hitam, keju, telur, gula, mentega\n\n📖 Cara membuat:\n1) Campur bahan.\n2) Panggang hingga matang.\n3) Tambahkan keju leleh di atasnya.\n4) Sajikan hangat.\n\n🔗 Sumber: []()', '2025-07-05 05:59:47'),
(516, NULL, 'in', 'Makanan Trending', '2025-07-05 06:00:10'),
(517, NULL, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n8. Cheesecake\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 06:00:11'),
(518, NULL, 'in', 'Makanan Trending', '2025-07-05 06:00:13'),
(519, NULL, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n8. Cheesecake\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 06:00:13'),
(520, NULL, 'in', '4', '2025-07-05 06:00:16'),
(521, NULL, 'out', '🍽️ *Es pisang ijo*\n\n📂 Kategori: Minuman\n📝 Deskripsi: Minuman segar dari pisang yang dibalut dengan adonan hijau dan disajikan dengan sirup manis.\n\n📋 Bahan-bahan:\nPisang, tepung beras, santan, gula merah, es batu\n\n📖 Cara membuat:\n1) Balut pisang dengan adonan tepung beras hijau.\n2) Kukus hingga matang.\n3) Sajikan dengan sirup gula merah dan es batu.\n\n🔗 Sumber: [https://cookpad\\.com/id/resep/24706698?ref\\=search&search\\_term\\=es\\+pisang\\+ijo](https://cookpad.com/id/resep/24706698?ref=search&search_term=es+pisang+ijo)', '2025-07-05 06:00:16'),
(522, NULL, 'in', 'Makanan Trending', '2025-07-05 06:01:39'),
(523, NULL, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n8. Cheesecake\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 06:01:39'),
(524, NULL, 'in', '1', '2025-07-05 06:01:43'),
(525, NULL, 'out', '🍽️ *Tempe sandal jepit*\n\n📂 Kategori: Camilan\n📝 Deskripsi: Tempe goreng dengan bentuk unik seperti sandal jepit, renyah dan gurih.\n\n📋 Bahan-bahan:\nTempe, tepung bumbu, minyak goreng\n\n📖 Cara membuat:\n1) Potong tempe tipis memanjang menyerupai sandal jepit.\n2) Lumuri dengan tepung bumbu.\n3) Goreng hingga kuning keemasan dan renyah.\n4) Sajikan hangat.\n\n🔗 Sumber: []()', '2025-07-05 06:01:44'),
(526, NULL, 'in', 'Makanan Trending', '2025-07-05 06:01:49'),
(527, NULL, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheese cake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n8. Cheesecake\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 06:01:49'),
(528, NULL, 'in', '4', '2025-07-05 06:01:54'),
(529, NULL, 'out', '🍽️ *Es pisang ijo*\n\n📂 Kategori: Minuman\n📝 Deskripsi: Minuman segar dari pisang yang dibalut dengan adonan hijau dan disajikan dengan sirup manis.\n\n📋 Bahan-bahan:\nPisang, tepung beras, santan, gula merah, es batu\n\n📖 Cara membuat:\n1) Balut pisang dengan adonan tepung beras hijau.\n2) Kukus hingga matang.\n3) Sajikan dengan sirup gula merah dan es batu.\n\n🔗 Sumber: [https://cookpad\\.com/id/resep/24706698?ref\\=search&search\\_term\\=es\\+pisang\\+ijo](https://cookpad.com/id/resep/24706698?ref=search&search_term=es+pisang+ijo)', '2025-07-05 06:01:55'),
(530, NULL, 'in', 'Makanan Trending', '2025-07-05 06:03:04'),
(531, NULL, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheesecake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n8. Tempe sandal jepit\n9. Cheese cake\n10. Bolu ketan hitam keju lumer\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 06:03:04'),
(532, NULL, 'in', '3', '2025-07-05 06:03:13'),
(533, NULL, 'out', '🍽️ *Bolu ketan hitam keju lumer*\n\n📂 Kategori: Kue\n📝 Deskripsi: Bolu ketan hitam lembut dengan isian keju lumer di tengah, manis dan legit.\n\n📋 Bahan-bahan:\n4 butir telur, 135 g gula pasir, 175 g tepung ketan hitam, 100 ml minyak, 65 ml santan, keju parut, SKM\n\n📖 Cara membuat:\n1) Kocok telur dan gula hingga kental.\n2) Masukkan tepung ketan, minyak, dan santan.\n3) Tuang sebagian adonan, beri isian keju + SKM.\n4) Tutup sisa adonan, panggang hingga matang.\n5) Sajikan hangat.\n\n🔗 Sumber: [https://cookpad\\.com/id/resep/24748044\\-bolu\\-ketan\\-hitam\\-keju\\-lumer](https://cookpad.com/id/resep/24748044-bolu-ketan-hitam-keju-lumer)', '2025-07-05 06:03:14'),
(534, NULL, 'in', 'Makanan Trending', '2025-07-05 06:03:25'),
(535, NULL, 'out', '🍽️ Makanan Trending:\n\n1. Tempe sandal jepit\n2. Cheesecake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n8. Tempe sandal jepit\n9. Cheese cake\n10. Bolu ketan hitam keju lumer\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 06:03:26'),
(536, NULL, 'in', '4', '2025-07-05 06:03:30'),
(537, NULL, 'out', '🍽️ *Es pisang ijo*\n\n📂 Kategori: Minuman\n📝 Deskripsi: Minuman segar dari pisang yang dibalut adonan hijau dan disajikan dengan sirup manis.\n\n📋 Bahan-bahan:\n100 gr tepung beras, 100 gr tepung terigu, 500 ml santan, 50 gr gula pasir, 1/2 sdt garam, pasta pandan secukupnya\n\n📖 Cara membuat:\n1) Balut pisang dengan adonan tepung beras hijau.\n2) Kukus hingga matang.\n3) Sajikan dengan sirup gula merah dan es batu.\n\n🔗 Sumber: [https://cookpad\\.com/id/resep/24706698?ref\\=search&search\\_term\\=es\\+pisang\\+ijo](https://cookpad.com/id/resep/24706698?ref=search&search_term=es+pisang+ijo)', '2025-07-05 06:03:30'),
(538, NULL, 'in', 'Makanan Trending', '2025-07-05 06:07:35'),
(539, NULL, 'out', '🔥 *MAKANAN TRENDING BULAN INI* 🔥\n\n1. Tempe sandal jepit\n2. Cheesecake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n8. Tempe sandal jepit\n9. Cheese cake\n10. Bolu ketan hitam keju lumer\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 06:07:36'),
(540, NULL, 'in', 'Makanan Trending', '2025-07-05 06:09:19'),
(541, NULL, 'out', '🔥 *MAKANAN TRENDING BULAN INI* 🔥\n\n1. Tempe sandal jepit\n2. Cheesecake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 06:09:19'),
(542, NULL, 'in', '7', '2025-07-05 06:09:24'),
(543, NULL, 'out', '🍽️ *Rendang sapi melted*\n\n📂 Kategori: Daging\n📝 Deskripsi: Rendang khas Padang dengan tambahan keju leleh yang menggoda.\n\n📋 Bahan-bahan:\nDaging sapi, santan, bumbu rendang (serai, lengkuas, cabai, bawang), keju leleh\n\n📖 Cara membuat:\n1) Masak rendang hingga empuk dan bumbu meresap.\n2) Tambahkan keju leleh menjelang penyajian.\n3) Aduk sebentar dan sajikan hangat.\n\n🔗 Sumber: [https://cookpad\\.com/id/resep/15993390\\-rendang\\-sapi\\-lumer\\-leleh\\-keju](https://cookpad.com/id/resep/15993390-rendang-sapi-lumer-leleh-keju)', '2025-07-05 06:09:25'),
(544, NULL, 'in', 'Makanan Trending', '2025-07-05 06:10:10'),
(545, NULL, 'out', '🔥 *MAKANAN TRENDING BULAN INI* 🔥\n\n1. Tempe sandal jepit\n2. Cheesecake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 06:10:10'),
(546, NULL, 'in', '2', '2025-07-05 06:10:13'),
(547, NULL, 'out', '🍽️ *Cheesecake*\n\n📂 Kategori: Kue\n📝 Deskripsi: Kue keju klasik yang lembut dan creamy, cocok untuk dessert.\n\n📋 Bahan-bahan:\n400 g cream cheese, 130 g gula, 2 sdm maizena, 2 butir telur, 1 kuning telur, 100 ml krim kental, biskuit dan mentega untuk dasar\n\n📖 Cara membuat:\n1) Hancurkan biskuit, campur dengan mentega, tekan di loyang.\n2) Campur cream cheese, gula, maizena, telur, dan krim.\n3) Tuang di atas dasar biskuit.\n4) Panggang hingga matang dan berwarna keemasan.\n5) Dinginkan sebelum disajikan.\n\n🔗 Sumber: [https://www\\.onceuponachef\\.com/recipes/classic\\-cheesecake\\.html](https://www.onceuponachef.com/recipes/classic-cheesecake.html)', '2025-07-05 06:10:14'),
(548, NULL, 'in', 'Makanan Trending', '2025-07-05 06:10:59'),
(549, NULL, 'out', '🔥 *MAKANAN TRENDING BULAN INI* 🔥\n\n1. Sushi gulung martabak\n2. Rendang sapi melted\n3. Tempe sandal jepit\n4. Cheese cake\n5. Bolu ketan hitam keju lumer\n6. Es pisang ijo\n7. Bakso bomber\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 06:11:00'),
(550, NULL, 'in', '5', '2025-07-05 06:11:12'),
(551, NULL, 'out', '🍽️ *Bolu ketan hitam keju lumer*\n\n📂 Kategori: Kue\n📝 Deskripsi: Bolu ketan hitam dengan topping keju yang meleleh, manis dan lezat.\n\n📋 Bahan-bahan:\nTepung ketan hitam, keju, telur, gula, mentega\n\n📖 Cara membuat:\n1) Campur bahan.\n2) Panggang hingga matang.\n3) Tambahkan keju leleh di atasnya.\n4) Sajikan hangat.\n\n🔗 Sumber: []()', '2025-07-05 06:11:12'),
(552, NULL, 'in', 'Rekomendasi Hari Ini', '2025-07-05 06:11:53'),
(553, NULL, 'out', 'Lagi mau masak yang gimana?', '2025-07-05 06:11:53'),
(554, NULL, 'in', '🔥 Pedas', '2025-07-05 06:11:56'),
(555, NULL, 'out', '🌶️ Resep pedas untukmu:\n\n1. Ayam Geprek Ganas (estimasi waktu)\n2. Ayam Geprek Sambel Judes (estimasi waktu)\n3. Ayam Rica-Rica Pedas (estimasi waktu)\nKetik nomor untuk melihat detail resep!', '2025-07-05 06:11:56'),
(556, NULL, 'in', '2', '2025-07-05 06:11:59'),
(557, NULL, 'out', '🍽️ *Ayam Geprek Sambel Judes*\n\n📂 Kategori: Ayam\n📝 Deskripsi: Ayam geprek dengan sambal judes (juara pedes) untuk pecinta pedas sejati.\n\n📋 Bahan-bahan:\n1 kg ayam broiler\n150 gr tepung crispy\n30 buah cabe rawit\n20 buah cabe keriting\n8 siung bawang putih\n2 sdt garam\n1 sdt gula merah\nMinyak goreng\n\n📖 Cara membuat:\n1) Potong ayam, bumbui dan goreng crispy\n2) Ulek cabe rawit, cabe keriting, bawang putih\n3) Tambahkan garam dan gula merah\n4) Geprek ayam dengan banyak sambal\n5) Aduk rata hingga ayam tertutup sambal\n\n🔗 Sumber: [https://cookpad\\.com/id/resep/4235891\\-ayam\\-geprek\\-sambel\\-judes\\-juara\\-pedes](https://cookpad.com/id/resep/4235891-ayam-geprek-sambel-judes-juara-pedes)', '2025-07-05 06:11:59'),
(558, NULL, 'in', 'Cari Makanan', '2025-07-05 06:12:01'),
(559, NULL, 'out', 'Silahkan ketik nama makanan yang ingin Anda cari', '2025-07-05 06:12:02'),
(560, NULL, 'in', 'Ayam', '2025-07-05 06:12:04'),
(561, NULL, 'out', 'Resep ditemukan:\n\n1. Ayam Geprek\n2. Ayam Geprek Bensu\n3. Ayam Geprek Ganas\n4. Ayam Geprek Sambal Matah\n5. Ayam Geprek Ala Preksu Jogja\nKetik nomor untuk melihat detail resep!', '2025-07-05 06:12:05'),
(562, NULL, 'in', '1', '2025-07-05 06:12:09'),
(563, NULL, 'out', '🍽️ *Ayam Geprek*\n\n📂 Kategori: Ayam\n📝 Deskripsi: Ayam goreng krispi yang digeprek dengan sambal pedas. Cocok untuk makan siang praktis.\n\n📋 Bahan-bahan:\n250 gr daging ayam\n1 bungkus tepung ayam goreng instan\n5 siung bawang putih\n10 cabai rawit merah\n1 sdt garam\n1 sdt gula\nMinyak goreng secukupnya\n\n📖 Cara membuat:\n1) Lumuri ayam dengan tepung, goreng hingga krispi.\n2) Ulek bawang putih, cabai, garam, dan gula.\n3) Geprek ayam di atas sambal.\n4) Sajikan dengan nasi hangat.\n\n🔗 Sumber: [https://cookpad\\.com/id/resep/4473023\\-ayam\\-geprek](https://cookpad.com/id/resep/4473023-ayam-geprek)', '2025-07-05 06:12:09'),
(564, NULL, 'in', 'Makanan Trending', '2025-07-05 06:14:37'),
(565, NULL, 'out', '🔥 *MAKANAN TRENDING BULAN INI* 🔥\n\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 06:14:38'),
(566, NULL, 'in', 'Rekomendasi Hari Ini', '2025-07-05 06:14:45'),
(567, NULL, 'out', 'Lagi mau masak yang gimana?', '2025-07-05 06:14:45'),
(568, NULL, 'in', '🔥 Pedas', '2025-07-05 06:14:47'),
(569, NULL, 'in', '🥕 Pake bahan yang ada', '2025-07-05 06:18:50'),
(570, NULL, 'out', '😊 Wah, sepertinya aku belum paham maksud kamu. \n➡️ Yuk, pilih menu di bawah ini ya:', '2025-07-05 06:18:50'),
(571, NULL, 'in', 'Makanan Trending', '2025-07-05 06:18:52'),
(572, NULL, 'out', '🔥 *MAKANAN TRENDING BULAN INI* 🔥\n\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 06:18:52'),
(573, NULL, 'in', 'Makanan Trending', '2025-07-05 06:18:55'),
(574, NULL, 'out', '🔥 *MAKANAN TRENDING BULAN INI* 🔥\n\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 06:18:55'),
(575, NULL, 'in', 'Rekomendasi Hari Ini', '2025-07-05 06:18:56'),
(576, NULL, 'out', 'Lagi mau masak yang gimana?', '2025-07-05 06:18:57'),
(577, NULL, 'in', '🥗 Sehat', '2025-07-05 06:18:59'),
(578, NULL, 'in', '🔥 Pedas', '2025-07-05 06:22:18'),
(579, NULL, 'out', '😊 Wah, sepertinya aku belum paham maksud kamu. \n➡️ Yuk, pilih menu di bawah ini ya:', '2025-07-05 06:22:18'),
(580, NULL, 'in', 'Makanan Trending', '2025-07-05 06:22:20'),
(581, NULL, 'out', '🔥 *MAKANAN TRENDING BULAN INI* 🔥\n\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 06:22:20'),
(582, NULL, 'in', 'Rekomendasi Hari Ini', '2025-07-05 06:22:23'),
(583, NULL, 'out', 'Lagi mau masak yang gimana?', '2025-07-05 06:22:23'),
(584, NULL, 'in', '🥗 Sehat', '2025-07-05 06:22:25'),
(585, NULL, 'in', '🔥 Pedas', '2025-07-05 06:30:27'),
(586, NULL, 'out', '😊 Wah, sepertinya aku belum paham maksud kamu. \n➡️ Yuk, pilih menu di bawah ini ya:', '2025-07-05 06:30:28'),
(587, NULL, 'in', 'Makanan Trending', '2025-07-05 06:30:29'),
(588, NULL, 'out', '🔥 *MAKANAN TRENDING BULAN INI* 🔥\n\n1. Tempe sandal jepit\n2. Cheesecake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 06:30:29'),
(589, NULL, 'in', 'Makanan Trending', '2025-07-05 06:30:33'),
(590, NULL, 'out', '🔥 *MAKANAN TRENDING BULAN INI* 🔥\n\n1. Tempe sandal jepit\n2. Cheesecake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 06:30:33'),
(591, NULL, 'in', '1', '2025-07-05 06:30:37'),
(592, NULL, 'out', '🍽️ *Tempe sandal jepit*\n\n📂 Kategori: Camilan\n📝 Deskripsi: Tempe goreng viral berbentuk sandal jepit dengan sosis sebagai tali. Renyah, gurih, dan unik.\n\n📋 Bahan-bahan:\nTempe, sosis, tepung terigu, tepung bumbu, garam, air, minyak goreng\n\n📖 Cara membuat:\n1) Potong tempe menyerupai sandal, beri lubang tali.\n2) Pasang sosis sebagai tali sandal.\n3) Celupkan ke adonan tepung.\n4) Goreng hingga renyah.\n5) Sajikan hangat.\n\n🔗 Sumber: [https://www\\.liputan6\\.com/lifestyle/read/6055924/resep\\-tempe\\-sandal\\-jepit\\-bikin\\-gorengan\\-viral\\-di\\-rumah](https://www.liputan6.com/lifestyle/read/6055924/resep-tempe-sandal-jepit-bikin-gorengan-viral-di-rumah)', '2025-07-05 06:30:37'),
(593, NULL, 'in', 'Makanan Trending', '2025-07-05 06:30:39'),
(594, NULL, 'out', '🔥 *MAKANAN TRENDING BULAN INI* 🔥\n\n1. Tempe sandal jepit\n2. Cheesecake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 06:30:40'),
(595, NULL, 'in', '4', '2025-07-05 06:30:44'),
(596, NULL, 'out', '🍽️ *Es pisang ijo*\n\n📂 Kategori: Minuman\n📝 Deskripsi: Minuman segar dari pisang yang dibalut adonan hijau dan disajikan dengan sirup manis.\n\n📋 Bahan-bahan:\n100 gr tepung beras, 100 gr tepung terigu, 500 ml santan, 50 gr gula pasir, 1/2 sdt garam, pasta pandan secukupnya\n\n📖 Cara membuat:\n1) Balut pisang dengan adonan tepung beras hijau.\n2) Kukus hingga matang.\n3) Sajikan dengan sirup gula merah dan es batu.\n\n🔗 Sumber: [https://cookpad\\.com/id/resep/24706698?ref\\=search&search\\_term\\=es\\+pisang\\+ijo](https://cookpad.com/id/resep/24706698?ref=search&search_term=es+pisang+ijo)', '2025-07-05 06:30:45'),
(597, NULL, 'in', 'Cari Makanan', '2025-07-05 06:30:47'),
(598, NULL, 'out', 'Silahkan ketik nama makanan yang ingin Anda cari', '2025-07-05 06:30:47'),
(599, NULL, 'in', 'Cari Makanan', '2025-07-05 06:30:48'),
(600, NULL, 'out', 'Silahkan ketik nama makanan yang ingin Anda cari', '2025-07-05 06:30:49'),
(601, NULL, 'in', 'Ayam', '2025-07-05 06:30:52'),
(602, NULL, 'in', 'Cari Makanan', '2025-07-05 06:31:04'),
(603, NULL, 'out', 'Silahkan ketik nama makanan yang ingin Anda cari', '2025-07-05 06:31:04'),
(604, NULL, 'in', 'Ayam geprek', '2025-07-05 06:31:07'),
(605, NULL, 'in', 'Cari Makanan', '2025-07-05 06:31:10'),
(606, NULL, 'out', 'Silahkan ketik nama makanan yang ingin Anda cari', '2025-07-05 06:31:11'),
(607, NULL, 'in', 'Gado-gado', '2025-07-05 06:31:17'),
(608, NULL, 'in', 'Rekomendasi Hari Ini', '2025-07-05 06:31:21'),
(609, NULL, 'out', 'Lagi mau masak yang gimana?', '2025-07-05 06:31:21'),
(610, NULL, 'in', '🥗 Sehat', '2025-07-05 06:31:23'),
(611, NULL, 'in', '🔥 Pedas', '2025-07-05 06:31:24'),
(612, NULL, 'out', '😊 Wah, sepertinya aku belum paham maksud kamu. \n➡️ Yuk, pilih menu di bawah ini ya:', '2025-07-05 06:31:25'),
(613, NULL, 'in', 'Tips Masak', '2025-07-05 06:32:30'),
(614, NULL, 'out', '👩‍🍳 *Tips Masak Hari Ini!* 🧂\n\n🔸 _🥫 Simpan sisa saus kalengan di wadah kaca agar tidak berkarat dan tahan lama._\n\nCoba praktikkan hari ini, ya! 😋\nIngin tips lain? Ketik *tips* atau klik tombol \"Tips Masak\".', '2025-07-05 06:32:31'),
(615, NULL, 'in', 'Rekomendasi Hari Ini', '2025-07-05 06:33:18'),
(616, NULL, 'out', 'Lagi mau masak yang gimana?', '2025-07-05 06:33:18'),
(617, NULL, 'in', '🥗 Sehat', '2025-07-05 06:33:20'),
(618, NULL, 'in', '🍣 manis', '2025-07-05 06:33:23'),
(619, NULL, 'out', '😊 Wah, sepertinya aku belum paham maksud kamu. \n➡️ Yuk, pilih menu di bawah ini ya:', '2025-07-05 06:33:24'),
(620, NULL, 'in', 'Rekomendasi Hari Ini', '2025-07-05 06:33:25'),
(621, NULL, 'out', 'Lagi mau masak yang gimana?', '2025-07-05 06:33:25'),
(622, NULL, 'in', '🍣 manis', '2025-07-05 06:33:26'),
(623, NULL, 'in', '🥗 Sehat', '2025-07-05 06:33:32'),
(624, NULL, 'out', '😊 Wah, sepertinya aku belum paham maksud kamu. \n➡️ Yuk, pilih menu di bawah ini ya:', '2025-07-05 06:33:32'),
(625, NULL, 'in', 'Makanan Trending', '2025-07-05 06:33:33'),
(626, NULL, 'out', '🔥 *MAKANAN TRENDING BULAN INI* 🔥\n\n1. Tempe sandal jepit\n2. Cheesecake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 06:33:34'),
(627, NULL, 'in', 'Rekomendasi Hari Ini', '2025-07-05 06:33:35'),
(628, NULL, 'out', 'Lagi mau masak yang gimana?', '2025-07-05 06:33:36'),
(629, NULL, 'in', '🍣 manis', '2025-07-05 06:33:38'),
(630, NULL, 'in', '🥗 Sehat', '2025-07-05 06:34:54'),
(631, NULL, 'out', '😊 Wah, sepertinya aku belum paham maksud kamu. \n➡️ Yuk, pilih menu di bawah ini ya:', '2025-07-05 06:34:55'),
(632, NULL, 'in', 'Rekomendasi Hari Ini', '2025-07-05 06:34:56'),
(633, NULL, 'out', 'Lagi mau masak yang gimana?', '2025-07-05 06:34:57'),
(634, NULL, 'in', '🔥 Pedas', '2025-07-05 06:34:58'),
(635, NULL, 'in', '🥗 Sehat', '2025-07-05 06:35:00'),
(636, NULL, 'out', '😊 Wah, sepertinya aku belum paham maksud kamu. \n➡️ Yuk, pilih menu di bawah ini ya:', '2025-07-05 06:35:00'),
(637, NULL, 'in', 'Cari Makanan', '2025-07-05 06:35:02'),
(638, NULL, 'out', 'Silahkan ketik nama makanan yang ingin Anda cari', '2025-07-05 06:35:03'),
(639, NULL, 'in', 'Soto', '2025-07-05 06:35:11'),
(640, NULL, 'in', 'Makanan Trending', '2025-07-05 06:36:44'),
(641, NULL, 'out', '🔥 *MAKANAN TRENDING BULAN INI* 🔥\n\n1. Tempe sandal jepit\n2. Cheesecake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 06:36:44'),
(642, NULL, 'in', '7', '2025-07-05 06:36:49'),
(643, NULL, 'out', '🍽️ *Rendang sapi melted*\n\n📂 Kategori: Daging\n📝 Deskripsi: Rendang khas Padang dengan tambahan keju leleh yang menggoda.\n\n📋 Bahan-bahan:\nDaging sapi, santan, bumbu rendang (serai, lengkuas, cabai, bawang), keju leleh\n\n📖 Cara membuat:\n1) Masak rendang hingga empuk dan bumbu meresap.\n2) Tambahkan keju leleh menjelang penyajian.\n3) Aduk sebentar dan sajikan hangat.\n\n🔗 Sumber: [https://cookpad\\.com/id/resep/15993390\\-rendang\\-sapi\\-lumer\\-leleh\\-keju](https://cookpad.com/id/resep/15993390-rendang-sapi-lumer-leleh-keju)', '2025-07-05 06:36:49'),
(644, NULL, 'in', 'Rekomendasi Hari Ini', '2025-07-05 06:36:55'),
(645, NULL, 'out', 'Lagi mau masak yang gimana?', '2025-07-05 06:36:56'),
(646, NULL, 'in', '🔥 Pedas', '2025-07-05 06:36:57'),
(647, NULL, 'in', '🥗 Sehat', '2025-07-05 06:37:00'),
(648, NULL, 'out', '😊 Wah, sepertinya aku belum paham maksud kamu. \n➡️ Yuk, pilih menu di bawah ini ya:', '2025-07-05 06:37:01'),
(649, NULL, 'in', 'Tips Masak', '2025-07-05 06:37:02'),
(650, NULL, 'out', '👩‍🍳 *Tips Masak Hari Ini!* 🧂\n\n🔸 _🍤 Cuci udang dengan air jeruk nipis untuk mengurangi bau amis._\n\nCoba praktikkan hari ini, ya! 😋\nIngin tips lain? Ketik *tips* atau klik tombol \"Tips Masak\".', '2025-07-05 06:37:02'),
(651, NULL, 'in', 'Cari Makanan', '2025-07-05 06:37:04'),
(652, NULL, 'out', 'Silahkan ketik nama makanan yang ingin Anda cari', '2025-07-05 06:37:04'),
(653, NULL, 'in', 'Ayam geprek', '2025-07-05 06:37:12'),
(654, NULL, 'in', 'Rekomendasi Hari Ini', '2025-07-05 06:37:22'),
(655, NULL, 'out', 'Lagi mau masak yang gimana?', '2025-07-05 06:37:22'),
(656, NULL, 'in', '🔥 Pedas', '2025-07-05 06:37:23'),
(657, NULL, 'in', '🧀 Cheesy', '2025-07-05 06:38:27'),
(658, NULL, 'out', '😊 Wah, sepertinya aku belum paham maksud kamu. \n➡️ Yuk, pilih menu di bawah ini ya:', '2025-07-05 06:38:28'),
(659, NULL, 'in', 'Cari Makanan', '2025-07-05 06:38:31'),
(660, NULL, 'out', 'Silahkan ketik nama makanan yang ingin Anda cari', '2025-07-05 06:38:31'),
(661, NULL, 'in', 'Soto', '2025-07-05 06:38:33'),
(662, NULL, 'in', 'Makanan Trending', '2025-07-05 06:41:10'),
(663, NULL, 'out', '🔥 *MAKANAN TRENDING BULAN INI* 🔥\n\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 06:41:11'),
(664, NULL, 'in', 'Rekomendasi Hari Ini', '2025-07-05 06:41:14'),
(665, NULL, 'out', 'Lagi mau masak yang gimana?', '2025-07-05 06:41:15'),
(666, NULL, 'in', '🔥 Pedas', '2025-07-05 06:41:16'),
(667, NULL, 'in', '🔥 Pedas', '2025-07-05 06:41:21'),
(668, NULL, 'out', '😊 Wah, sepertinya aku belum paham maksud kamu. \n➡️ Yuk, pilih menu di bawah ini ya:', '2025-07-05 06:41:21'),
(669, NULL, 'in', 'Tips Masak', '2025-07-05 06:41:22'),
(670, NULL, 'out', '👩‍🍳 *Tips Masak Hari Ini!* 🧂\n\n🔸 _🍠 Kukus singkong sebelum digoreng agar lebih lembut di dalam._\n\nCoba praktikkan hari ini, ya! 😋\nIngin tips lain? Ketik *tips* atau klik tombol \"Tips Masak\".', '2025-07-05 06:41:22'),
(671, NULL, 'in', 'Cari Makanan', '2025-07-05 06:41:23'),
(672, NULL, 'out', 'Silahkan ketik nama makanan yang ingin Anda cari', '2025-07-05 06:41:24'),
(673, NULL, 'in', 'Ayam geprek', '2025-07-05 06:41:27'),
(674, NULL, 'in', 'Makanan Trending', '2025-07-05 06:43:40'),
(675, NULL, 'out', '🔥 *MAKANAN TRENDING BULAN INI* 🔥\n\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 06:43:40'),
(676, NULL, 'in', 'Rekomendasi Hari Ini', '2025-07-05 06:43:41'),
(677, NULL, 'out', 'Lagi mau masak yang gimana?', '2025-07-05 06:43:42'),
(678, NULL, 'in', '🔥 Pedas', '2025-07-05 06:43:43'),
(679, NULL, 'in', '🥕 Pake bahan yang ada', '2025-07-05 06:43:47'),
(680, NULL, 'out', '😊 Wah, sepertinya aku belum paham maksud kamu. \n➡️ Yuk, pilih menu di bawah ini ya:', '2025-07-05 06:43:47'),
(681, NULL, 'in', 'Tips Masak', '2025-07-05 06:43:48'),
(682, NULL, 'out', '👩‍🍳 *Tips Masak Hari Ini!* 🧂\n\n🔸 _🥬 Masukkan sayur hijau saat air mendidih, bukan dari awal, agar tetap segar._\n\nCoba praktikkan hari ini, ya! 😋\nIngin tips lain? Ketik *tips* atau klik tombol \"Tips Masak\".', '2025-07-05 06:43:48'),
(683, NULL, 'in', 'Cari Makanan', '2025-07-05 06:43:50'),
(684, NULL, 'out', 'Silahkan ketik nama makanan yang ingin Anda cari', '2025-07-05 06:43:50'),
(685, NULL, 'in', 'Ayam geprek', '2025-07-05 06:43:54'),
(686, NULL, 'in', 'Makanan Trending', '2025-07-05 06:45:40'),
(687, NULL, 'out', '🔥 *MAKANAN TRENDING BULAN INI* 🔥\n\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 06:45:41'),
(688, NULL, 'in', 'Rekomendasi Hari Ini', '2025-07-05 06:45:43'),
(689, NULL, 'out', 'Lagi mau masak yang gimana?', '2025-07-05 06:45:43'),
(690, NULL, 'in', '🥗 Sehat', '2025-07-05 06:45:44'),
(691, NULL, 'in', '🧀 Cheesy', '2025-07-05 06:45:45'),
(692, NULL, 'out', '😊 Wah, sepertinya aku belum paham maksud kamu. \n➡️ Yuk, pilih menu di bawah ini ya:', '2025-07-05 06:45:46'),
(693, NULL, 'in', 'Cari Makanan', '2025-07-05 06:45:48'),
(694, NULL, 'out', 'Silahkan ketik nama makanan yang ingin Anda cari', '2025-07-05 06:45:48'),
(695, NULL, 'in', 'Ayam geprek', '2025-07-05 06:45:51'),
(696, NULL, 'in', 'Makanan Trending', '2025-07-05 06:48:51'),
(697, NULL, 'out', '🔥 *MAKANAN TRENDING BULAN INI* 🔥\n\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 06:48:52'),
(698, NULL, 'in', 'Rekomendasi Hari Ini', '2025-07-05 06:48:53'),
(699, NULL, 'out', 'Lagi mau masak yang gimana?', '2025-07-05 06:48:53'),
(700, NULL, 'in', '🥗 Sehat', '2025-07-05 06:48:55'),
(701, NULL, 'in', '🥕 Pake bahan yang ada', '2025-07-05 06:48:57'),
(702, NULL, 'out', '😊 Wah, sepertinya aku belum paham maksud kamu. \n➡️ Yuk, pilih menu di bawah ini ya:', '2025-07-05 06:48:57'),
(703, NULL, 'in', 'Tips Masak', '2025-07-05 06:48:58'),
(704, NULL, 'out', '👩‍🍳 *Tips Masak Hari Ini!* 🧂\n\n🔸 _🥣 Gunakan saringan halus untuk mendapatkan kaldu bening._\n\nCoba praktikkan hari ini, ya! 😋\nIngin tips lain? Ketik *tips* atau klik tombol \"Tips Masak\".', '2025-07-05 06:48:59'),
(705, NULL, 'in', 'Rekomendasi Hari Ini', '2025-07-05 06:53:26'),
(706, NULL, 'out', 'Lagi mau masak yang gimana?', '2025-07-05 06:53:26'),
(707, NULL, 'in', '🔥 Pedas', '2025-07-05 06:53:27'),
(708, NULL, 'in', '🥕 Pake bahan yang ada', '2025-07-05 06:53:29'),
(709, NULL, 'out', '😊 Wah, sepertinya aku belum paham maksud kamu. \n➡️ Yuk, pilih menu di bawah ini ya:', '2025-07-05 06:53:29'),
(710, NULL, 'in', 'Makanan Trending', '2025-07-05 06:53:30'),
(711, NULL, 'out', '🔥 *MAKANAN TRENDING BULAN INI* 🔥\n\n1. Tempe sandal jepit\n2. Cheesecake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 06:53:31'),
(712, NULL, 'in', '2', '2025-07-05 06:53:34'),
(713, NULL, 'out', '🍽️ *Cheesecake*\n\n📂 Kategori: Kue\n📝 Deskripsi: Kue keju klasik yang lembut dan creamy, cocok untuk dessert.\n\n📋 Bahan-bahan:\n400 g cream cheese, 130 g gula, 2 sdm maizena, 2 butir telur, 1 kuning telur, 100 ml krim kental, biskuit dan mentega untuk dasar\n\n📖 Cara membuat:\n1) Hancurkan biskuit, campur dengan mentega, tekan di loyang.\n2) Campur cream cheese, gula, maizena, telur, dan krim.\n3) Tuang di atas dasar biskuit.\n4) Panggang hingga matang dan berwarna keemasan.\n5) Dinginkan sebelum disajikan.\n\n🔗 Sumber: [https://www\\.onceuponachef\\.com/recipes/classic\\-cheesecake\\.html](https://www.onceuponachef.com/recipes/classic-cheesecake.html)', '2025-07-05 06:53:35'),
(714, NULL, 'in', 'Tips Masak', '2025-07-05 06:53:37'),
(715, NULL, 'out', '👩‍🍳 *Tips Masak Hari Ini!* 🧂\n\n🔸 _🥘 Tambahkan sedikit terasi saat membuat sambal agar lebih gurih._\n\nCoba praktikkan hari ini, ya! 😋\nIngin tips lain? Ketik *tips* atau klik tombol \"Tips Masak\".', '2025-07-05 06:53:37'),
(716, NULL, 'in', 'Cari Makanan', '2025-07-05 06:53:39'),
(717, NULL, 'out', 'Silahkan ketik nama makanan yang ingin Anda cari', '2025-07-05 06:53:39'),
(718, NULL, 'in', 'Ayam geprek', '2025-07-05 06:53:44'),
(719, NULL, 'in', '/daftar', '2025-07-05 06:54:26'),
(720, NULL, 'in', '/start', '2025-07-05 06:54:41'),
(721, NULL, 'out', 'Halo @Fiacahyasnack! Selamat datang di *Bot Makanan Trending*! 🍽️', '2025-07-05 06:54:41'),
(722, NULL, 'out', 'Silahkan klik menu di bawah ini untuk memilih opsi yang tersedia.', '2025-07-05 06:54:41'),
(723, NULL, 'in', 'Makanan Trending', '2025-07-05 06:54:43'),
(724, NULL, 'out', '🔥 *MAKANAN TRENDING BULAN INI* 🔥\n\n1. Tempe sandal jepit\n2. Cheesecake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 06:54:43'),
(725, NULL, 'in', '1', '2025-07-05 06:54:45'),
(726, NULL, 'out', '🍽️ *Tempe sandal jepit*\n\n📂 Kategori: Camilan\n📝 Deskripsi: Tempe goreng viral berbentuk sandal jepit dengan sosis sebagai tali. Renyah, gurih, dan unik.\n\n📋 Bahan-bahan:\nTempe, sosis, tepung terigu, tepung bumbu, garam, air, minyak goreng\n\n📖 Cara membuat:\n1) Potong tempe menyerupai sandal, beri lubang tali.\n2) Pasang sosis sebagai tali sandal.\n3) Celupkan ke adonan tepung.\n4) Goreng hingga renyah.\n5) Sajikan hangat.\n\n🔗 Sumber: [https://www\\.liputan6\\.com/lifestyle/read/6055924/resep\\-tempe\\-sandal\\-jepit\\-bikin\\-gorengan\\-viral\\-di\\-rumah](https://www.liputan6.com/lifestyle/read/6055924/resep-tempe-sandal-jepit-bikin-gorengan-viral-di-rumah)', '2025-07-05 06:54:46'),
(727, NULL, 'in', 'Rekomendasi Hari Ini', '2025-07-05 06:54:47'),
(728, NULL, 'out', 'Lagi mau masak yang gimana?', '2025-07-05 06:54:47'),
(729, NULL, 'in', '🔥 Pedas', '2025-07-05 06:54:49'),
(730, NULL, 'in', '🥗 Sehat', '2025-07-05 06:54:52'),
(731, NULL, 'out', '😊 Wah, sepertinya aku belum paham maksud kamu. \n➡️ Yuk, pilih menu di bawah ini ya:', '2025-07-05 06:54:52'),
(732, NULL, 'in', 'Cari Makanan', '2025-07-05 06:54:56'),
(733, NULL, 'out', 'Silahkan ketik nama makanan yang ingin Anda cari', '2025-07-05 06:54:56'),
(734, NULL, 'in', 'Ayam geprek', '2025-07-05 06:55:05'),
(735, NULL, 'in', 'Rekomendasi Hari Ini', '2025-07-05 06:57:40'),
(736, NULL, 'out', 'Lagi mau masak yang gimana?', '2025-07-05 06:57:41'),
(737, NULL, 'in', '🔥 Pedas', '2025-07-05 06:57:42'),
(738, NULL, 'out', '🌶️ Resep pedas untukmu:\n\n1. Ayam Geprek Ganas (estimasi waktu)\n2. Ayam Geprek Sambel Judes (estimasi waktu)\n3. Ayam Rica-Rica Pedas (estimasi waktu)\nKetik nomor untuk melihat detail resep!', '2025-07-05 06:57:42'),
(739, NULL, 'in', '1', '2025-07-05 06:57:45'),
(740, NULL, 'out', '🍽️ *Ayam Geprek Ganas*\n\n📂 Kategori: Ayam\n📝 Deskripsi: Ayam geprek dengan level kepedasan yang ganas, cocok untuk pecinta pedas.\n\n📋 Bahan-bahan:\n1 kg ayam potong\n200 gr tepung bumbu siap pakai\n25 buah cabe rawit\n10 siung bawang putih\n2 sdt garam\n1 sdt gula\nMinyak untuk menggoreng\n\n📖 Cara membuat:\n1) Bersihkan ayam, lumuri garam\n2) Balur dengan tepung bumbu, goreng hingga krispi\n3) Ulek cabe rawit, bawang putih, garam, gula hingga halus\n4) Geprek ayam goreng di atas sambal\n5) Aduk rata hingga bumbu meresap\n\n🔗 Sumber: [https://cookpad\\.com/id/resep/4026468](https://cookpad.com/id/resep/4026468)', '2025-07-05 06:57:46'),
(741, NULL, 'in', 'Makanan Trending', '2025-07-05 06:57:47'),
(742, NULL, 'out', '🔥 *MAKANAN TRENDING BULAN INI* 🔥\n\n1. Tempe sandal jepit\n2. Cheesecake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 06:57:47'),
(743, NULL, 'in', '1', '2025-07-05 06:57:51'),
(744, NULL, 'out', '🍽️ *Tempe sandal jepit*\n\n📂 Kategori: Camilan\n📝 Deskripsi: Tempe goreng viral berbentuk sandal jepit dengan sosis sebagai tali. Renyah, gurih, dan unik.\n\n📋 Bahan-bahan:\nTempe, sosis, tepung terigu, tepung bumbu, garam, air, minyak goreng\n\n📖 Cara membuat:\n1) Potong tempe menyerupai sandal, beri lubang tali.\n2) Pasang sosis sebagai tali sandal.\n3) Celupkan ke adonan tepung.\n4) Goreng hingga renyah.\n5) Sajikan hangat.\n\n🔗 Sumber: [https://www\\.liputan6\\.com/lifestyle/read/6055924/resep\\-tempe\\-sandal\\-jepit\\-bikin\\-gorengan\\-viral\\-di\\-rumah](https://www.liputan6.com/lifestyle/read/6055924/resep-tempe-sandal-jepit-bikin-gorengan-viral-di-rumah)', '2025-07-05 06:57:52'),
(745, NULL, 'in', 'Cari Makanan', '2025-07-05 06:57:53'),
(746, NULL, 'out', 'Silahkan ketik nama makanan yang ingin Anda cari', '2025-07-05 06:57:53'),
(747, NULL, 'in', 'Ayam geprek', '2025-07-05 06:57:57'),
(748, NULL, 'in', 'Rekomendasi Hari Ini', '2025-07-05 06:59:04'),
(749, NULL, 'out', 'Lagi mau masak yang gimana?', '2025-07-05 06:59:04'),
(750, NULL, 'in', '🔥 Pedas', '2025-07-05 06:59:05'),
(751, NULL, 'out', '🌶️ Resep pedas untukmu:\n\n1. Ayam Geprek Ganas (estimasi waktu)\n2. Ayam Geprek Sambel Judes (estimasi waktu)\n3. Ayam Rica-Rica Pedas (estimasi waktu)\nKetik nomor untuk melihat detail resep!', '2025-07-05 06:59:06'),
(752, NULL, 'in', '1', '2025-07-05 06:59:09'),
(753, NULL, 'out', '🍽️ *Ayam Geprek Ganas*\n\n📂 Kategori: Ayam\n📝 Deskripsi: Ayam geprek dengan level kepedasan yang ganas, cocok untuk pecinta pedas.\n\n📋 Bahan-bahan:\n1 kg ayam potong\n200 gr tepung bumbu siap pakai\n25 buah cabe rawit\n10 siung bawang putih\n2 sdt garam\n1 sdt gula\nMinyak untuk menggoreng\n\n📖 Cara membuat:\n1) Bersihkan ayam, lumuri garam\n2) Balur dengan tepung bumbu, goreng hingga krispi\n3) Ulek cabe rawit, bawang putih, garam, gula hingga halus\n4) Geprek ayam goreng di atas sambal\n5) Aduk rata hingga bumbu meresap\n\n🔗 Sumber: [https://cookpad\\.com/id/resep/4026468](https://cookpad.com/id/resep/4026468)', '2025-07-05 06:59:09'),
(754, NULL, 'in', 'Makanan Trending', '2025-07-05 06:59:10'),
(755, NULL, 'out', '🔥 *MAKANAN TRENDING BULAN INI* 🔥\n\n1. Tempe sandal jepit\n2. Cheesecake\n3. Bolu ketan hitam keju lumer\n4. Es pisang ijo\n5. Bakso bomber\n6. Sushi gulung martabak\n7. Rendang sapi melted\n\nKetik nomor untuk melihat detail resep!', '2025-07-05 06:59:11'),
(756, NULL, 'in', '3', '2025-07-05 06:59:13'),
(757, NULL, 'out', '🍽️ *Bolu ketan hitam keju lumer*\n\n📂 Kategori: Kue\n📝 Deskripsi: Bolu ketan hitam lembut dengan isian keju lumer di tengah, manis dan legit.\n\n📋 Bahan-bahan:\n4 butir telur, 135 g gula pasir, 175 g tepung ketan hitam, 100 ml minyak, 65 ml santan, keju parut, SKM\n\n📖 Cara membuat:\n1) Kocok telur dan gula hingga kental.\n2) Masukkan tepung ketan, minyak, dan santan.\n3) Tuang sebagian adonan, beri isian keju + SKM.\n4) Tutup sisa adonan, panggang hingga matang.\n5) Sajikan hangat.\n\n🔗 Sumber: [https://cookpad\\.com/id/resep/24748044\\-bolu\\-ketan\\-hitam\\-keju\\-lumer](https://cookpad.com/id/resep/24748044-bolu-ketan-hitam-keju-lumer)', '2025-07-05 06:59:14'),
(758, NULL, 'in', 'Cari Makanan', '2025-07-05 06:59:15');
INSERT INTO `messages` (`id`, `user_id`, `direction`, `message`, `created_at`) VALUES
(759, NULL, 'out', 'Silahkan ketik nama makanan yang ingin Anda cari', '2025-07-05 06:59:15'),
(760, NULL, 'in', 'Ayam geprek', '2025-07-05 06:59:19'),
(761, NULL, 'in', 'Tips Masak', '2025-07-05 06:59:22'),
(762, NULL, 'out', '👩‍🍳 *Tips Masak Hari Ini!* 🧂\n\n🔸 _🧊 Gunakan air es saat mengadon tepung goreng untuk hasil renyah tahan lama._\n\nCoba praktikkan hari ini, ya! 😋\nIngin tips lain? Ketik *tips* atau klik tombol \"Tips Masak\".', '2025-07-05 06:59:22'),
(763, 29, 'in', '/daftar', '2025-07-05 07:01:24');

-- --------------------------------------------------------

--
-- Struktur dari tabel `topik_trending`
--

CREATE TABLE `topik_trending` (
  `id` int(11) NOT NULL,
  `nama_makanan` varchar(255) DEFAULT NULL,
  `deskripsi` text DEFAULT NULL,
  `sumber` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `telegram_id` bigint(20) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'unv',
  `phone` varchar(20) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `telegram_id`, `username`, `status`, `phone`, `created_at`) VALUES
(20, 5406512828, 'maulidacy', 'verified', '6285602432362', '2025-06-28 18:47:46'),
(29, 5071702325, 'Fiacahyasnack', 'pending', '6285702097315', '2025-07-05 14:01:22');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indeks untuk tabel `broadcasts`
--
ALTER TABLE `broadcasts`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `broadcast_targets`
--
ALTER TABLE `broadcast_targets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `broadcast_id` (`broadcast_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indeks untuk tabel `keywords`
--
ALTER TABLE `keywords`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indeks untuk tabel `topik_trending`
--
ALTER TABLE `topik_trending`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `telegram_id` (`telegram_id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `broadcasts`
--
ALTER TABLE `broadcasts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `broadcast_targets`
--
ALTER TABLE `broadcast_targets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `keywords`
--
ALTER TABLE `keywords`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=94;

--
-- AUTO_INCREMENT untuk tabel `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=764;

--
-- AUTO_INCREMENT untuk tabel `topik_trending`
--
ALTER TABLE `topik_trending`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `broadcast_targets`
--
ALTER TABLE `broadcast_targets`
  ADD CONSTRAINT `broadcast_targets_ibfk_1` FOREIGN KEY (`broadcast_id`) REFERENCES `broadcasts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `broadcast_targets_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
