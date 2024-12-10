import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../data/datasources/callplan_remote_datasource.dart';
import '../../../data/models/response/callplan_response_model.dart';

class CallPlanPage extends StatefulWidget {
  const CallPlanPage({super.key});

  @override
  State<CallPlanPage> createState() => _CallPlanPageState();
}

class _CallPlanPageState extends State<CallPlanPage> {
  
  List<CallPlanModel> callPlans = [];
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
    fetchCallPlans();
  }

  // Fungsi untuk memformat tanggal
  String? formatDate(DateTime? date) {
    if (date == null) return null;
    return DateFormat('yyyy-MM-dd').format(date);
  }

  // Fungsi untuk mengambil data Call Plans dari API
Future<void> fetchCallPlans() async {
  try {
    String? startDateString = formatDate(startDate);
    String? endDateString = formatDate(endDate);

    if (startDateString != null && endDateString != null) {
      List<CallPlanModel> plans = await CallPlanDataSource().loadCallPlans(
        startDateString,
        endDateString,
      );
      setState(() {
        callPlans = plans;
      });
    } else {
      // Handle the case where startDate or endDate is null
      print('Error: start date or end date is null');
    }
  } catch (e) {
    // Handle error
    print('Error fetching call plans: $e');
  }
}

  // Fungsi untuk menampilkan data yang difilter berdasarkan tanggal
  List<CallPlanModel> filterCallPlans() {
    if (startDate == null || endDate == null) {
      return callPlans;
    }
    return callPlans.where((plan) {
      DateTime planDate = DateFormat('yyyy-MM-dd').parse(plan.tanggalCp);
      return planDate.isAfter(startDate!.subtract(const Duration(days: 1))) &&
          planDate.isBefore(endDate!.add(const Duration(days: 1)));
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
                Expanded(
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Tanggal Sampai',
                      hintText: 'Tanggal Sampai',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: fetchCallPlans,
                  child: const Text('Tampilkan'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 114, 76, 175),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      startDate = null;
                      endDate = null;
                    });
                    fetchCallPlans();
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
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filterCallPlans().length,
                itemBuilder: (context, index) {
                  final plan = filterCallPlans()[index];
                  return Card(
                    child: ListTile(
                      title: Text(plan.namaOutlet),
                      subtitle: Text(plan.tanggalCp),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            color: Colors.green,
                            onPressed: () async {
                              final updatedPlan = CallPlanModel(
                                callplanId: plan.callplanId,
                                employeesId: plan.employeesId,
                                tanggalCp: plan.tanggalCp,
                                namaOutlet: 'Updated Outlet',
                                description: plan.description,
                                createdAt: plan.createdAt,
                                updatedAt: DateTime.now().toIso8601String(),
                              );
                              await CallPlanDataSource().updateCallPlan(updatedPlan);
                              fetchCallPlans();
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () async {
                              await CallPlanDataSource().deleteCallPlan(plan.callplanId);
                              fetchCallPlans();
                            },
                          ),
                        ],
                      ),
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
}
