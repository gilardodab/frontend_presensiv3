import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../data/models/response/cuti_response_model.dart';
import '../bloc/cuti/cuti_bloc.dart';
import '../bloc/cuti/cuti_event.dart' as cuti_event;
import '../bloc/cuti/cuti_event.dart';
import '../bloc/cuti/cuti_state.dart';

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
  
  // Daftar riwayat cuti yang didapat dari API
  List<Cuti> leaveHistory = [];

  @override
  void initState() {
    super.initState();
    // Fetch data on init
    context.read<CutiBloc>().add(FetchCutiEvent());
  }

  // Fungsi untuk memformat tanggal
  String? formatDate(DateTime? date) {
    if (date == null) return null;
    return DateFormat('yyyy-MM-dd').format(date);
  }

  // Mendengarkan perubahan state dari CutiBloc untuk update leaveHistory
  void _onCutiStateChange(BuildContext context, CutiState state) {
    if (state is CutiLoadedState) {
      setState(() {
        leaveHistory = state.cutiList;
      });
    } else if (state is CutiSuccessState) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
    } else if (state is CutiErrorState) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage), backgroundColor: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CutiBloc, CutiState>(
      listener: _onCutiStateChange,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Permohonan Cuti'),
          backgroundColor: const Color.fromARGB(255, 114, 76, 175),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              color: Colors.white,
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                  query: '',
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Input untuk tanggal mulai dan selesai
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Tanggal Mulai',
                        hintText: 'Pilih Tanggal Mulai',
                        border: OutlineInputBorder(),
                      ),
                      controller: TextEditingController(text: formatDate(startDate)),
                      onTap: () async {
                        final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2101),
                        );
                        if (selectedDate != null) {
                          setState(() {
                            startDate = selectedDate;
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Input untuk tanggal sampai
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Tanggal Selesai',
                        hintText: 'Pilih Tanggal Selesai',
                        border: OutlineInputBorder(),
                      ),
                      controller: TextEditingController(text: formatDate(endDate)),
                      onTap: () async {
                        final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2101),
                        );
                        if (selectedDate != null) {
                          setState(() {
                            endDate = selectedDate;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Tombol Ajukan Cuti
              ElevatedButton(
                onPressed: () {
                  if (startDate != null && endDate != null) {
                    final cuti = Cuti(
                      cutyId: 0,  // assume it's a new cuti
                      employeesId: 1, // Example employee id
                      cutyStart: formatDate(startDate)!,
                      cutyEnd: formatDate(endDate)!,
                      dateWork: formatDate(startDate)!,
                      cutyTotal: 1,  // Example total leave days
                      cutyDescription: cutiDescription!,
                      cutyStatus: 'Pending',  // Default status
                      createdAt: DateTime.now().toIso8601String(),
                      updatedAt: DateTime.now().toIso8601String(),
                      employee: Employee(
                        id: 1,
                        employeeCode: 'EMP123',
                        employeeEmail: 'employee@example.com',
                        employeeName: 'John Doe',
                        positionId: 1,
                        shiftId: 1,
                        buildingId: 1,
                        photo: 'url_to_photo',
                        createdAt: DateTime.now().toIso8601String(),
                        updatedAt: DateTime.now().toIso8601String(),
                      ),
                    );

                    context.read<CutiBloc>().add(cuti_event.AddCutiEvent(cuti));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Tanggal mulai dan selesai wajib diisi')),
                    );
                  }
                },
                child: const Text('Ajukan Cuti'),
              ),
              const SizedBox(height: 16),
              // Daftar riwayat cuti
              Expanded(
                child: ListView.builder(
                  itemCount: leaveHistory.length,
                  itemBuilder: (context, index) {
                    final leave = leaveHistory[index];
                    return ListTile(
                      title: Text(leave.cutyDescription ?? ''),
                      subtitle: Text('Mulai: ${leave.cutyStart} - Selesai: ${leave.cutyEnd}'),
                      trailing: Text(leave.cutyStatus.toString()),
                      onTap: () {
                        // Implement edit or delete functionality here
                        _showEditDeleteDialog(context, leave);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  // Show Edit/Delete dialog for Cuti item
void _showEditDeleteDialog(BuildContext context, Cuti cuti) {
  final descriptionController = TextEditingController(text: cuti.cutyDescription);
  final startDateController = TextEditingController(text: cuti.cutyStart);
  final endDateController = TextEditingController(text: cuti.cutyEnd);
  final dateWorkController = TextEditingController(text: cuti.dateWork);
  final totalController = TextEditingController(text: cuti.cutyTotal.toString());

// Function untuk memunculkan date picker
Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );

  if (pickedDate != null) {
    // Mengonversi tanggal ke format yang diinginkan (yyyy-MM-dd)
    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // Ganti format ke yyyy-MM-dd
    controller.text = formattedDate; // Menetapkan nilai tanggal yang dipilih ke controller
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
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Alasan Cuti'),
            ),
            // Input untuk tanggal mulai cuti
            TextField(
              controller: startDateController,
              decoration: const InputDecoration(labelText: 'Tanggal Mulai'),
              readOnly: true, // Menandakan input hanya bisa dengan memilih dari date picker
              onTap: () {
                _selectDate(context, startDateController); // Panggil date picker saat tapped
              },
            ),
            // Input untuk tanggal selesai cuti
            TextField(
              controller: endDateController,
              decoration: const InputDecoration(labelText: 'Tanggal Selesai'),
              readOnly: true, // Menandakan input hanya bisa dengan memilih dari date picker
              onTap: () {
                _selectDate(context, endDateController); // Panggil date picker saat tapped
              },
            ),
            // Input untuk tanggal kerja
            TextField(
              controller: dateWorkController,
              decoration: const InputDecoration(labelText: 'Tanggal Kerja'),
              readOnly: true, // Menandakan input hanya bisa dengan memilih dari date picker
              onTap: () {
                _selectDate(context, dateWorkController); // Panggil date picker saat tapped
              },
            ),
            // Input untuk total cuti
            TextField(
              controller: totalController,
              decoration: const InputDecoration(labelText: 'Total Cuti'),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Handle Edit action
            context.read<CutiBloc>().add(cuti_event.EditCutiEvent(cuti.cutyId, cuti));
            Navigator.pop(context);
          },
          child: const Text('Edit Cuti'),
        ),
        TextButton(
          onPressed: () {
            // Handle Delete action
            context.read<CutiBloc>().add(cuti_event.DeleteCutiEvent(cuti.cutyId));
            Navigator.pop(context);
          },
          child: const Text('Delete Cuti'),
        ),
      ],
    ),
  );
}
}

class CustomSearchDelegate extends SearchDelegate<String> {
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
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView(
      children: [
        // Hasil pencarian cuti berdasarkan query
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        // Saran pencarian cuti berdasarkan query
      ],
    );
  }
}
