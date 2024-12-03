import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/response/riwayatpresensi_response_model.dart';
import '../bloc/riwayatpresensi/riwayatpresensi_bloc.dart';
import '../bloc/riwayatpresensi/riwayatpresensi_event.dart'
    as riwayatpresensi_event;
import '../bloc/riwayatpresensi/riwayatpresensi_state.dart'
    as riwayatpresensi_state;
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
  List<RiwayatPresensi> officeHistory = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Fetch riwayat presensi pada inisialisasi
    Future.delayed(Duration.zero, () {
      context
          .read<RiwayatPresensiBloc>()
          .add(riwayatpresensi_event.FetchRiwayatPresensiEvent());
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
      child: BlocBuilder<RiwayatPresensiBloc,
          riwayatpresensi_state.RiwayatPresensiState>(
        builder: (context, state) {
          if (state is riwayatpresensi_state.RiwayatPresensiLoading) {
            return _buildSkeletonLoader();
          } else if (state is riwayatpresensi_state.RiwayatPresensiLoaded) {
            return _buildOfficeHistoryData(state.riwayatPresensiResponse.data);
          } else if (state is riwayatpresensi_state.RiwayatPresensiErrorState) {
            return Center(child: Text(state.error));
          } else {
            return _buildSkeletonLoader();
          }
        },
      ),
    );
  }

  Widget _buildOfficeHistoryData(List<RiwayatPresensi> riwayatPresensi) {
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
                // Apply filter based on selected dates
                setState(() {
                  officeHistory = riwayatPresensi.where((presensi) {
                    DateTime presenceDate =
                        DateTime.parse(presensi.presenceDate);
                    bool isAfterStartDate =
                        startDate == null || presenceDate.isAfter(startDate!);
                    bool isBeforeEndDate =
                        endDate == null || presenceDate.isBefore(endDate!);
                    return isAfterStartDate && isBeforeEndDate;
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
                buildOfficeHistory();
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
              return _buildOfficeHistoryItem(riwayatPresensi);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildOfficeHistoryItem(RiwayatPresensi riwayatPresensi) {
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
                  Text(
                    'Tanggal ' + riwayatPresensi.presenceDate,
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${riwayatPresensi.timeIn} - ${riwayatPresensi.timeOut}',
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    '${riwayatPresensi.presentStatus.presentName}  ${riwayatPresensi.information ?? ''}',
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

// Misalnya di dalam suatu widget (seperti HistoryPage)

void _showEditDialog(RiwayatPresensi riwayatPresensi, BuildContext context) {
  TextEditingController _KeteranganController = TextEditingController();
  _KeteranganController.text = riwayatPresensi.information ?? '';

  // Menyimpan status presensi yang dipilih
  int? selectedStatus = riwayatPresensi.presentId;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Edit Presensi'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                'Edit informasi presensi dengan ID: ${riwayatPresensi.presenceId}'),
            TextField(
              controller: _KeteranganController,
              decoration: InputDecoration(labelText: 'Keterangan'),
            ),
            // Dropdown untuk memilih status presensi
            DropdownButton<int>(
              value: selectedStatus,
              onChanged: (int? newValue) {
                // Update status presensi yang dipilih
                selectedStatus = newValue;
              },
              items: [
                DropdownMenuItem(
                  value: 1, // 1 = Hadir
                  child: Text('Hadir'),
                ),
                DropdownMenuItem(
                  value: 2, // 2 = Sakit
                  child: Text('Sakit'),
                ),
              ],
              hint: Text('Pilih Status Presensi'),
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
              if (selectedStatus == null) {
                // Menampilkan pesan kesalahan jika status belum dipilih
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Pilih status presensi terlebih dahulu')),
                );
                return;
              }

              // Pastikan presenceId dan presentId adalah integer
              final presenceId = riwayatPresensi.presenceId; // int
              final updatedKeterangan = _KeteranganController.text;

              // Kirim event update menggunakan Bloc
              context.read<RiwayatPresensiBloc>().add(
                    riwayatpresensi_event.UpdateRiwayatPresensiEvent(
                      presenceId: presenceId,
                      presentId: selectedStatus!, // menggunakan status yang dipilih
                      information: updatedKeterangan,
                    ),
                  );

                  print ('Keterangan: ${riwayatPresensi.information} ${riwayatPresensi.presentId} ${riwayatPresensi.presenceId}');
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
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14.0,
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
                style: const TextStyle(fontSize: 14.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildVisitHistory() {
    return Container(); // Placeholder for "Kunjungan" tab
  }
}
