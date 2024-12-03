import 'package:flutter/material.dart';

class ToSandPrivacyPage extends StatefulWidget {
  const ToSandPrivacyPage({super.key});

  @override
  State<ToSandPrivacyPage> createState() => _ToSandPrivacyPageState();
}

class _ToSandPrivacyPageState extends State<ToSandPrivacyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Syarat dan Ketentuan & Kebijakan Privasi'),
        titleTextStyle: const TextStyle(fontWeight: FontWeight.bold),
        backgroundColor: const Color.fromARGB(255, 114, 76, 175),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Syarat dan Ketentuan (TOS) Section
            Text(
              'Syarat dan Ketentuan',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              '''Selamat datang di E-Presensi! Dengan menggunakan aplikasi ini, Anda setuju untuk mematuhi syarat dan ketentuan berikut. Harap baca dengan teliti:

1. **Penerimaan Syarat**: Dengan mengakses atau menggunakan aplikasi E-Presensi, Anda setuju untuk mematuhi syarat dan ketentuan ini serta semua peraturan yang berlaku.
2. **Pendaftaran Akun**: Untuk menggunakan beberapa fitur, Anda mungkin perlu mendaftar akun. Anda bertanggung jawab atas kerahasiaan informasi akun Anda.
3. **Penggunaan Aplikasi**: Anda hanya diperbolehkan menggunakan aplikasi ini untuk tujuan yang sah, dan Anda tidak diperbolehkan menyalahgunakan aplikasi ini.
4. **Penghentian Akun**: Kami berhak untuk menghentikan akun Anda jika Anda melanggar syarat dan ketentuan ini.
5. **Batasan Tanggung Jawab**: Kami tidak bertanggung jawab atas kerugian yang timbul akibat penggunaan aplikasi ini.

Untuk daftar lengkap syarat dan ketentuan, silakan kunjungi situs resmi kami.
            ''',
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            const SizedBox(height: 24),

            // Kebijakan Privasi Section
            Text(
              'Kebijakan Privasi',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              '''Di E-Presensi, kami menghargai privasi Anda. Kebijakan Privasi ini menjelaskan bagaimana kami mengumpulkan, menggunakan, dan melindungi informasi pribadi Anda:

1. **Pengumpulan Data**: Kami mengumpulkan informasi pribadi seperti nama, email, dan catatan presensi untuk memberikan layanan dalam aplikasi.
2. **Penggunaan Data**: Data Anda digunakan hanya untuk tujuan penyediaan layanan pelacakan presensi dan untuk meningkatkan pengalaman pengguna.
3. **Perlindungan Data**: Kami menerapkan langkah-langkah keamanan yang wajar untuk melindungi data pribadi Anda. Namun, tidak ada metode transmisi data melalui internet yang 100% aman.
4. **Pembagian Data**: Kami tidak menjual atau menyewakan informasi pribadi Anda kepada pihak ketiga. Kami hanya membagikan data kepada mitra atau sesuai dengan kewajiban hukum yang berlaku.
5. **Hak Pengguna**: Anda berhak untuk mengakses, memperbaiki, atau menghapus data pribadi Anda dengan menghubungi kami.

Untuk informasi lebih lanjut, kunjungi situs resmi kami atau hubungi kami secara langsung.
            ''',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
