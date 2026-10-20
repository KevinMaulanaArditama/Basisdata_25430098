# Analisis Normalisasi Basis Data & BCNF - Toko Daring (toko_098)
**Nama:** Kevin Maulana Arditama  
**NIM:** 25430098  
**Kelas:** D  
**Tanggal:** 20 Oktober 2026  

---

## 1. Dokumen Sumber / Struktur Unnormalized Form (UNF)
Titik awal data mentah diambil dari dokumen Nota Transaksi Belanja Toko Daring (`toko_098`):

`Nota_Pesanan` = { `no_nota`, `tgl_pesanan`, `id_pelanggan`, `nama_pelanggan`, `email`, `alamat`, `metode_bayar`, `total_bayar`, (`id_produk`, `nama_produk`, `id_kategori`, `nama_kategori`, `ukuran`, `warna`, `harga_dasar`, `qty`, `subtotal`), `saldo_poin` }

---

## 2. Dependensi Fungsional (Functional Dependency) & Kode AB
Berdasarkan Aturan Bisnis (AB) Toko Daring `toko_098`:
- **FD1:** `id_pelanggan` $\rightarrow$ `nama_pelanggan`, `email`, `alamat` *(AB-01)*
- **FD2:** `id_kategori` $\rightarrow$ `nama_kategori` *(AB-03)*
- **FD3:** `id_produk` $\rightarrow$ `nama_produk`, `id_kategori`, `harga_dasar` *(AB-02)*
- **FD4:** `id_varian` $\rightarrow$ `id_produk`, `ukuran`, `warna`, `stok_varian` *(AB-02)*
- **FD5:** `no_nota` $\rightarrow$ `tgl_pesanan`, `id_pelanggan`, `metode_bayar`, `total_bayar` *(AB-04, AB-08)*
- **FD6:** (`no_nota`, `id_varian`) $\rightarrow$ `qty`, `subtotal` *(AB-05)*

---

## 3. Tahapan Normalisasi

### A. Bentuk Normal Pertama (1NF)
Menghilangkan kelompok berulang (*repeating groups*) dengan meratakan struktur nota belanja:

`Nota_1NF` (<u>`no_nota`</u>, <u>`id_varian`</u>, `tgl_pesanan`, `id_pelanggan`, `nama_pelanggan`, `email`, `alamat`, `id_produk`, `nama_produk`, `id_kategori`, `nama_kategori`, `ukuran`, `warna`, `harga_dasar`, `qty`, `subtotal`, `metode_bayar`, `total_bayar`)

### B. Bentuk Normal Kedua (2NF)
Menghilangkan Ketergantungan Parsial (*Partial Dependency*) dari *Composite Primary Key* (`no_nota`, `id_varian`):

- **`Pesanan`** (<u>`no_nota`</u>, `tgl_pesanan`, `id_pelanggan`, `nama_pelanggan`, `email`, `alamat`, `metode_bayar`, `total_bayar`)
- **`Varian_Produk`** (<u>`id_varian`</u>, `id_produk`, `nama_produk`, `id_kategori`, `nama_kategori`, `ukuran`, `warna`, `harga_dasar`)
- **`Detail_Pesanan`** (<u>`no_nota`</u> [FK], <u>`id_varian`</u> [FK], `qty`, `subtotal`)

### C. Bentuk Normal Ketiga (3NF)
Menghilangkan Ketergantungan Transitif (*Transitive Dependency*):

- **`Pelanggan`** (<u>`id_pelanggan`</u>, `nama_pelanggan`, `email`, `alamat`)
- **`Kategori`** (<u>`id_kategori`</u>, `nama_kategori`)
- **`Produk`** (<u>`id_produk`</u>, `id_kategori` [FK], `nama_produk`, `harga_dasar`)
- **`Varian_Produk`** (<u>`id_varian`</u>, `id_produk` [FK], `ukuran`, `warna`)
- **`Pesanan`** (<u>`no_nota`</u>, `id_pelanggan` [FK], `tgl_pesanan`, `total_bayar`)
- **`Pembayaran`** (<u>`id_pembayaran`</u>, `no_nota` [FK], `metode_bayar`, `status_bayar`)
- **`Detail_Pesanan`** (<u>`id_detail`</u>, `no_nota` [FK], `id_varian` [FK], `qty`, `subtotal`)
- **`Loyalitas_Poin`** (<u>`id_poin`</u>, `id_pelanggan` [FK], `no_nota` [FK], `poin_masuk`, `poin_keluar`)

### D. Pemeriksaan BCNF (Boyce-Codd Normal Form)
Setiap determinan pada seluruh relasi di atas sudah berupa *Candidate Key* / *Super Key* (contoh: `id_produk` menentukan atribut produk lainnya, `id_detail` menentukan rincian transaksi). Seluruh tabel telah **memenuhi BCNF**.

---

## 4. Analisis Keputusan Penyimpanan Nilai Turunan (*Derived Attributes*)
1. **`subtotal` (`Detail_Pesanan`):** Disimpan (*Redundant/Cached*) untuk menghindari kalkulasi ulang dan mengunci harga historis saat transaksi dilakukan.
2. **`total_bayar` (`Pesanan`):** Disimpan untuk mempercepat performa penarikan laporan omzet keuangan tanpa harus melakukan *JOIN* berulang ke tabel detail.

---

## 5. Kesimpulan ERD
Struktur 8 entitas pada Toko Daring (`toko_098`) terbukti telah ternormalisasi hingga tingkat BCNF dan tidak memerlukan perombakan struktur entitas utama.

---

<FollowUp>
Apakah file terpisah `p04_normalisasi_25430098.md` ini sudah pas posisinya di direktori utama tanpa tercampur folder laporan, King?
</FollowUp>