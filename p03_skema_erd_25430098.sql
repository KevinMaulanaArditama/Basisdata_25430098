-- DDL Basis Data Toko Daring (toko_098)
-- Nama: Kevin Maulana Arditama
-- NIM: 25430098
-- Kelas: D
-- Pertemuan 03: Implementasi Konseptual ERD ke Skema SQL

CREATE TABLE pelanggan (
    id_pelanggan INT AUTO_INCREMENT PRIMARY KEY,
    nama_lengkap VARCHAR(100) NOT NULL,
    email_pelanggan VARCHAR(100) UNIQUE NOT NULL,
    kata_sandi_hash VARCHAR(255) NOT NULL,
    nomor_hp VARCHAR(20),
    alamat_lengkap TEXT
);

CREATE TABLE kategori (
    id_kategori INT AUTO_INCREMENT PRIMARY KEY,
    nama_kategori VARCHAR(100) NOT NULL
);

CREATE TABLE produk (
    id_produk INT AUTO_INCREMENT PRIMARY KEY,
    id_kategori INT NOT NULL,
    nama_produk VARCHAR(150) NOT NULL,
    deskripsi_produk TEXT,
    harga_dasar DECIMAL(12, 2) NOT NULL DEFAULT 0,
    CONSTRAINT fk_produk_kategori 
        FOREIGN KEY (id_kategori) REFERENCES kategori(id_kategori) 
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE varian_produk (
    id_varian INT AUTO_INCREMENT PRIMARY KEY,
    id_produk INT NOT NULL,
    ukuran_produk VARCHAR(20),
    warna_produk VARCHAR(50),
    stok_varian INT NOT NULL DEFAULT 0,
    CONSTRAINT fk_varian_produk 
        FOREIGN KEY (id_produk) REFERENCES produk(id_produk) 
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE pesanan (
    id_pesanan INT AUTO_INCREMENT PRIMARY KEY,
    id_pelanggan INT NOT NULL,
    tanggal_pesanan DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_harga DECIMAL(12, 2) NOT NULL DEFAULT 0,
    status_pesanan VARCHAR(50) DEFAULT 'Pending',
    CONSTRAINT fk_pesanan_pelanggan 
        FOREIGN KEY (id_pelanggan) REFERENCES pelanggan(id_pelanggan) 
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE detail_pesanan (
    id_detail INT AUTO_INCREMENT PRIMARY KEY,
    id_pesanan INT NOT NULL,
    id_varian INT NOT NULL,
    jumlah_beli INT NOT NULL DEFAULT 1,
    subtotal_harga DECIMAL(12, 2) NOT NULL DEFAULT 0,
    CONSTRAINT fk_detail_pesanan 
        FOREIGN KEY (id_pesanan) REFERENCES pesanan(id_pesanan) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_detail_varian 
        FOREIGN KEY (id_varian) REFERENCES varian_produk(id_varian) 
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE pembayaran (
    id_pembayaran INT AUTO_INCREMENT PRIMARY KEY,
    id_pesanan INT NOT NULL,
    metode_bayar VARCHAR(50) NOT NULL,
    tanggal_bayar DATETIME DEFAULT CURRENT_TIMESTAMP,
    nominal_bayar DECIMAL(12, 2) NOT NULL DEFAULT 0,
    status_pembayaran VARCHAR(50) DEFAULT 'Belum Lunas',
    CONSTRAINT fk_pembayaran_pesanan 
        FOREIGN KEY (id_pesanan) REFERENCES pesanan(id_pesanan) 
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE loyalitas_poin (
    id_poin INT AUTO_INCREMENT PRIMARY KEY,
    id_pelanggan INT NOT NULL,
    id_pesanan INT NULL,
    poin_masuk INT DEFAULT 0,
    poin_keluar INT DEFAULT 0,
    tanggal_riwayat DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_poin_pelanggan 
        FOREIGN KEY (id_pelanggan) REFERENCES pelanggan(id_pelanggan) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_poin_pesanan 
        FOREIGN KEY (id_pesanan) REFERENCES pesanan(id_pesanan) 
        ON DELETE SET NULL ON UPDATE CASCADE
);