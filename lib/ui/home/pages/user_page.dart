import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user/user_bloc.dart';
import '../bloc/user/user_event.dart' as user_event; // Alias for user_event
import '../bloc/user/user_state.dart' as user_state; // Alias for user_state

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late TextEditingController phoneController;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController positionController;
  late TextEditingController shiftController;

  @override
  void initState() {
    super.initState();
    // Dispatch the event to fetch user data
    context.read<UserBloc>().add(user_event.FetchUserData());
    // Initialize controllers with default values
    phoneController = TextEditingController();
    nameController = TextEditingController();
    emailController = TextEditingController();
    positionController = TextEditingController();
    shiftController = TextEditingController();
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    phoneController.dispose();
    nameController.dispose();
    emailController.dispose();
    positionController.dispose();
    shiftController.dispose();
    super.dispose();
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
        backgroundColor: const Color.fromARGB(255, 114, 76, 175),
        titleTextStyle: const TextStyle(fontWeight: FontWeight.bold),
        title: const Text('Detail Profile'),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<UserBloc, user_state.UserState>(
          builder: (context, state) {
            if (state is user_state.UserLoading) {
              return const Center(child: CircularProgressIndicator()); // Show loading indicator
            } else if (state is user_state.UserDataFetched) {
              // Populate controllers with user data
              phoneController.text = state.userResponse.data?.employeesCode ?? 'N/A';
              nameController.text = state.userResponse.data?.employeesName ?? 'N/A';
              emailController.text = state.userResponse.data?.employeesEmail ?? 'N/A';
              positionController.text = state.userResponse.data?.position?.positionName ?? 'N/A';
              shiftController.text = state.userResponse.data?.shift?.shiftName ?? 'N/A';

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Profile',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    const SizedBox(height: 16.0),
                    _buildProfileField("No. HP", phoneController),
                    _buildProfileField("Nama", nameController),
                    _buildProfileField("Email", emailController),
                    _buildProfileField("Posisi", positionController, enabled: false),
                    _buildProfileField("Shift", shiftController, enabled: false),
                    const SizedBox(height: 16.0),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Save Profile function here if needed
                          _updateProfile(context);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                          foregroundColor: Colors.white,
                          backgroundColor: const Color.fromARGB(255, 114, 76, 175),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text("SIMPAN"),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
              );
            } else if (state is user_state.UserLoadFailure) {
              return Center(child: Text("Error: ${state.error}")); // Show error message
            } else {
              return const Center(child: Text('Unknown state')); // Handle unknown state
            }
          },
        ),
      ),
    );
  }

  Future<void> _updateProfile(BuildContext context) async {
    // Implement your update profile logic here
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(
            Icons.check,
            color: Colors.green,
            size: 50.0,
          ),
          content: const Text(
            'Profile Berhasil!',
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.purple),
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildProfileField(String label, TextEditingController controller, {bool enabled = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8.0),
        TextField(
          controller: controller,
          enabled: enabled,  // Disable the input field if enabled is false
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
