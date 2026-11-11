-- Nama: Kevin Maulana Arditama
-- NIM: 25430098
-- Kelas: D
-- Modul: Pertemuan 7 (Kueri Satu Tabel & Milestone Proyek 7)

-- KI-01: Cari produk pakaian dengan kata kunci 'Kaos'
-- Pertanyaan: Produk apa saja yang memiliki nama mengandung kata 'Kaos'?
-- Hasil yang diharapkan: Menampilkan daftar produk yang cocok dengan pola pencarian.
SELECT id_produk, nama_produk, harga_dasar 
FROM produk 
WHERE nama_produk LIKE '%Kaos%';

-- KI-02: Filter produk harga menengah (BETWEEN)
-- Pertanyaan: Produk apa saja yang harga dasarnya di antara Rp 50.000 dan Rp 150.000?
-- Hasil yang diharapkan: Daftar produk dengan rentang harga ekonomis-menengah.
SELECT id_produk, nama_produk, harga_dasar 
FROM produk 
WHERE harga_dasar BETWEEN 50000 AND 150000;

-- KI-03: Filter kelompok kategori ID tertentu (IN)
-- Pertanyaan: Produk apa saja yang berada di kategori ID 1 atau 2?
-- Hasil yang diharapkan: Baris produk yang masuk dalam kelompok kategori terpilih.
SELECT id_produk, id_kategori, nama_produk 
FROM produk 
WHERE id_kategori IN (1, 2);

-- KI-04: Audit pelanggan tanpa nomor HP (IS NULL)
-- Pertanyaan: Pelanggan siapa saja yang belum mengisi nomor HP?
-- Hasil yang diharapkan: Daftar pelanggan dengan kolom nomor HP bernilai kosong/NULL.
SELECT id_pelanggan, nama_lengkap, email 
FROM pelanggan 
WHERE nomor_hp IS NULL;

-- KI-05: Klasifikasi status stok varian produk (CASE)
-- Pertanyaan: Bagaimana status ketersediaan stok fisik untuk setiap varian produk?
-- Hasil yang diharapkan: Kolom tambahan berlabel 'Stok Menipis' atau 'Stok Aman'.
SELECT id_varian, id_produk, ukuran_produk, warna_produk, stok_varian,
    CASE 
        WHEN stok_varian < 15 THEN 'Stok Menipis'
        ELSE 'Stok Aman'
    END AS status_stok
FROM varian_produk;

-- KI-06: Rekap pesanan periode bulan tertentu (Fungsi Tanggal)
-- Pertanyaan: Pesanan apa saja yang tercatat dibuat pada bulan Oktober tahun 2026?
-- Hasil yang diharapkan: Transaksi pesanan yang sesuai dengan filter tanggal.
SELECT id_pesanan, tanggal_pesanan, total_harga, status_pesanan 
FROM pesanan 
WHERE YEAR(tanggal_pesanan) = 2026 AND MONTH(tanggal_pesanan) = 10;

-- KI-07: Standardisasi format teks kapital & rupiah (Fungsi String & Format)
-- Pertanyaan: Bagaimana tampilan nama produk dalam huruf kapital dan harga berformat Rupiah?
-- Hasil yang diharapkan: Katalog produk terstandarisasi.
SELECT id_produk, UPPER(nama_produk) AS nama_kapital, 
    CONCAT('Rp', FORMAT(harga_dasar, 0, 'id_ID')) AS harga_rupiah 
FROM produk;

-- KI-08: Urutkan pesanan dengan total harga tertinggi (ORDER BY & LIMIT)
-- Pertanyaan: 3 transaksi pesanan apa yang memiliki total harga paling besar?
-- Hasil yang diharapkan: 3 baris pesanan teratas dari nominal terbesar.
SELECT id_pesanan, id_pelanggan, total_harga 
FROM pesanan 
ORDER BY total_harga DESC 
LIMIT 3;

-- KI-09: Filter pesanan berstatus 'Pending'
-- Pertanyaan: Pesanan mana saja yang statusnya masih 'Pending'?
-- Hasil yang diharapkan: Daftar pesanan yang belum diproses.
SELECT id_pesanan, tanggal_pesanan, status_pesanan 
FROM pesanan 
WHERE status_pesanan = 'Pending';

-- KI-10: Filter riwayat poin loyalitas tinggi
-- Pertanyaan: Transaksi mutasi poin mana yang perolehannya di atas 20 poin?
-- Hasil yang diharapkan: Baris riwayat poin loyalitas bernilai besar.
SELECT id_poin, id_pelanggan, jumlah_poin, jenis_mutasi 
FROM poin_loyalitas 
WHERE jumlah_poin > 20;