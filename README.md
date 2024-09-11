# To-Do List Application
## Petunjuk pengerjaan Frontend Coding Tes:
To-do List Application adalah sebuah aplikasi yang biasa digunakan untuk menulis hal-hal yang perlu digunakan.
Dalam sebuah to-do list application, hal-hal yang biasanya bisa dilakukan adalah mencatat hal-hal yang perlu
dilakukan dalam bentuk poin-poin, dan menandai hal-hal tersebut apabila sudah selesai dilakukan. Salah satu contoh
aplikasi to-do list yang bisa digunakan adalah Google Keep.

Berdasarkan gambar 2, to do list application juga biasanya menyediakan fitur untuk mengelompokan hal-hal yang
perlu dikerjakan dalam catatan-catatan kecil, misalkan untuk checklist harian.
Untuk memastikan catatan yang dibuka adalah milik kamu, sebuah to-do list application biasanya dilengkapi fitur login.
Hal tersebut memastikan catatan yang dibuka di aplikasi adalah catatan yang telah kamu tuliskan sebelumnya.
Buatlah sebuah to-do list application simple, dengan fitur-fitur sebagai berikut:
1. Halaman login (DONE)
2. Halaman daftar baru (DONE)
3. Halaman untuk membuat checklist (berdasarkan contoh gambar 2, adalah kotak-kotak yang berwarna) (DONE)
4. Action untuk menghapus checklist
5. Halaman untuk menampilkan checklist-checklist yang sudah dibuat (DONE)
6. Halaman Detail Checklist (Berisi item-item to-do yang sudah dibuat)
7. Halaman untuk membuat item-item to-do di dalam checklist
8. Halaman detail item
9. Action untuk mengubah item-item di dalam checklist
10. Action untuk mengubah status dari item di dalam checklist (misalkan item sudah selesai dilakukan)
11. Action untuk menghapus item dari checklist

Note:
Action dan halaman tidak harus sama dengan contoh gambar.
Fitur nomor 3-11 hanya bisa diakses atau dilakukan apabila sudah login
Fitur-fitur yang dibuat harap mengimplementasikan API yang sudah disediakan. API dapat diakses melalui

http://94.74.86.174:8080/api/swagger-ui.html#/. API dapat dicoba melalui aplikasi Postman atau Insomnia API (atau aplikasi-
aplikasi API lain yang pernah anda gunakan)

Selain melalui link di atas, dokumentasi API juga dapat dilihat melalui dokumen yang telah kami lampirkan.
Fitur login diimplementasi menggunakan bearer token.

## Teknologi yang Digunakan

- **Flutter**: Framework untuk pengembangan aplikasi mobile lintas platform (iOS dan Android)
- **Dart**: Bahasa pemrograman yang digunakan oleh Flutter
- **Domain-Driven Design (DDD)**: Arsitektur perangkat lunak yang memisahkan kode menjadi 3 layer utama, yaitu data, domain, dan presentasi
