import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/assets/assets.dart';
import '../../../core/components/components.dart';
import '../../../data/models/response/cuti_response_model.dart';
import '../bloc/cuti/cuti_bloc.dart';

class CutiPage extends StatefulWidget {
  const CutiPage({super.key});

  @override
  State<CutiPage> createState() => _CutiPageState();
}

class _CutiPageState extends State<CutiPage> {
  DateTime? startDate;
  DateTime? endDate;
  String? cutiDescription = '';
  String cutiType = 'Sakit';
  bool isLoading = false;
  // Daftar riwayat cuti yang didapat dari API
  List<Cuti> leaveHistory = [];

  @override
  void initState() {
    super.initState();
    // Fetch data on init
    _refreshData();
    context.read<CutiBloc>().add(const CutiEvent.fetchCutiEventBulan());
  }

  // Fungsi untuk memformat tanggal
  String formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('yyyy-MM-dd').format(date); // Use MySQL format (yyyy-MM-dd)
  }

  // Mendengarkan perubahan state dari CutiBloc untuk update leaveHistory
  // void _onCutiStateChange(BuildContext context, CutiState state) {
  //   if (state is CutiLoadedState) {
  //     setState(() {
  //       leaveHistory = state.cutiList;
  //     });
  //   } else if (state is CutiSuccessState) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
  //   } else if (state is CutiErrorState) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage), backgroundColor: Colors.red));
  //   }
  // }
  Future<void> _refreshData() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    context.read<CutiBloc>().add(const CutiEvent.fetchCutiEventBulan());
    setState(() {
      isLoading = false;
    });
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
        title: const Text('Permohonan Cuti'),
        backgroundColor: const Color.fromARGB(255, 114, 76, 175),
        titleTextStyle: const TextStyle(fontWeight: FontWeight.bold),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            color: Colors.white,
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(leaveHistory),
                query: '',
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
      onRefresh: _refreshData,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tombol Ajukan Cuti
            const SizedBox(height: 16),
            // Daftar riwayat cuti
            Expanded(
              child: BlocBuilder<CutiBloc, CutiState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    added: (message) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(message)),
                        );
                      });

                      context
                          .read<CutiBloc>()
                          .add(const CutiEvent.fetchCutiEventBulan());
                      return const SizedBox.shrink();
                    },
                    success: (message) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(message)),
                        );
                      });

                      context
                          .read<CutiBloc>()
                          .add(const CutiEvent.fetchCutiEventBulan());
                      return const SizedBox.shrink();
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    loaded: (cuti) {
                      if (cuti != null) {
                        leaveHistory = cuti;
                      }
                      return ListView.builder(
                        itemCount: leaveHistory.isEmpty ? 0 : leaveHistory.length,
                        itemBuilder: (context, index) {
                          final leave = leaveHistory[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 5,
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16.0),
                              title: Text(
                                leave.cutyDescription ?? 'No Description',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Cuti: ${leave.cutyStart} s/d ${leave.cutyEnd}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Text(
                                        'Total: ${leave.cutyTotal}',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      const SizedBox(width: 8),
                                      _getCutiStatusIcon(leave.cutyStatus ?? '0'),
                                    ],
                                  ),
                                ],
                              ),
                              onTap: () {
                                _showEditDeleteDialog(leave);
                              },
                            ),
                          );
                        },
                      );
                    },
                    error: (message) => Center(child: Text(message)),
                    empty: () {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Spacer(),
                          Assets.images.cutipng.image(height: 200),
                          const SpaceHeight(50.0),
                          const Text(
                            'Belum Ada Cuti',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SpaceHeight(30.0),
                          const Text(
                            'Pengajuan cuti hanya bisa dilakukan jika diajukan paling lambat 7 hari sebelum tanggal mulai cuti.',
                            textAlign: TextAlign.center,
                          ),
                          const Spacer(),
                          // Button.filled(
                          //   onPressed: () => context.pop(),
                          //   label: 'Back Home',
                          // ),
                        ],
                      );
                    },
                    orElse: () => const SizedBox.shrink(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 114, 76, 175),
        child: const Icon(Icons.add, color: Colors.white),
        
        onPressed: _showAddCutiDialog,
      ),
    );
  }


  //
    Widget _getCutiStatusIcon(String status) {
    switch (status) {
      case '1': // Status 1 (Cuti Disetujui)
        return const Icon(Icons.check_circle, color: Colors.green);
      case '3': // Status 2 (Cuti Ditunda)
        return const Icon(Icons.hourglass_empty, color: Colors.orange);
      case '2': // Status 3 (Cuti Ditolak)
        return const Icon(Icons.close, color: Colors.red);
      default:
        return const Icon(Icons.help, color: Colors.grey); // Default icon for unknown status
    }
  }
  void _showAddCutiDialog() {
    TextEditingController cutyStartController = TextEditingController();
    TextEditingController cutyEndController = TextEditingController();
    TextEditingController cutyTotalController = TextEditingController();
    TextEditingController dateWorkController = TextEditingController();
    TextEditingController cutyDescriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Tambah Call Plan',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: cutyDescriptionController,
                decoration: const InputDecoration(labelText: 'Alasan Cuti'),
                //style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
              ),
              GestureDetector(
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2101),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      cutyStartController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
                    });
                  }
                },
                child: AbsorbPointer(
                  child: TextField(
                    controller: cutyStartController,
                    decoration: const InputDecoration(labelText: 'Tanggal Mulai'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2101),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      cutyEndController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
                    });
                  }
                },
                child: AbsorbPointer(
                  child: TextField(
                    controller: cutyEndController,
                    decoration: const InputDecoration(labelText: 'Tanggal Sampai'),
                  ),
                ),
              ),
               GestureDetector(
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2101),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      dateWorkController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
                    });
                  }
                },
                child: AbsorbPointer(
                  child: TextField(
                    controller: dateWorkController,
                    decoration: const InputDecoration(labelText: 'Tanggal Mulai Bekerja'),
                  ),
                ),
              ),
              TextField(
                controller: cutyTotalController,
                decoration: const InputDecoration(labelText: 'Total Cuti'),
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final newCuti = Cuti(
                  cutyDescription: cutyDescriptionController.text,
                  cutyStart: cutyStartController.text,
                  cutyEnd: cutyEndController.text,
                  dateWork: dateWorkController.text,
                  cutyTotal: int.parse(cutyTotalController.text),
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                );
                // Trigger the addCallPlan event
                print(newCuti);
                context
                    .read<CutiBloc>()
                    .add(CutiEvent.addCutiEvent(newCuti));
                print(newCuti);
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Simpan'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
          ],
        );
      },
    );
  }

  // Show Edit/Delete dialog for Cuti item
  void _showEditDeleteDialog(Cuti cuti) {
    TextEditingController cutiDescriptionController =
        TextEditingController (text: cuti.cutyDescription);
    TextEditingController cutyStartController =
        TextEditingController(text: cuti.cutyStart);
    TextEditingController cutyEndController =
        TextEditingController(text: cuti.cutyEnd);
    TextEditingController dateWorkController =
        TextEditingController(text: cuti.dateWork);
    TextEditingController cutyTotalController =
        TextEditingController(text: cuti.cutyTotal.toString());

// Function untuk memunculkan date picker
    Future<void> _selectDate(
        BuildContext context, TextEditingController controller) async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );

      if (pickedDate != null) {
        // Mengonversi tanggal ke format yang diinginkan (yyyy-MM-dd)
        String formattedDate = DateFormat('d-M-y')
            .format(pickedDate); // Ganti format ke yyyy-MM-dd
        controller.text =
            formattedDate; // Menetapkan nilai tanggal yang dipilih ke controller
      }
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Action for ${cuti.cutyDescription}'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              // Input untuk deskripsi cuti
              TextField(
                controller: cutiDescriptionController,
                decoration: const InputDecoration(labelText: 'Alasan Cuti'),
              ),
              // Input untuk tanggal mulai cuti
              TextField(
                controller: cutyStartController,
                decoration: const InputDecoration(labelText: 'Tanggal Mulai'),
                readOnly:
                    true, // Menandakan input hanya bisa dengan memilih dari date picker
                onTap: () {
                  _selectDate(context,
                      cutyStartController); // Panggil date picker saat tapped
                },
              ),
              // Input untuk tanggal selesai cuti
              TextField(
                controller: cutyEndController,
                decoration: const InputDecoration(labelText: 'Tanggal Selesai'),
                readOnly:
                    true, // Menandakan input hanya bisa dengan memilih dari date picker
                onTap: () {
                  _selectDate(context,
                      cutyEndController); // Panggil date picker saat tapped
                },
              ),
              // Input untuk tanggal kerja
              TextField(
                controller: dateWorkController,
                decoration: const InputDecoration(labelText: 'Tanggal Kerja'),
                readOnly:
                    true, // Menandakan input hanya bisa dengan memilih dari date picker
                onTap: () {
                  _selectDate(context,
                      dateWorkController); // Panggil date picker saat tapped
                },
              ),
              // Input untuk total cuti
              TextField(
                controller: cutyTotalController,
                decoration: const InputDecoration(labelText: 'Total Cuti'),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Handle Edit action
              final Updatecuti = Cuti(
                cutyId: cuti.cutyId,
                cutyDescription: cutiDescriptionController.text,
                cutyStart: cutyStartController.text,
                cutyEnd: cutyEndController.text,
                dateWork: dateWorkController.text,
                cutyTotal: int.parse(cutyTotalController.text),
              );
              context
                  .read<CutiBloc>()
                  .add(CutiEvent.editCutiEvent(Updatecuti));
              Navigator.pop(context);
            },
            child: const Text('Edit Cuti'),
          ),
          TextButton(
            onPressed: () {
              // Handle Delete action
              final deleteCuti = Cuti(cutyId: cuti.cutyId);
              context
                  .read<CutiBloc>()
                  .add(CutiEvent.deleteCutiEvent(deleteCuti));
              Navigator.pop(context);
            },
            child: const Text('Delete Cuti'),
          ),
        ],
      ),
    );
  }
}

// CustomSearchDelegate for search functionality
class CustomSearchDelegate extends SearchDelegate {
  final List<Cuti> leaveHistory;

  CustomSearchDelegate(this.leaveHistory);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = leaveHistory
        .where((leave) =>
            leave.cutyDescription?.toLowerCase().contains(query.toLowerCase()) ??
            false)
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final leave = results[index];
        return ListTile(
          title: Text(leave.cutyDescription ?? 'No Description'),
          subtitle: Text('${leave.cutyStart} s/d ${leave.cutyEnd}'),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = leaveHistory
        .where((leave) =>
            leave.cutyDescription?.toLowerCase().contains(query.toLowerCase()) ??
            false)
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final leave = suggestions[index];
        return ListTile(
          title: Text(leave.cutyDescription ?? 'No Description'),
          subtitle: Text('${leave.cutyStart} s/d ${leave.cutyEnd}'),
        );
      },
    );
  }
}
