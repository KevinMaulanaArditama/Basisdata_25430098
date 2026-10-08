# Dokumen Kebutuhan Data Proyek: Toko Daring (Toko 098)
**Penyusun:** Kevin Maulana Arditama (NPM: 25430098)  
**Kelas:** D  
**Mata Kuliah:** Praktikum Basis Data  

---

## 1. Profil Organisasi dan Lingkup Layanan
**Toko Daring (Toko 098)** merupakan platform e-commerce yang melayani penjualan produk pakaian, aksesoris mode (*fashion*), dan perlengkapan seragam secara daring. Ruang lingkup sistem mencakup pengelolaan katalog barang beserta varian warna/ukuran, pendaftaran akun pembeli, pemrosesan transaksi pesanan, pembayaran, integrasi kurir pengiriman, serta program loyalitas poin bagi anggota.

---

## 2. Proses Bisnis (PB)
* **PB-01 (Registrasi dan Autentikasi Pelanggan):** Pelanggan mendaftarkan akun baru dengan mengisi identitas dasar serta nomor kontak, kemudian sistem mengautentikasi dan mengelola hak akses akun.
* **PB-02 (Manajemen Katalog dan Stok Barang):** Admin mengelola data produk, varian ukuran, harga jual, serta memperbarui kuantitas persediaan barang di gudang.
* **PB-03 (Pemesanan dan Transaksi Pembelian):** Pelanggan memasukkan barang ke keranjang, memilih alamat pengiriman dan ekspedisi, lalu membuat faktur pesanan.
* **PB-04 (Konfirmasi Pembayaran dan Verifikasi):** Pelanggan melakukan pelunasan tagihan melalui saluran pembayaran, kemudian sistem/admin memverifikasi pembayaran dan memperbarui status pesanan.
* **PB-05 (Pengelolaan Poin Loyalitas dan Ulasan):** Pelanggan mendapatkan poin loyalitas setelah transaksi lunas, yang dapat ditukarkan dengan potongan harga serta memberikan rating ulasan barang.

---

## 3. Entitas Kandidat (Minimal 6 Entitas)
1. **Pelanggan:** Menyimpan data profil pembeli yang terdaftar di platform `toko_098`.
2. **Kategori:** Menyimpan klasifikasi kelompok busana/aksesoris.
3. **Produk:** Menyimpan data utama barang dagangan, spesifikasi, dan harga jual.
4. **Varian_Produk:** Menyimpan rincian opsi ukuran (*size*) dan warna untuk tiap produk beserta stoknya.
5. **Pesanan:** Menyimpan header nota transaksi pemesanan barang oleh pelanggan.
6. **Detail_Pesanan:** Menyimpan rincian item varian produk yang dibeli, kuantitas, dan subtotal.
7. **Pembayaran:** Menyimpan catatan pelunasan transaksi pesanan dan metode bayar.
8. **Loyalitas_Poin:** Menyimpan catatan perolehan dan penggunaan poin belanja pelanggan.

---

## 4. Aturan Bisnis (AB) - Minimal 8 Aturan
* **AB-01 (Keunikan Identitas Akun):** Setiap akun pelanggan wajib mendaftar menggunakan alamat email yang unik dan kata sandi disimpan dalam bentuk hash terenkripsi.
* **AB-02 (Validitas Harga dan Stok):** Harga satuan produk dan kuantitas stok varian tidak boleh bernilai negatif ($\ge 0$).
* **AB-03 (Klasifikasi Kategori):** Setiap produk wajib terikat pada minimal satu kategori barang aktif.
* **AB-04 (Penomoran Pesanan Otomatis):** Setiap transaksi pesanan baru wajib diberi kode transaksi unik dengan penanda timestamp otomatis.
* **AB-05 (Pemesanan Berbasis Ketersediaan):** Kuantitas barang dalam Detail_Pesanan tidak boleh melebihi sisa stok pada Varian_Produk.
* **AB-06 (Otomatisasi Pemotongan Stok):** Ketika pesanan dibuat, sistem secara otomatis langsung mengurangi stok varian produk terkait.
* **AB-07 (Aturan Poin Loyalitas):** Setiap kelipatan belanja Rp10.000 bernilai 1 poin loyalitas, dan akumulasi 50 poin dapat ditukarkan dengan potongan harga Rp5.000 pada transaksi berikutnya.
* **AB-08 (Batas Waktu Pelunasan):** Pesanan yang tidak dilunasi dalam waktu 1 x 24 jam akan dibatalkan otomatis dan stok barang dikembalikan (*restock*).
* **AB-09 (Validasi Nominal Pembayaran):** Nominal pada entitas Pembayaran wajib bernilai sama persis dengan total tagihan akhir setelah dikurangi diskon poin.

---

## 5. Kebutuhan Informasi (KI) - Minimal 5 Kebutuhan
* **KI-01 (Katalog Produk & Varian Aktif):** Menampilkan daftar produk, pilihan warna/ukuran, harga, dan ketersediaan stok yang siap dipesan.
* **KI-02 (Riwayat Belanja & Poin Pelanggan):** Menampilkan histori pesanan per pelanggan lengkap dengan status pembayaran, nomor resi pengiriman, serta saldo poin loyalitas aktif.
* **KI-03 (Laporan Omzet Penjualan Periodik):** Rekapitulasi pendapatan harian dan bulanan beserta total volume barang terjual untuk analisis manajemen.
* **KI-04 (Peringatan Stok Varian Menipis):** Informasi daftar varian produk dengan persediaan stok di bawah ambang batas minimum ($\le 5$ unit) untuk proses *restock*.
* **KI-05 (Rekapitulasi Penukaran Poin Loyalitas):** Laporan total penggunaan poin belanja oleh anggota dan dampak potongan harga pada pendapatan.

---

## 6. Matriks CRUD Lengkap

| Entitas | Registrasi Akun | Kelola Katalog | Buat Pesanan | Bayar Pesanan | Tukar Poin | Rekap Laporan |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **Pelanggan** | C, R | - | R | R | R, U | R |
| **Kategori** | - | C, R, U, D | R | - | - | R |
| **Produk** | - | C, R, U, D | R | - | - | R |
| **Varian_Produk** | - | C, R, U, D | R, U (stok) | - | - | R |
| **Pesanan** | - | - | C, R | R, U (status) | R, U | R |
| **Detail_Pesanan**| - | - | C, R | R | - | R |
| **Pembayaran** | - | - | - | C, R | - | R |
| **Loyalitas_Poin**| - | - | C, R | R | C, R, U | R |

---

## 7. Kamus Data Awal (22 Elemen dengan Penanggung Jawab)

| No | Nama Elemen Data | Tipe Data | Keterangan / Batasan | Penanggung Jawab |
|---|---|---|---|---|
| 1 | `id_pelanggan` | INT | Primary Key identitas akun pembeli | Database Administrator |
| 2 | `nama_lengkap` | VARCHAR(100) | Nama lengkap pelanggan | Pelanggan / Front-End Dev |
| 3 | `email_pelanggan` | VARCHAR(100) | Alamat email unik untuk login | Pelanggan / Front-End Dev |
| 4 | `kata_sandi_hash` | VARCHAR(255) | Hash kata sandi terenkripsi (bcrypt) | Backend Developer / Security |
| 5 | `nomor_hp` | VARCHAR(20) | Nomor WhatsApp/kontak aktif | Pelanggan |
| 6 | `alamat_lengkap` | TEXT | Alamat pengiriman barang | Pelanggan |
| 7 | `id_kategori` | INT | Primary Key kelompok barang | Admin Gudang |
| 8 | `nama_kategori` | VARCHAR(50) | Nama kategori (mis: Kemeja, Jaket) | Admin Gudang |
| 9 | `id_produk` | INT | Primary Key data utama produk | Admin Gudang |
| 10 | `nama_produk` | VARCHAR(150) | Nama barang dagangan | Admin Gudang |
| 11 | `harga_satuan` | DECIMAL(12,2) | Harga jual barang dalam rupiah ($\ge 0$) | Bagian Keuangan / Admin |
| 12 | `id_varian` | INT | Primary Key kombinasi opsi barang | Admin Gudang |
| 13 | `ukuran_produk` | VARCHAR(10) | Opsi ukuran (S, M, L, XL, XXL) | Admin Gudang |
| 14 | `warna_produk` | VARCHAR(30) | Opsi warna produk | Admin Gudang |
| 15 | `stok_varian` | INT | Sisa persediaan barang di gudang ($\ge 0$) | Admin Gudang |
| 16 | `id_pesanan` | INT | Nomor unik faktur transaksi | Sistem Pemesanan |
| 17 | `tanggal_pesanan` | DATETIME | Waktu transaksi dibuat otomatis | Sistem Pemesanan |
| 18 | `total_harga` | DECIMAL(12,2) | Total tagihan sebelum potongan diskon | Sistem Pemesanan |
| 19 | `jumlah_poin_pakai`| INT | Poin yang ditukarkan pada transaksi | Pelanggan / Sistem |
| 20 | `potongan_diskon` | DECIMAL(12,2) | Nilai potongan dari penukaran poin | Sistem Pemesanan |
| 21 | `total_bayar` | DECIMAL(12,2) | Tagihan bersih yang wajib dilunasi | Sistem Pemesanan |
| 22 | `id_pembayaran` | INT | Primary Key bukti transaksi bayar | Bagian Keuangan |

---

## 8. Kebutuhan Non-Fungsional dan Perlindungan Data Pribadi
1. **Perlindungan Data Pribadi (Privasi):**
   * Data sensitif (`kata_sandi_hash`, `nomor_hp`, `alamat_lengkap`) diklasifikasikan sebagai data pribadi rahasia.
   * Kata sandi wajib menggunakan enkripsi hash aman dan dilarang ditampilkan secara teks polos.
   * Akses alamat dan nomor telepon dibatasi hanya untuk pemilik akun serta petugas logistik/pengiriman (Role-Based Access Control).
2. **Ketersediaan & Keandalan (Availability & Reliability):**
   * Layanan katalog dan pesanan beroperasi 24/7 dengan batas toleransi pemulihan sistem maksimal 15 menit.
   * Setiap pengurangan stok dan penambahan poin menggunakan prinsip *ACID Transaction* agar data tetap konsisten.
3. **Performa (Performance):**
   * Pencarian produk dan pemuatan halaman katalog wajib merespon dalam waktu $\le 500$ milidetik.

---

## 9. Bedah Dokumen Sumber Fiktif: Nota Pembelian Toko 098

### Rancangan Dokumen Nota Fiktif
```text
======================================================================
                         TOKO 098 (STORE 098)
                Katalog Pakaian & Aksesoris Daring
======================================================================
No. Nota    : TK098-202610-098             Tanggal: 2026-10-08 16:00
Pelanggan   : Kevin Maulana Arditama       Kontak : 085277889900
Alamat      : Jl. Ahmad Yani No. 98, Metro, Lampung
----------------------------------------------------------------------
Item Produk           Varian (Size/Warna)  Qty   Harga Satuan   Subtotal
----------------------------------------------------------------------
1. Kemeja Casual      L / Hitam             2    Rp150.000      Rp300.000
2. Jaket Parka        XL / Navy             1    Rp250.000      Rp250.000
----------------------------------------------------------------------
Subtotal Belanja                                                Rp550.000
Potongan Poin (50 Poin Dipergunakan)                           -Rp5.000
----------------------------------------------------------------------
Total Pembayaran                                                Rp545.000
Poin Diperoleh Transaction Ini : +54 Poin
Status Pembayaran : LUNAS (Transfer Bank)
======================================================================