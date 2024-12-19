import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_presensiv3/ui/home/pages/checkinkunjungan_page.dart';
import 'package:shimmer/shimmer.dart';
import 'package:frontend_presensiv3/data/models/response/kunjungan_response_model.dart';
import 'package:frontend_presensiv3/ui/home/pages/presensi.dart';

import '../../../core/core.dart';
import '../bloc/kunjungan/kunjungan_bloc.dart';
import 'selfie_kunjungan.dart';
import 'unplan_kunjungan.dart';

class KunjunganPage extends StatefulWidget {
  const KunjunganPage({super.key});

  @override
  State<KunjunganPage> createState() => _KunjunganPageState();
}

class _KunjunganPageState extends State<KunjunganPage> {
  @override
  void initState() {
    // Fetch Kunjungan data when the page is initialized
    context.read<KunjunganBloc>().add(const KunjunganEvent.fetchKunjungan());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Jadwal Kunjungan'),
        titleTextStyle: const TextStyle(fontWeight: FontWeight.bold),
        backgroundColor: const Color.fromARGB(255, 114, 76, 175),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: BlocBuilder<KunjunganBloc, KunjunganState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return const Center(
                  child: Text("Terjadi kesalahan."),
                );
              },
              error: (message) {
                return Center(
                  child: Text(message),
                );
              },
              empty: () {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.images.emptyState.image(),
                    const Text(
                      'Saat ini Jadwal kosong. Anda akan melihat Jadwal Kunjungan pada bagian ini',
                      textAlign: TextAlign.center,
                    ),
                    const SpaceHeight(100.0),
                  ],
                );
              },
              loaded: (data) {
                final length = data.kunjungan!.length;
                return ListView.separated(
                  itemBuilder: (context, index) {
                    var kunjungan = data.kunjungan![index];
                    print(kunjungan.callplan?.callplanId);
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              maxLines: 5,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        "${kunjungan.timeIn??''} ${kunjungan.kunjunganTgl} - ${kunjungan.statusKunjungan}  ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          color: Colors.black,
                                        ),
                                  ),
                                  TextSpan(
                                    text: '\n\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          color: Colors.black,
                                        ),
                                  ),
                                  TextSpan(
                                    text:
                                        "${kunjungan.callplan?.namaOutlet ?? ''} - ${kunjungan.description ?? 'Proggress Kosong'}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          color: Colors.black,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                                height:
                                    5), // Space between text and "Lihat Detail"
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // Aksi ketika "Lihat Detail" ditekan, tampilkan dialog
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        content: SingleChildScrollView(
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                      '${kunjungan.kunjunganId} - ${kunjungan.kunjunganTgl}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge
                                                      ?.copyWith(
                                                        color: Colors.black,
                                                      ),
                                                ),
                                                TextSpan(
                                                  text: '\n\n',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge
                                                      ?.copyWith(
                                                        color: Colors.black,
                                                      ),
                                                ),
                                                TextSpan(
                                                  text: kunjungan.callplan?.namaOutlet,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall
                                                      ?.copyWith(
                                                        color: Colors.black,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        actions: [
                                          // Tombol "Batal"
                                          TextButton(
                                            onPressed: () {
                                              // Menutup dialog tanpa aksi lebih lanjut
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Batal'),
                                          ), // Tombol "Masuk"
                                          TextButton(
                                            onPressed: () {
                                              // Menutup dialog
                                              Navigator.pop(context);

                                              // Membuka halaman baru (CheckinkunjunganPage) dan mengirimkan kunjunganId
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      CheckinkunjunganPage(
                                                    kunjunganId:
                                                        kunjungan.kunjunganId,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: const Text('Masuk'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Lihat Detail',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SpaceHeight(10.0),
                  itemCount: length,
                );
              },
              loading: () => ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 16.0,
                              width: double.infinity,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 8.0),
                            Container(
                              height: 16.0,
                              width: 150.0,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 8.0),
                            Container(
                              height: 16.0,
                              width: 100.0,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(25.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UnplanKunjungan()),
            );
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 235, 70, 125),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Diluar Callplan',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
