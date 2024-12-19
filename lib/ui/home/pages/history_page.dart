import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_presensiv3/data/models/response/history_presensi_response_model.dart';
import '../../../core/assets/assets.dart';
import '../../../core/components/components.dart';
import '../../../data/models/response/kunjungan_response_model.dart';
import '../../../data/models/response/riwayatpresensi_response_model.dart';
import '../bloc/history_presensi/history_presensi_bloc.dart';
import '../bloc/kunjungan/kunjungan_bloc.dart';
import 'package:intl/intl.dart'; // Untuk format tanggal
import 'package:shimmer/shimmer.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime? startDate;
  DateTime? endDate;
  late Future<void> _loadDataOfficeFuture;
  List<HistoryBulananPresensi> officeHistory = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Fetch riwayat presensi pada inisialisasi
    Future.delayed(Duration.zero, () {
      context
          .read<HistoryPresensiBloc>().add(const HistoryBulananPresensiEvent.getPresensi());
      context.read<KunjunganBloc>().add(const KunjunganEvent.fetchKunjungan());
    });

    _loadDataOfficeFuture = _loadRiwayatPresensi();
  }

  Future<void> _loadRiwayatPresensi() async {
    setState(() {
      isLoading = true;
    });
    // Simulasi delay untuk loading data
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _selectDate(BuildContext context, {bool isStartDate = true}) async {
  final DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: isStartDate ? (startDate ?? DateTime.now()) : (endDate ?? DateTime.now()),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );
  if (selectedDate != null) {
    setState(() {
      if (isStartDate) {
        startDate = selectedDate;
      } else {
        endDate = selectedDate;
      }
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat'),
        titleTextStyle: const TextStyle(fontWeight: FontWeight.bold),
        backgroundColor: const Color.fromARGB(255, 114, 76, 175),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Harian'),
            Tab(text: 'Kunjungan'),
          ],
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildOfficeHistory(),
          buildVisitHistory(),
        ],
      ),
    );
  }

Widget buildOfficeHistory() {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: BlocBuilder<HistoryPresensiBloc, HistoryBulananPresensiState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(), // Add this line
          success: (message) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message ?? 'Operation Successful')),
              );
            });
            // Meminta data riwayat presensi terbaru
            context.read<HistoryPresensiBloc>().add(const HistoryBulananPresensiEvent.getPresensi());
            return const SizedBox.shrink();
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          loaded: (riwayatPresensi) {
            return _buildOfficeHistoryData(riwayatPresensi);
          },
          error: (message) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message ?? 'Error Occurred')),
              );
            });
            return const SizedBox.shrink();
          },
          empty: () {
            return const Center(child: Text('No data available'));
          },
        );
      },
    ),
  );
}

Widget _buildOfficeHistoryData(List<HistoryBulananPresensi> riwayatPresensi) {
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            child: _buildDateInput('Tanggal Mulai', startDate),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: _buildDateInput('Tanggal Akhir', endDate),
          ),
        ],
      ),
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              // Terapkan filter berdasarkan tanggal yang dipilih
              setState(() {
                officeHistory = riwayatPresensi.where((riwayatPresensi) {
                  final presenceDate = DateTime.parse(riwayatPresensi.presenceDate!);
                  return presenceDate.isAfter(startDate!) && presenceDate.isBefore(endDate!);
                }).toList();
              });
            },
            icon: const Icon(Icons.check_circle),
            label: const Text('Tampilkan'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                isLoading = true;
              });
              _loadRiwayatPresensi();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Refresh'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
      Expanded(
        child: ListView.builder(
          itemCount: officeHistory.length,
          itemBuilder: (context, index) {
            final riwayatPresensi = officeHistory[index];
            // print(riwayatPresensi.presentId?.presentId);
            return _buildOfficeHistoryItem(riwayatPresensi);
          },
        ),
      ),
    ],
  );
}

Widget _buildOfficeHistoryItem(HistoryBulananPresensi riwayatPresensi) {
  
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    elevation: 2,
    margin: const EdgeInsets.symmetric(vertical: 8),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Menampilkan tanggal presensi
                Text(
                  'Tanggal ${riwayatPresensi.presenceDate ?? ''}',
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Menampilkan waktu masuk dan keluar
                Text(
                  '${riwayatPresensi.timeIn ?? ''} - ${riwayatPresensi.timeOut ?? ''}',
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.green,
                  ),
                ),
                // Menampilkan status presensi dan informasi tambahan (jika ada)
                Text(
                  '${riwayatPresensi.presentStatus?.presentName ?? ''}  ${riwayatPresensi.information ?? ''}',
                  style: const TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
          // Tombol Edit
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              _showEditDialog(riwayatPresensi, context);
            },
          ),
        ],
      ),
    ),
  );
}


void _showEditDialog(HistoryBulananPresensi riwayatPresensi, BuildContext context) {
  TextEditingController keteranganController = TextEditingController();
  keteranganController.text = riwayatPresensi.information ?? '';
  
  String selectedStatus = riwayatPresensi.presentId?.toString() ?? '1';  // Default status

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Edit Presensi'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Edit informasi presensi dengan ID: ${riwayatPresensi.presenceId}'),
            TextField(
              controller: keteranganController,
              decoration: InputDecoration(labelText: 'Keterangan'),
            ),
            DropdownButton<String>(
              value: selectedStatus,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  selectedStatus = newValue;  // Update selected status
                }
              },
              items: [
                DropdownMenuItem(value: '1', child: Text('Hadir')),
                DropdownMenuItem(value: '2', child: Text('Sakit')),
                // Anda bisa menambahkan lebih banyak status di sini jika perlu
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              if (selectedStatus.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Pilih status presensi terlebih dahulu')),
                );
                return;
              }

              final updatedPresensi = HistoryBulananPresensi(
                presenceId: riwayatPresensi.presenceId,
                presentId: int.parse(selectedStatus),  // Perbarui status sesuai pilihan
                information: keteranganController.text,
                createdAt: riwayatPresensi.createdAt,
                updatedAt: riwayatPresensi.updatedAt,
              );

              context.read<HistoryPresensiBloc>().add(
                HistoryBulananPresensiEvent.updatePresensi(updatedPresensi),
              );

              Navigator.of(context).pop();
            },
            child: const Text('Simpan'),
          ),
        ],
      );
    },
  );
}




  // Skeleton loader
  Widget _buildSkeletonLoader() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 80,
            color: Colors.grey[300],
            margin: EdgeInsets.symmetric(vertical: 8.0),
          ),
        ),
      ),
    );
  }

  Widget _buildDateInput(String label, DateTime? date) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: const Color.fromARGB(255, 255, 255, 255)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 5),
          GestureDetector(
            onTap: () async {
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: date ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
              );
              if (pickedDate != null && pickedDate != date) {
                setState(() {
                  if (label == 'Tanggal Mulai') {
                    startDate = pickedDate;
                  } else {
                    endDate = pickedDate;
                  }
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Text(
                date == null
                    ? 'Pilih Tanggal'
                    : '${date.day}/${date.month}/${date.year}',
                style: const TextStyle(fontSize: 12.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

Widget buildVisitHistory() {
  return Column(
    children: [
      // Row for start date and end date inputs
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => _selectDate(context, isStartDate: true),
                child: AbsorbPointer(
                  child: TextField(
                    controller: TextEditingController(
                      text: startDate == null
                          ? ''
                          : DateFormat('yyyy-MM-dd').format(startDate!),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Tanggal Mulai',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: GestureDetector(
                onTap: () => _selectDate(context, isStartDate: false),
                child: AbsorbPointer(
                  child: TextField(
                    controller: TextEditingController(
                      text: endDate == null
                          ? ''
                          : DateFormat('yyyy-MM-dd').format(endDate!),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Tanggal Akhir',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),

      // Display visit history based on date filters
      BlocBuilder<KunjunganBloc, KunjunganState>(
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
                    'Saat ini Riwayat Kunjungan Kosong',
                    textAlign: TextAlign.center,
                  ),
                  const SpaceHeight(100.0),
                ],
              );
            },
            loaded: (data) {
              final kunjunganList = data.kunjungan ?? [];

              // Filter data based on start and end dates
              List<Kunjungan> filteredData = kunjunganList.where((kunjungan) {
                DateTime kunjunganDate = kunjungan.kunjunganTgl != null
                    ? DateTime.parse(kunjungan.kunjunganTgl!)
                    : DateTime.now();
                bool isAfterStartDate =
                    startDate == null || kunjunganDate.isAfter(startDate!);
                bool isBeforeEndDate =
                    endDate == null || kunjunganDate.isBefore(endDate!);
                return isAfterStartDate && isBeforeEndDate;
              }).toList();

              return Expanded(
                child: ListView.separated(
                  itemCount: filteredData.length,
                  itemBuilder: (context, index) {
                    var kunjungan = filteredData[index];
                    return InkWell(
                      onTap: () {
                        // Show dialog with visit details and image
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Date
                                  Text(
                                    kunjungan.kunjunganTgl ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(color: Colors.black),
                                  ),
                                  const SizedBox(height: 10),
                                  // Description
                                  Text(
                                    kunjungan.description ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(color: Colors.black),
                                  ),
                                  const SizedBox(height: 20),
                                  // Image (pictureIn)
                                  if (kunjungan.pictureIn != null &&
                                      kunjungan.pictureIn!.isNotEmpty)
                                    Image.network(
                                      'http://karyawanku.online/storage/kunjungan/${kunjungan.pictureIn}',
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Text(
                                          'Gagal memuat gambar',
                                          style: TextStyle(color: Colors.red),
                                        );
                                      },
                                    )
                                  else
                                    const Text(
                                      'Tidak ada gambar',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Thumbnail Image
                              if (kunjungan.pictureIn != null && kunjungan.pictureIn!.isNotEmpty)
                                Image.network(
                                  'http://karyawanku.online/storage/kunjungan/${kunjungan.pictureIn}',
                                  height: 30,
                                  width: 30,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: 30,
                                      width: 30,
                                      color: Colors.grey,
                                      child: const Icon(
                                        Icons.image_not_supported,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    );
                                  },
                                )
                              else
                                Container(
                                  height: 30,
                                  width: 30,
                                  color: Colors.grey,
                                  child: const Icon(
                                    Icons.image_not_supported,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              const SizedBox(width: 10), // Space between image and text

                              // Text Section
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Date
                                    Text(
                                      kunjungan.kunjunganTgl ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(color: Colors.black),
                                    ),
                                    const SizedBox(height: 10),
                                    // Description
                                    Text(
                                      kunjungan.description ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SpaceHeight(10.0),
                ),
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
    ],
  );
}
}

