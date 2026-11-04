USE toko_098;

-- Nonaktifkan sementara pemeriksaan Foreign Key untuk kelancaran insert data
SET FOREIGN_KEY_CHECKS = 0;

-- Kosongkan seluruh tabel secara aman
DELETE FROM loyalitas_poin;
DELETE FROM pembayaran;
DELETE FROM detail_pesanan;
DELETE FROM pesanan;
DELETE FROM varian_produk;
DELETE FROM produk;
DELETE FROM kategori;
DELETE FROM pelanggan;

-- Aktifkan kembali Foreign Key checks
SET FOREIGN_KEY_CHECKS = 1;

-- ============================================================
-- 1. DATA TABEL: pelanggan (5 Baris)
-- ============================================================
INSERT INTO pelanggan (id_pelanggan, nama_lengkap, email_pelanggan, kata_sandi_hash, nomor_hp, alamat_lengkap) VALUES
(1, 'Kevin Maulana Arditama', 'kevin.arditama@mhs.ac.id', '$2y$10$abcdef1234567890dummyhash1', '081234567890', 'Jl. Jenderal Sudirman No. 10, Metro, Lampung'),
(2, 'Siti Rahmawati', 'siti.rahma@gmail.com', '$2y$10$abcdef1234567890dummyhash2', '081345678901', 'Jl. Ahmad Yani No. 45, Bandar Lampung'),
(3, 'Ahmad Fauzi', 'ahmad.fauzi@yahoo.com', '$2y$10$abcdef1234567890dummyhash3', '081567890123', 'Jl. Raden Intan No. 12, Metro'),
(4, 'Dewi Lestari', 'dewi.lestari@gmail.com', '$2y$10$abcdef1234567890dummyhash4', '081890123456', 'Jl. Kartini No. 88, Pringsewu'),
(5, 'Budi Santoso', 'budi.santoso@outlook.com', '$2y$10$abcdef1234567890dummyhash5', '081901234567', 'Jl. Teuku Umar No. 22, Bandar Lampung');

-- ============================================================
-- 2. DATA TABEL: kategori (5 Baris)
-- ============================================================
INSERT INTO kategori (id_kategori, nama_kategori) VALUES
(1, 'Pakaian Pria'),
(2, 'Pakaian Wanita'),
(3, 'Aksesoris & Tas'),
(4, 'Sepatu & Sandal'),
(5, 'Elektronik & Gadget');

-- ============================================================
-- 3. DATA TABEL: produk (5 Baris)
-- ============================================================
INSERT INTO produk (id_produk, id_kategori, nama_produk, deskripsi_produk, harga_dasar) VALUES
(1, 1, 'Kaos Polos Cotton Combed 30s', 'Kaos katun nyaman adem sehari-hari', 75000.00),
(2, 1, 'Kemeja Flanel Casual', 'Kemeja flanel lengan panjang premium', 135000.00),
(3, 2, 'Gamis Modern Sifon', 'Gamis elegan bahan lembut tidak nerawang', 185000.00),
(4, 3, 'Tas Ransel Laptop Kanvas', 'Tas ransel tahan air dengan slot laptop 15 inch', 220000.00),
(5, 4, 'Sepatu Sneakers Sneakers Sport', 'Sepatu lari ringan dan empuk', 275000.00);

-- ============================================================
-- 4. DATA TABEL: varian_produk (6 Baris)
-- ============================================================
INSERT INTO varian_produk (id_varian, id_produk, ukuran_produk, warna_produk, stok_varian) VALUES
(1, 1, 'M', 'Hitam', 25),
(2, 1, 'L', 'Putih', 30),
(3, 2, 'L', 'Merah Kotak', 15),
(4, 3, 'All Size', 'Navy', 20),
(5, 4, 'Standard', 'Abu-abu', 12),
(6, 5, '41', 'Hitam Putih', 10);

-- ============================================================
-- 5. DATA TABEL: pesanan (10 Baris)
-- ============================================================
INSERT INTO pesanan (id_pesanan, id_pelanggan, tanggal_pesanan, total_harga, status_pesanan) VALUES
(1, 1, '2026-10-01 10:30:00', 150000.00, 'Selesai'),
(2, 2, '2026-10-01 14:15:00', 270000.00, 'Selesai'),
(3, 3, '2026-10-05 09:00:00', 185000.00, 'Dikirim'),
(4, 4, '2026-10-05 16:20:00', 220000.00, 'Selesai'),
(5, 5, '2026-10-10 11:45:00', 275000.00, 'Pending'),
(6, 1, '2026-10-10 13:00:00', 135000.00, 'Selesai'),
(7, 2, '2026-10-15 08:30:00', 370000.00, 'Selesai'),
(8, 3, '2026-10-15 12:10:00', 75000.00, 'Selesai'),
(9, 4, '2026-10-20 15:00:00', 220000.00, 'Dikirim'),
(10, 5, '2026-10-20 19:45:00', 275000.00, 'Selesai');

-- ============================================================
-- 6. DATA TABEL: detail_pesanan (10 Baris)
-- ============================================================
INSERT INTO detail_pesanan (id_detail, id_pesanan, id_varian, jumlah_beli, subtotal_harga) VALUES
(1, 1, 1, 2, 150000.00),
(2, 2, 3, 2, 270000.00),
(3, 3, 4, 2, 185000.00),
(4, 4, 5, 2, 220000.00),
(5, 5, 6, 2, 275000.00),
(6, 6, 3, 2, 135000.00),
(7, 7, 4, 2, 370000.00),
(8, 8, 1, 2, 75000.00),
(9, 9, 5, 2, 220000.00),
(10, 10, 6, 2, 275000.00);

-- ============================================================
-- 7. DATA TABEL: pembayaran (10 Baris)
-- ============================================================
INSERT INTO pembayaran (id_pembayaran, id_pesanan, metode_bayar, tanggal_bayar, nominal_bayar, status_pembayaran) VALUES
(1, 1, 'Transfer Bank', '2026-10-01 10:35:00', 150000.00, 'Lunas'),
(2, 2, 'E-Wallet (OVO)', '2026-10-01 14:20:00', 270000.00, 'Lunas'),
(3, 3, 'COD', '2026-10-05 09:05:00', 185000.00, 'Belum Lunas'),
(4, 4, 'Transfer Bank', '2026-10-05 16:25:00', 220000.00, 'Lunas'),
(5, 5, 'Virtual Account', '2026-10-10 11:50:00', 275000.00, 'Belum Lunas'),
(6, 6, 'E-Wallet (Dana)', '2026-10-10 13:05:00', 135000.00, 'Lunas'),
(7, 7, 'Transfer Bank', '2026-10-15 08:35:00', 370000.00, 'Lunas'),
(8, 8, 'E-Wallet (GoPay)', '2026-10-15 12:15:00', 75000.00, 'Lunas'),
(9, 9, 'Transfer Bank', '2026-10-20 15:05:00', 220000.00, 'Lunas'),
(10, 10, 'Virtual Account', '2026-10-20 19:50:00', 275000.00, 'Lunas');

-- ============================================================
-- 8. DATA TABEL: loyalitas_poin (6 Baris)
-- ============================================================
INSERT INTO loyalitas_poin (id_poin, id_pelanggan, id_pesanan, poin_masuk, poin_keluar, tanggal_riwayat) VALUES
(1, 1, 1, 15, 0, '2026-10-01 10:35:00'),
(2, 2, 2, 27, 0, '2026-10-01 14:20:00'),
(3, 3, 3, 18, 0, '2026-10-05 09:05:00'),
(4, 4, 4, 22, 0, '2026-10-05 16:25:00'),
(5, 1, 6, 13, 0, '2026-10-10 13:05:00'),
(6, 2, 7, 37, 0, '2026-10-15 08:35:00');USE toko_098;

-- Nonaktifkan sementara pemeriksaan Foreign Key untuk kelancaran insert data
SET FOREIGN_KEY_CHECKS = 0;

-- Kosongkan seluruh tabel secara aman
DELETE FROM loyalitas_poin;
DELETE FROM pembayaran;
DELETE FROM detail_pesanan;
DELETE FROM pesanan;
DELETE FROM varian_produk;
DELETE FROM produk;
DELETE FROM kategori;
DELETE FROM pelanggan;

-- Aktifkan kembali Foreign Key checks
SET FOREIGN_KEY_CHECKS = 1;

-- ============================================================
-- 1. DATA TABEL: pelanggan (5 Baris)
-- ============================================================
INSERT INTO pelanggan (id_pelanggan, nama_lengkap, email_pelanggan, kata_sandi_hash, nomor_hp, alamat_lengkap) VALUES
(1, 'Kevin Maulana Arditama', 'kevin.arditama@mhs.ac.id', '$2y$10$abcdef1234567890dummyhash1', '081234567890', 'Jl. Jenderal Sudirman No. 10, Metro, Lampung'),
(2, 'Siti Rahmawati', 'siti.rahma@gmail.com', '$2y$10$abcdef1234567890dummyhash2', '081345678901', 'Jl. Ahmad Yani No. 45, Bandar Lampung'),
(3, 'Ahmad Fauzi', 'ahmad.fauzi@yahoo.com', '$2y$10$abcdef1234567890dummyhash3', '081567890123', 'Jl. Raden Intan No. 12, Metro'),
(4, 'Dewi Lestari', 'dewi.lestari@gmail.com', '$2y$10$abcdef1234567890dummyhash4', '081890123456', 'Jl. Kartini No. 88, Pringsewu'),
(5, 'Budi Santoso', 'budi.santoso@outlook.com', '$2y$10$abcdef1234567890dummyhash5', '081901234567', 'Jl. Teuku Umar No. 22, Bandar Lampung');

-- ============================================================
-- 2. DATA TABEL: kategori (5 Baris)
-- ============================================================
INSERT INTO kategori (id_kategori, nama_kategori) VALUES
(1, 'Pakaian Pria'),
(2, 'Pakaian Wanita'),
(3, 'Aksesoris & Tas'),
(4, 'Sepatu & Sandal'),
(5, 'Elektronik & Gadget');

-- ============================================================
-- 3. DATA TABEL: produk (5 Baris)
-- ============================================================
INSERT INTO produk (id_produk, id_kategori, nama_produk, deskripsi_produk, harga_dasar) VALUES
(1, 1, 'Kaos Polos Cotton Combed 30s', 'Kaos katun nyaman adem sehari-hari', 75000.00),
(2, 1, 'Kemeja Flanel Casual', 'Kemeja flanel lengan panjang premium', 135000.00),
(3, 2, 'Gamis Modern Sifon', 'Gamis elegan bahan lembut tidak nerawang', 185000.00),
(4, 3, 'Tas Ransel Laptop Kanvas', 'Tas ransel tahan air dengan slot laptop 15 inch', 220000.00),
(5, 4, 'Sepatu Sneakers Sneakers Sport', 'Sepatu lari ringan dan empuk', 275000.00);

-- ============================================================
-- 4. DATA TABEL: varian_produk (6 Baris)
-- ============================================================
INSERT INTO varian_produk (id_varian, id_produk, ukuran_produk, warna_produk, stok_varian) VALUES
(1, 1, 'M', 'Hitam', 25),
(2, 1, 'L', 'Putih', 30),
(3, 2, 'L', 'Merah Kotak', 15),
(4, 3, 'All Size', 'Navy', 20),
(5, 4, 'Standard', 'Abu-abu', 12),
(6, 5, '41', 'Hitam Putih', 10);

-- ============================================================
-- 5. DATA TABEL: pesanan (10 Baris)
-- ============================================================
INSERT INTO pesanan (id_pesanan, id_pelanggan, tanggal_pesanan, total_harga, status_pesanan) VALUES
(1, 1, '2026-10-01 10:30:00', 150000.00, 'Selesai'),
(2, 2, '2026-10-01 14:15:00', 270000.00, 'Selesai'),
(3, 3, '2026-10-05 09:00:00', 185000.00, 'Dikirim'),
(4, 4, '2026-10-05 16:20:00', 220000.00, 'Selesai'),
(5, 5, '2026-10-10 11:45:00', 275000.00, 'Pending'),
(6, 1, '2026-10-10 13:00:00', 135000.00, 'Selesai'),
(7, 2, '2026-10-15 08:30:00', 370000.00, 'Selesai'),
(8, 3, '2026-10-15 12:10:00', 75000.00, 'Selesai'),
(9, 4, '2026-10-20 15:00:00', 220000.00, 'Dikirim'),
(10, 5, '2026-10-20 19:45:00', 275000.00, 'Selesai');

-- ============================================================
-- 6. DATA TABEL: detail_pesanan (10 Baris)
-- ============================================================
INSERT INTO detail_pesanan (id_detail, id_pesanan, id_varian, jumlah_beli, subtotal_harga) VALUES
(1, 1, 1, 2, 150000.00),
(2, 2, 3, 2, 270000.00),
(3, 3, 4, 2, 185000.00),
(4, 4, 5, 2, 220000.00),
(5, 5, 6, 2, 275000.00),
(6, 6, 3, 2, 135000.00),
(7, 7, 4, 2, 370000.00),
(8, 8, 1, 2, 75000.00),
(9, 9, 5, 2, 220000.00),
(10, 10, 6, 2, 275000.00);

-- ============================================================
-- 7. DATA TABEL: pembayaran (10 Baris)
-- ============================================================
INSERT INTO pembayaran (id_pembayaran, id_pesanan, metode_bayar, tanggal_bayar, nominal_bayar, status_pembayaran) VALUES
(1, 1, 'Transfer Bank', '2026-10-01 10:35:00', 150000.00, 'Lunas'),
(2, 2, 'E-Wallet (OVO)', '2026-10-01 14:20:00', 270000.00, 'Lunas'),
(3, 3, 'COD', '2026-10-05 09:05:00', 185000.00, 'Belum Lunas'),
(4, 4, 'Transfer Bank', '2026-10-05 16:25:00', 220000.00, 'Lunas'),
(5, 5, 'Virtual Account', '2026-10-10 11:50:00', 275000.00, 'Belum Lunas'),
(6, 6, 'E-Wallet (Dana)', '2026-10-10 13:05:00', 135000.00, 'Lunas'),
(7, 7, 'Transfer Bank', '2026-10-15 08:35:00', 370000.00, 'Lunas'),
(8, 8, 'E-Wallet (GoPay)', '2026-10-15 12:15:00', 75000.00, 'Lunas'),
(9, 9, 'Transfer Bank', '2026-10-20 15:05:00', 220000.00, 'Lunas'),
(10, 10, 'Virtual Account', '2026-10-20 19:50:00', 275000.00, 'Lunas');

-- ============================================================
-- 8. DATA TABEL: loyalitas_poin (6 Baris)
-- ============================================================
INSERT INTO loyalitas_poin (id_poin, id_pelanggan, id_pesanan, poin_masuk, poin_keluar, tanggal_riwayat) VALUES
(1, 1, 1, 15, 0, '2026-10-01 10:35:00'),
(2, 2, 2, 27, 0, '2026-10-01 14:20:00'),
(3, 3, 3, 18, 0, '2026-10-05 09:05:00'),
(4, 4, 4, 22, 0, '2026-10-05 16:25:00'),
(5, 1, 6, 13, 0, '2026-10-10 13:05:00'),
(6, 2, 7, 37, 0, '2026-10-15 08:35:00');

