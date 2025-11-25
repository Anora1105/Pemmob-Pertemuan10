# Nama : Ariza Nola Rufiana
# NIM : H1D023005
## Tugas Pertemuan 10

* Registrasi & Login (simulasi / in-memory)
* Tampilan daftar produk, tambah/ubah/hapus produk (UI dasar)
* Struktur modular dengan UI terpisah (halaman), model, dan service

### Struktur & penjelasan file (letakkan penjelasan ini di README)
#### `lib/main.dart`

**Fungsi:** Titik masuk aplikasi. Menginisialisasi `MaterialApp`, tema, dan halaman awal (`home`).

**Penjelasan singkat:**

* `MyApp` men-setup `MaterialApp` dengan tema (menggunakan `ColorScheme.fromSeed`) dan mengarahkan ke `LoginPage` sebagai halaman awal.
* Ubah `home:` bila ingin langsung membuka `ProdukPage()` saat development/testing.
* Opsi: set `debugShowCheckedModeBanner: false` untuk menyembunyikan badge debug.

**Tempat edit umum:** ganti `seedColor`, ubah `home`, tambahkan route named jika butuh navigasi lebih terstruktur.

---

### `lib/services/auth_service.dart`

**Fungsi:** Service autentikasi sederhana (in-memory). Digunakan untuk praktikum tanpa backend.

**Penjelasan singkat:**

* Menyimpan data registrasi (name, email, password) secara temporer di memori.
* `register(...)` menyimpan data; `login(...)` memeriksa kecocokan; ada helper `registeredName` & `hasRegistered`.
* Simulasi delay menggunakan `Future.delayed` agar behavior mirip panggilan jaringan.

**Catatan penting:**

* Saat produksi, ganti service ini dengan panggilan API atau simpan menggunakan `shared_preferences` / secure storage.
* Tidak aman untuk menyimpan password plain-text; hanya untuk praktikum.

---

### `lib/ui/login_page.dart`

**Fungsi:** Halaman login. Validasi input, menampilkan loading, dan navigasi ke `ProdukPage` setelah login sukses (simulasi / sesuai `AuthService`).

**Penjelasan singkat:**

* Form terdiri dari email & password dengan validasi sederhana.
* `_doLogin()` melakukan validasi form, memanggil `AuthService.login`, kemudian `Navigator.pushReplacement` ke `ProdukPage` bila sukses.
* Menampilkan snackbar untuk pesan error atau instruksi (mis. "Belum punya akun?").

**Tempat edit umum:** ganti teks AppBar / tombol (sudah diganti menjadi `Login Ariza`), sambungkan ke backend nyata, atau tambahkan fitur "Lupa Password".

---

### `lib/ui/registrasi_page.dart`

**Fungsi:** Halaman registrasi. Mengumpulkan nama, email, password & konfirmasi password; validasi; panggil `AuthService.register`.

**Penjelasan singkat:**

* Memiliki validasi lengkap: nama minimal 3 karakter, format email, password minimal 6 karakter, konfirmasi password harus sama.
* `_onSubmit()` melakukan simulasi pendaftaran (memanggil service), menampilkan snackbar sukses, dan kembali ke halaman login.
* `_isLoading` untuk menampilkan progress indicator saat proses berjalan.

**Tempat edit umum:** Integrasi ke server, menambah validasi password kuat, atau menyimpan data ke `shared_preferences`.

---

### `lib/ui/produk_page.dart`

**Fungsi:** Halaman daftar produk (List). Menampilkan `ItemProduk` dan tombol tambah pada AppBar.

**Penjelasan singkat:**

* AppBar berisi judul (mis. `List Produk Ariza`) dan action untuk membuka form tambah produk (`ProdukForm`).
* Saat men-tap item, navigasi ke `ProdukDetail`.
* Contoh data saat ini diisi statis (dummy). Untuk CRUD nyata, hubungkan dengan service / API.

**Tempat edit umum:** Ganti sumber data menjadi API, tambahkan pull-to-refresh, search, pagination.

---

### `lib/ui/produk_form.dart`

**Fungsi:** Form tambah/ubah produk (kode, nama, harga).

**Penjelasan singkat:**

* Digunakan baik untuk menambah produk baru maupun mengubah produk yang ada (jika `widget.produk != null` maka mode update).
* Validasi sederhana tiap field (tidak kosong).
* Tombol submit melakukan validasi dan menaikkan aksi (saat ini hanya melakukan `Navigator.pop` setelah submit simulasi).

**Tempat edit umum:** Sambungkan ke CRUD API (POST/PUT), validasi angka untuk harga (parse to int), dan handling error saat menyimpan.

---

### `lib/ui/produk_detail.dart`

**Fungsi:** Menampilkan detail produk yang dipilih (kode, nama, harga) dan tombol Edit/Delete.

**Penjelasan singkat:**

* Tombol EDIT membuka `ProdukForm` dengan data produk untuk diubah.
* Tombol DELETE memunculkan konfirmasi sebelum menghapus. Implementasi penghapusan disesuaikan dengan service/backend.

**Tempat edit umum:** Implementasikan panggilan delete ke backend dan mekanisme update UI setelah penghapusan.

---

### `lib/model/produk.dart`  *(jika ada di project)*

**Fungsi:** Model data `Produk`.

**Contoh struktur yang direkomendasikan:**

```dart
class Produk {
  final String id;
  final String? kodeProduk;
  final String? namaProduk;
  final String? hargaProduk; // atau int? jika ingin numeric

  Produk({required this.id, this.kodeProduk, this.namaProduk, this.hargaProduk});
}
```
<img width="400" height="600" alt="Screenshot 2025-11-25 232556" src="https://github.com/user-attachments/assets/a57c41e6-66bc-4d91-a185-c006a8c68934" />
<img width="400" height="600" alt="Screenshot 2025-11-25 232643" src="https://github.com/user-attachments/assets/c820ee76-ed72-47f7-9175-24314e960f67" />

