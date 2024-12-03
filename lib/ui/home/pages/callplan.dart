import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Untuk memformat tanggal

class CallPlanPage extends StatefulWidget {
  const CallPlanPage({super.key});

  @override
  State<CallPlanPage> createState() => _CallPlanPageState();
}

class _CallPlanPageState extends State<CallPlanPage> {
  // Data dummy untuk Call Plans
  List<Map<String, String>> callPlans = [
    {"id": "1", "name": "Jakarta", "date": "2024-12-01", "status": "Belum Selesai"},
    {"id": "2", "name": "Yogyakarta", "date": "2024-12-05", "status": "Selesai"},
    {"id": "3", "name": "Jawa Timur", "date": "2024-12-08", "status": "Belum Selesai"},
  ];

  DateTime? startDate;
  DateTime? endDate;

  // Fungsi untuk memformat tanggal
  String? formatDate(DateTime? date) {
    if (date == null) return null;
    return DateFormat('yyyy-MM-dd').format(date);
  }

  // Fungsi untuk menampilkan data yang difilter berdasarkan tanggal
  List<Map<String, String>> filterCallPlans() {
    if (startDate == null || endDate == null) {
      return callPlans;
    }
    return callPlans.where((plan) {
      DateTime planDate = DateFormat('yyyy-MM-dd').parse(plan['date']!);
      return planDate.isAfter(startDate!.subtract(Duration(days: 1))) &&
          planDate.isBefore(endDate!.add(Duration(days: 1)));
    }).toList();
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
        title: const Text('Call Plan'),
        titleTextStyle: const TextStyle(fontWeight: FontWeight.bold),
        backgroundColor: const Color.fromARGB(255, 114, 76, 175),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input untuk tanggal mulai
            Row(
              children: [
                Expanded(
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Tanggal Mulai',
                      hintText: 'Pilih Tanggal Mulai',
                      border: OutlineInputBorder(),
                    ),
                    controller: TextEditingController(
                        text: formatDate(startDate)),
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
                    decoration: InputDecoration(
                      labelText: 'Tanggal Sampai',
                      hintText: 'Tanggal Sampai',
                      border: OutlineInputBorder(),
                    ),
                    controller: TextEditingController(
                        text: formatDate(endDate)),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Tombol Tampilkan
                  ElevatedButton(
                    onPressed: () {
                      setState(() {});
                    },
                    child: const Text('Tampilkan'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 114, 76, 175),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16), // Spasi antara Tombol Tampilkan dan Tombol Refresh

                  // Tombol Refresh
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        startDate = null;
                        endDate = null;
                      });
                    },
                    child: const Text('Refresh'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 114, 76, 175),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16), // Spasi antara Tombol Refresh dan Tombol Tambah

                  // Tombol Tambah
                  ElevatedButton(
                    onPressed: () {
                      // Implementasikan logika untuk menambah data
                      showDialog(context: context, builder: (context) => AlertDialog(
                        title: const Text('Tambah Call Plan'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              decoration: const InputDecoration(labelText: 'Nama'),
                              onChanged: (value) {
                                // Implementasikan logika untuk menyimpan data
                                setState(() {
                                  callPlans.add({
                                    "id": (callPlans.length + 1).toString(),
                                    "name": value,
                                    "date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
                                    "status": "Belum Selesai",
                                  });
                                });
                              },
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            child: const Text('Batal'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          TextButton(
                            child: const Text('Simpan'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ));
                      // setState(() {
                      //   callPlans.add({
                      //     "id": (callPlans.length + 1).toString(),
                      //     "name": "Jakarta",
                      //     "date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
                      //     "status": "Belum Selesai",
                      //   });
                      // });
                    },
                    child: const Text('Tambah'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 114, 76, 175),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 16),
            // Untuk menampilkan data Call Plans menggunakan card
            Expanded(
              child: ListView.builder(
                itemCount: filterCallPlans().length,
                itemBuilder: (context, index) {
                  final plan = filterCallPlans()[index];
                  return Card(
                    child: ListTile(
                      title: Text(plan['name']!),
                      subtitle: Text(plan['date']!),
                      // trailing: Text(plan['status']!),
                          
                      //button delete 
                      trailing:
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            color: Colors.green,
                            onPressed: () {
                              setState(() {
                                _editData(context, plan);
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () {
                              showDialog(context: 
                              context, builder: (context) => AlertDialog(
                                title: const Text('Hapus Call Plan'),
                                //with name
                                content: Text('Apakah Anda yakin ingin menghapus Call Plan ini?' ' ' '(${plan['name']})'),
                                actions: [
                                  TextButton(
                                    child: const Text('Batal'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Hapus'),
                                    onPressed: () {
                                      setState(() {
                                        callPlans.remove(plan);
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                              );  
                              // setState(() {
                              //   callPlans.remove(plan);
                              // });
                            },
                          ),
                            ],
                      ),
                      onTap: () {
                        // Menampilkan modal untuk edit data
                        // _editData(context, plan);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk menampilkan modal edit
  void _editData(BuildContext context, Map<String, String> plan) {
    final nameController = TextEditingController(text: plan['name']);
    // final dateController = TextEditingController(text: plan['date']);
    //input tanggalcpicker 
    final dateController = TextEditingController(text: plan['date']);
    final statusController = TextEditingController(text: plan['status']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Call Plan'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(labelText: 'Date'),
                ),
                TextField(
                  controller: statusController,
                  decoration: const InputDecoration(labelText: 'Status'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Membatalkan perubahan dan menutup dialog
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Update data call plan di list
                setState(() {
                  plan['name'] = nameController.text;
                  plan['date'] = dateController.text;
                  plan['status'] = statusController.text;
                });
                // Menutup dialog setelah menyimpan perubahan
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
