-- ============================================================
-- SCRIPT DDL BASIS DATA FISIK TOKO DARING (toko_098)
-- Pertemuan 05: Milestone Proyek 5
-- Nama  : Kevin Maulana Arditama
-- NIM   : 25430098
-- Kelas : D
-- Aturan Batas P + 2 : 0 + 2 = 2[cite: 8]
-- ============================================================

-- Drop database jika sudah ada agar dapat dijalankan ulang dari kondisi kosong[cite: 8]
DROP DATABASE IF EXISTS toko_098;
CREATE DATABASE toko_098;
USE toko_098;

-- ============================================================
-- 1. TABEL: pelanggan (AB-01, AB-07)
-- ============================================================
CREATE TABLE pelanggan (
    id_pelanggan INT AUTO_INCREMENT,
    nama_lengkap VARCHAR(100) NOT NULL,
    email_pelanggan VARCHAR(100) NOT NULL,
    kata_sandi_hash VARCHAR(255) NOT NULL,
    nomor_hp VARCHAR(20),
    alamat_lengkap TEXT,
    CONSTRAINT pk_pelanggan PRIMARY KEY (id_pelanggan),
    CONSTRAINT uq_pelanggan_email UNIQUE (email_pelanggan)
);

-- ============================================================
-- 2. TABEL: kategori (AB-03)
-- ============================================================
CREATE TABLE kategori (
    id_kategori INT AUTO_INCREMENT,
    nama_kategori VARCHAR(100) NOT NULL,
    CONSTRAINT pk_kategori PRIMARY KEY (id_kategori)
);

-- ============================================================
-- 3. TABEL: produk (AB-02, AB-03)
-- ============================================================
CREATE TABLE produk (
    id_produk INT AUTO_INCREMENT,
    id_kategori INT NOT NULL,
    nama_produk VARCHAR(150) NOT NULL,
    deskripsi_produk TEXT,
    harga_dasar DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    CONSTRAINT pk_produk PRIMARY KEY (id_produk),
    CONSTRAINT fk_produk_kategori FOREIGN KEY (id_kategori) 
        REFERENCES kategori(id_kategori) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT chk_produk_harga_dasar CHECK (harga_dasar >= 0)
);

-- ============================================================
-- 4. TABEL: varian_produk (AB-02)
-- ============================================================
CREATE TABLE varian_produk (
    id_varian INT AUTO_INCREMENT,
    id_produk INT NOT NULL,
    ukuran_produk VARCHAR(20),
    warna_produk VARCHAR(50),
    stok_varian INT NOT NULL DEFAULT 0,
    CONSTRAINT pk_varian_produk PRIMARY KEY (id_varian),
    CONSTRAINT fk_varian_produk_produk FOREIGN KEY (id_produk) 
        REFERENCES produk(id_produk) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT chk_varian_stok CHECK (stok_varian >= 0)
);

-- ============================================================
-- 5. TABEL: pesanan (AB-04, AB-08)
-- ============================================================
CREATE TABLE pesanan (
    id_pesanan INT AUTO_INCREMENT,
    id_pelanggan INT NULL, -- Set NULL jika akun pelanggan dihapus (UU PDP)[cite: 8]
    tanggal_pesanan DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_harga DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    status_pesanan VARCHAR(50) DEFAULT 'Pending',
    CONSTRAINT pk_pesanan PRIMARY KEY (id_pesanan),
    CONSTRAINT fk_pesanan_pelanggan FOREIGN KEY (id_pelanggan) 
        REFERENCES pelanggan(id_pelanggan) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT chk_pesanan_total_harga CHECK (total_harga >= 0)
);

-- ============================================================
-- 6. TABEL: detail_pesanan (AB-05)
-- ============================================================
CREATE TABLE detail_pesanan (
    id_detail INT AUTO_INCREMENT,
    id_pesanan INT NOT NULL,
    id_varian INT NOT NULL,
    jumlah_beli INT NOT NULL DEFAULT 2, -- Menerapkan batas P+2 = 2[cite: 8]
    subtotal_harga DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    CONSTRAINT pk_detail_pesanan PRIMARY KEY (id_detail),
    CONSTRAINT fk_detail_pesanan_pesanan FOREIGN KEY (id_pesanan) 
        REFERENCES pesanan(id_pesanan) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_detail_pesanan_varian FOREIGN KEY (id_varian) 
        REFERENCES varian_produk(id_varian) ON DELETE RESTRICT ON UPDATE CASCADE,
    -- Constraint CHECK kuantitas minimal berdasarkan aturan batas P+2 = 2[cite: 8]
    CONSTRAINT chk_detail_jumlah_beli CHECK (jumlah_beli >= 2),
    CONSTRAINT chk_detail_subtotal CHECK (subtotal_harga >= 0)
);

-- ============================================================
-- 7. TABEL: pembayaran (AB-08)
-- ============================================================
CREATE TABLE pembayaran (
    id_pembayaran INT AUTO_INCREMENT,
    id_pesanan INT NOT NULL,
    metode_bayar VARCHAR(50) NOT NULL,
    tanggal_bayar DATETIME DEFAULT CURRENT_TIMESTAMP,
    nominal_bayar DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    status_pembayaran VARCHAR(50) DEFAULT 'Belum Lunas',
    CONSTRAINT pk_pembayaran PRIMARY KEY (id_pembayaran),
    CONSTRAINT fk_pembayaran_pesanan FOREIGN KEY (id_pesanan) 
        REFERENCES pesanan(id_pesanan) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT chk_pembayaran_nominal CHECK (nominal_bayar >= 0)
);

-- ============================================================
-- 8. TABEL: loyalitas_poin (AB-07)
-- ============================================================
CREATE TABLE loyalitas_poin (
    id_poin INT AUTO_INCREMENT,
    id_pelanggan INT NOT NULL, 
    id_pesanan INT NULL,
    poin_masuk INT DEFAULT 0,
    poin_keluar INT DEFAULT 0,
    tanggal_riwayat DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_loyalitas_poin PRIMARY KEY (id_poin),
    CONSTRAINT fk_poin_pelanggan FOREIGN KEY (id_pelanggan) 
        REFERENCES pelanggan(id_pelanggan) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_poin_pesanan FOREIGN KEY (id_pesanan) 
        REFERENCES pesanan(id_pesanan) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT chk_poin_masuk CHECK (poin_masuk >= 0),
    CONSTRAINT chk_poin_keluar CHECK (poin_keluar >= 0)
);