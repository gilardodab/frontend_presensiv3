import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_presensiv3/data/models/response/kunjungan_response_model.dart';
import 'package:frontend_presensiv3/ui/home/pages/presensi.dart';

import '../../../core/core.dart';
import '../bloc/kunjungan/kunjungan_bloc.dart';

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
              print("A");
              return const Center(
                child: Text("A"),
              );
            },
            error: (message) {
              print("message: $message");
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
                  print("kunjungan: $kunjungan");
                  return InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: SingleChildScrollView(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: kunjungan.kunjunganTgl,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          color: Colors.black,
                                        ),//
                                    
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
                                    text: kunjungan.description,
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
                                Navigator.pop(context); // Menutup dialog tanpa melakukan aksi
                              },
                              child: const Text('Batal'),
                            ),
                            // Tombol "Masuk"
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 37, 197, 122),
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {
                                // Lakukan aksi untuk tombol Masuk
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const AttendancePage()),
                                  );
                                // Aksi lain yang ingin dilakukan ketika tombol Masuk ditekan
                                print("Masuk ke kunjungan: ${kunjungan.kunjunganTgl}");
                              },
                              child: const Text('Masuk'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          maxLines: 5,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: kunjungan.kunjunganTgl,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
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
                                text: kunjungan.description,
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
                                text: kunjungan.statusKunjungan,
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
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SpaceHeight(10.0),
                itemCount: length,
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    ),
    bottomNavigationBar: Container(
      width: double.infinity, // Lebar penuh
      padding: const EdgeInsets.all(12.0),
      child: ElevatedButton(
        onPressed: () {
          // Aksi untuk tombol "Diluar Callplan"
          print("Diluar Callplan ditekan");
                  Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AttendancePage()),
        );
        },
        style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 235, 70, 125),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
