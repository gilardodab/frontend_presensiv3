// callplan_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_presensiv3/core/core.dart';
import 'package:intl/intl.dart';

import '../../../data/models/response/callplan_response_model.dart';
import '../bloc/callplan/callplan_bloc.dart';

class CallPlanPage extends StatefulWidget {
  const CallPlanPage({super.key});

  @override
  State<CallPlanPage> createState() => _CallPlanPageState();
}

class _CallPlanPageState extends State<CallPlanPage> {
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
    context.read<CallPlanBloc>().add(
          const CallPlanEvent.getCallPlanBulan(),
        );
  }

  String? formatDate(DateTime? date) {
    if (date == null) return null;
    return DateFormat('yyyy-MM-dd').format(date);
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
            // Date picker fields for filtering
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
                    controller:
                        TextEditingController(text: formatDate(startDate)),
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
                    decoration: const InputDecoration(
                      labelText: 'Tanggal Sampai',
                      hintText: 'Tanggal Sampai',
                      border: OutlineInputBorder(),
                    ),
                    controller:
                        TextEditingController(text: formatDate(endDate)),
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
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (startDate != null && endDate != null) {
                      context.read<CallPlanBloc>().add(
                            CallPlanEvent.getCallPlan(
                              formatDate(startDate)!,
                              formatDate(endDate)!,
                            ),
                          );
                    } else {
                      context.read<CallPlanBloc>().add(
                            const CallPlanEvent.getCallPlanBulan(),
                          );
                    }
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
                // const SizedBox(width: 5),
                // ElevatedButton(
                //   onPressed: () {
                //     setState(() {
                //       startDate = null;
                //       endDate = null;
                //     });
                //     context.read<CallPlanBloc>().add(
                //           CallPlanEvent.getCallPlan('', ''), // Refresh event
                //         );
                //   },
                //   child: const Text('Refresh'),
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: const Color.fromARGB(255, 114, 76, 175),
                //     foregroundColor: Colors.white,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //   ),
                // ),
                const SizedBox(width: 5),
                ElevatedButton(
                  onPressed: _showAddCallPlanDialog,
                  child: const Text('Tambah'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 76, 175, 142),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Using BlocBuilder to show different states
            Expanded(
              child: BlocBuilder<CallPlanBloc, CallPlanState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    added: (message) {
                      // Show SnackBar when a new call plan is added
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(message)), // Display the added message
                        );
                      });

                      // Reload the data after adding a new call plan
                      context.read<CallPlanBloc>().add(const CallPlanEvent.getCallPlanBulan());

                      return const SizedBox.shrink(); // Empty widget (you can customize this)
                    },
                    success: (message) {
                      // Show SnackBar when the operation is successful
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(message)),
                        );
                      });

                      // Reload the data after success
                      context.read<CallPlanBloc>().add(const CallPlanEvent.getCallPlanBulan());

                      return const SizedBox.shrink(); // Empty widget (you can customize this)
                    },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    loaded: (callPlans) {
                      // Show the updated list of call plans
                      return ListView.builder(
                        itemCount: callPlans.length,
                        itemBuilder: (context, index) {
                          final callPlan = callPlans[index];
                          return ListTile(
                            title: Text(callPlan.namaOutlet ?? 'Unknown'),
                            subtitle: Text(callPlan.tanggalCp ?? 'Unknown'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () => _editCallPlan(callPlan),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => _deleteCallPlan(callPlan),
                                ),
                              ],
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
                          Assets.images.callplanpng.image(height: 200),
                          const SpaceHeight(50.0),
                          const Text(
                            'Belum Ada Callplan DiPeriode Ini',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SpaceHeight(30.0),
                          const Text(
                            'Silahkan Membuat callplan terlebih dahulu pada akhir atau awal bulan',
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
                    orElse: () => const Center(child: Text('Select a date range')), // Default case for unhandled states
                  );
                },
              ),
            )


          ],
        ),
      ),
    );
  }

  void _showAddCallPlanDialog() {
    TextEditingController namaOutletController = TextEditingController();
    TextEditingController tglCallplanController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tambah Call Plan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14), textAlign: TextAlign.center),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: namaOutletController,
                decoration: const InputDecoration(labelText: 'Nama Outlet'),
              ),
              GestureDetector(
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.parse(DateTime.now().toString()),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2101),
                  );

                  if (selectedDate != null) {
                    // Format the selected date to 'd-M-y'
                    final formattedDate =
                        DateFormat('d-M-y').format(selectedDate);
                    tglCallplanController.text =
                        formattedDate; // Update the controller with formatted date
                  }
                },
                child: AbsorbPointer(
                  child: TextField(
                    controller: tglCallplanController,
                    decoration: const InputDecoration(labelText: 'Tanggal'),
                  ),
                ),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Keterangan'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                final newCallPlan = CallPlan(
                  tanggalCp: tglCallplanController.text,
                  namaOutlet: namaOutletController.text,
                  description: descriptionController.text,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                );
                // Trigger the addCallPlan event
                print(newCallPlan);
                context
                    .read<CallPlanBloc>()
                    .add(CallPlanEvent.addCallPlan(newCallPlan));
                print(newCallPlan);
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _editCallPlan(CallPlan callPlan) {
    TextEditingController namaOutletController =
        TextEditingController(text: callPlan.namaOutlet);
    TextEditingController descriptionController =
        TextEditingController(text: callPlan.description);
    TextEditingController tglCallplanController =
        TextEditingController(text: callPlan.tanggalCp);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Call Plan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center), // Add a title to the dialog (optional,),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: namaOutletController,
                decoration: const InputDecoration(labelText: 'Nama Outlet'),
              ),
              GestureDetector(
                onTap: () async {
                  // Show date picker when the TextField is tapped
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.parse(
                        callPlan.tanggalCp ?? DateTime.now().toString()),
                    firstDate: DateTime(2020), // Minimum date selectable
                    lastDate: DateTime(2101), // Maximum date selectable
                  );

                  if (selectedDate != null) {
                    // Format the selected date to 'd-M-y'
                    final formattedDate =
                        DateFormat('d-M-y').format(selectedDate);
                    tglCallplanController.text =
                        formattedDate; // Update the controller with formatted date
                  }
                },
                child: AbsorbPointer(
                  // Prevent the user from typing in the text field
                  child: TextField(
                    controller: tglCallplanController,
                    decoration: const InputDecoration(labelText: 'Tanggal'),
                  ),
                ),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Keterangan'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
                        TextButton(
              onPressed: () {
                // Create a new CallPlan with updated values from the text controllers
                final updatedCallPlan = CallPlan(
                  callplanId: callPlan.callplanId, // keep the original ID
                  tanggalCp: tglCallplanController.text, // use the updated date
                  namaOutlet:
                      namaOutletController.text, // use the updated outlet name
                  description:
                      descriptionController.text, // use the updated description
                  createdAt:
                      callPlan.createdAt, // keep the original creation date
                  updatedAt:
                      DateTime.now(), // set the current date as the update time
                );
                // Pass the updated call plan to the Bloc for updating
                context
                    .read<CallPlanBloc>()
                    .add(CallPlanEvent.updateCallPlan(updatedCallPlan));

                // Close the dialog or pop the screen
                Navigator.pop(context);
              },
              child: const Text('Ubah'),
            ),
          ],
        );
      },
    );
  }

  void _deleteCallPlan(CallPlan callPlan) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14), textAlign: TextAlign.center),
          content:
              const Text('Apakah Anda yakin ingin menghapus call plan ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tidak'),
            ),
            TextButton(
              onPressed: () {
                final deleteCallPlan = CallPlan(
                  callplanId: callPlan.callplanId, // keep the original ID
                  // set the current date as the update time
                );
                context
                    .read<CallPlanBloc>()
                    .add(CallPlanEvent.deleteCallPlan(deleteCallPlan));
                Navigator.pop(context);
              },
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }
}
