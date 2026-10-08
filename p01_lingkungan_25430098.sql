-- ===================================================================
-- Berkas    : p01_lingkungan_25430098.sql
-- Penulis   : Kevin Maulana Arditama (NPM: 25430098)
-- Topik     : Modul 1 - Lingkungan Kerja MariaDB di XAMPP dan Git
-- Deskripsi : Skrip idempotent untuk membuat basis data dan akun kerja
-- ===================================================================

-- 1. Membuat basis data praktik Kopma jika belum ada
CREATE DATABASE IF NOT EXISTS kopma_098
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 2. Membuat basis data proyek Toko Daring jika belum ada
CREATE DATABASE IF NOT EXISTS toko_098
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 3. Membuat akun kerja mhs_098 dan akun tamu_098 jika belum ada
-- Catatan: Password disembunyikan menggunakan penanda sesuai aturan keaslian
CREATE USER IF NOT EXISTS 'mhs_098'@'localhost' IDENTIFIED BY '<password_kerja>';
CREATE USER IF NOT EXISTS 'tamu_098'@'localhost' IDENTIFIED BY '<password_tamu>';

-- 4. Memberikan hak akses penuh ke mhs_098 pada basis data milik sendiri
GRANT ALL PRIVILEGES ON kopma_098.* TO 'mhs_098'@'localhost';
GRANT ALL PRIVILEGES ON toko_098.* TO 'mhs_098'@'localhost';

-- 5. Memberikan hak akses SELECT saja ke tamu_098 untuk basis data toko_098
GRANT SELECT ON toko_098.* TO 'tamu_098'@'localhost';

-- 6. Memperbarui tabel hak akses server
FLUSH PRIVILEGES;