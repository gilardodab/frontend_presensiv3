import 'package:detect_fake_location/detect_fake_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_presensiv3/ui/home/pages/notification_page.dart';
import 'package:frontend_presensiv3/ui/home/pages/presensi.dart';
import 'package:frontend_presensiv3/ui/home/pages/user_page.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/network/network_info.dart';
import '../bloc/presensi/presensi_bloc.dart';
import '../bloc/presensi/presensi_event.dart' as presensi_event;
import '../bloc/presensi/presensi_state.dart' as presensi_state;

import '../bloc/user/user_bloc.dart';
import '../bloc/user/user_event.dart' as user_event; // Alias for user_event
import '../bloc/user/user_state.dart' as user_state; // Alias for user_state

import 'history_page.dart';
import 'cuti_page.dart';
import 'callplan.dart';
import 'kunjungan_page.dart';
import 'scan_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime currentDate = DateTime.now();
  bool isLoading = false;
  bool isOffline = false;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    _refreshData();
    context.read<UserBloc>().add(user_event.FetchUserData());
    context.read<PresensiBloc>().add(presensi_event.FetchPresensiData());
        // Check for fake location on page load
    _checkFakeLocation();
  }
  // Function to check fake location
  Future<void> _checkFakeLocation() async {
                bool isFakeLocation =
                await DetectFakeLocation().detectFakeLocation();
    if (isFakeLocation) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Warning'),
                content: Text('Anda Terdeteksi Menggunakan Lokasi Palsu . ${isFakeLocation ? '' : ' not'}'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
    } else {
      print("No fake location detected.");
    }
  }

  Future<void> _checkConnectivity() async {
    bool isConnected = await NetworkInfo().isConnected;
    setState(() {
      isOffline = !isConnected;
    });
  }

  Future<void> _refreshData() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));
    _checkFakeLocation();
    _photo();
    context.read<PresensiBloc>().add(presensi_event.FetchPresensiData());
    setState(() {
      currentDate = DateTime.now();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = "${currentDate.day}-${currentDate.month}-${currentDate.year}";

    return Scaffold(
      appBar: AppBar(
        title: Text('E-PRESENSI'),
        centerTitle: true,
        titleTextStyle: const TextStyle(fontWeight: FontWeight.bold),
        backgroundColor: const Color.fromARGB(255, 114, 76, 175),
        actions: [
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: IconButton(
              icon: Icon(Icons.notifications),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationPage()),
                );
              },
              tooltip: 'Notifikasi',
            ),
          ),
          // circle image network
          Padding(padding: const EdgeInsets.all(2.0),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserPage()),
              );
            },
            tooltip: 'Profile',
            icon: _photo(),
          ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUserInfo(), //bisa pakai build user profile
                const SizedBox(height: 20),
                _buildDateSection(formattedDate),
                const SizedBox(height: 20),
                _buildGridView(),
                const SizedBox(height: 20),
                _buildPresensiButton(),
                const SizedBox(height: 20),
                _buildPresensiDataTable(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }


Widget _photo() {
  return BlocBuilder<UserBloc, user_state.UserState>(builder: (context, state) {
    if (state is user_state.UserLoading) {
      return _photoShimmerLoader();
    } else if (state is user_state.UserDataFetched) {
      return CircleAvatar(
        radius: 20,  // Ukuran lingkaran
        backgroundColor: const Color.fromARGB(255, 114, 76, 175),
        child: state.userResponse.data != null && 
               state.userResponse.data?.photo != null && 
               state.userResponse.data!.photo!.isNotEmpty
            ? ClipOval(  // Pastikan gambar tetap dalam bentuk bulat
                child: Image.network(
                  'http://karyawanku.online/storage/photos/${state.userResponse.data?.photo}', 
                  fit: BoxFit.cover,  // Agar gambar menutupi seluruh lingkaran
                  width: 30,  // Lebar gambar sesuai dengan ukuran lingkaran
                  height: 30, // Tinggi gambar sesuai dengan ukuran lingkaran
                  errorBuilder: (context, error, stackTrace) => Image.network(
                    'https://via.placeholder.com/150',
                    fit: BoxFit.cover,
                    width: 30,
                    height: 30,
                  ),
                ),
              )
            : Icon(
                Icons.person, 
                size: 20, 
                color: Colors.white
              ),
      );
    } else if (state is user_state.UserLoadFailure) {
      return Text('Error: ${state.error}');
    } else {
      return Text('Loading...');
    }
  });
}


Widget _photoShimmerLoader() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      height: 20,
      width: 20,
      color: Colors.white,
    ),
  );
}

Widget _buildUserProfile() {
    return BlocBuilder<UserBloc, user_state.UserState>(
      builder: (context, state) {
        if (state is user_state.UserLoading) {
          return _nameShimmerLoader();
        } else if (state is user_state.UserDataFetched) {
        return Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: const Color.fromARGB(255, 114, 76, 175),
              backgroundImage: state.userResponse.data?.photo != null && state.userResponse.data!.photo!.isNotEmpty
                  ? NetworkImage('http://karyawanku.online/storage/photos/${state.userResponse.data?.photo}')
                  : null,
                child: state.userResponse.data != null && state.userResponse.data?.photo != null && state.userResponse.data!.photo!.isNotEmpty
                  ? Icon(Icons.person, size: 20, color: Colors.white)
                  : null,
            ),
            SizedBox(width: 9),
            isLoading ? _nameShimmerLoader() : _buildUserInfo(),
          ],
        );
        } else if (state is user_state.UserLoadFailure) {
          return Text('Error: ${state.error}');
        } else {
          return Text('Loading...');
        }
      },
    );
  }

  Widget _buildUserInfo() {
    return BlocBuilder<UserBloc, user_state.UserState>(
      builder: (context, state) {
        if (state is user_state.UserLoading) {
          return _nameShimmerLoader();
        } else if (state is user_state.UserDataFetched) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(state.userResponse.data?.employeesName ?? 'N/A', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text("${state.userResponse.data?.shift?.timeIn ?? 'N/A'} - ${state.userResponse.data?.shift?.timeOut ?? 'N/A'}", style: const TextStyle(fontSize: 10)),
            ],
          );
        } else if (state is user_state.UserLoadFailure) {
          return Text('Error: ${state.error}');
        } else {
          return Text('Loading...');
        }
      },
    );
  }

  Widget _buildDateSection(String formattedDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Hari ini', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        Text(formattedDate, style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 114, 76, 175))),
      ],
    );
  }

  Widget _buildGridView() {
    return isOffline
        ? const Center(child: Text('Tidak Ada Koneksi Internet', style: TextStyle(fontSize: 18, color: Colors.red)))
        : GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              // Define the icons and labels
              //text size label 12
              final icons = [Icons.photo_camera, Icons.work, Icons.event, Icons.person, Icons.assignment, Icons.qr_code_scanner];
              final labels = ['Presensi', 'Kunjungan', 'Cuti', 'Riwayat', 'Callplan', 'Scan'];

              return GestureDetector(
                onTap: () {
                  _navigateToScreen(context, index);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 221, 200, 230),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icons[index], size: 30, color: const Color.fromARGB(255, 114, 76, 175)),
                      Text(labels[index], style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
                    ],
                  ),
                ),
              );
            },
          );
  }

  Widget _buildPresensiButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AttendancePage()),
          );
        },
        child: const Text('Presensi Masuk'),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 50),
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromARGB(255, 114, 76, 175),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildPresensiDataTable() {
    return isLoading
        ? _buildShimmerLoader()
        : BlocBuilder<PresensiBloc, presensi_state.PresensiState>(
            builder: (context, state) {
                          if (state is presensi_state.PresensiLoading) {
                            return _buildShimmerLoader();
                          } else if (state is presensi_state.PresensiLoaded) {
                            return DataTable(
                              columns: const [
                                  DataColumn(label: Text('Tanggal')),
                                  DataColumn(label: Text('Masuk')),
                                  DataColumn(label: Text('Pulang')),
                                ],
                              rows: state.presensiResponse.data?.map((presensi) => DataRow(cells: [
                                    DataCell(Text(presensi.presenceDate ?? 'N/A')),
                                    DataCell(Text(presensi.timeIn ?? 'N/A')),
                                    DataCell(Text(presensi.timeOut ?? 'N/A')),
                                  ])).toList() ?? [],
                            );
                          } else if (state is presensi_state.PresensiError) {
                            return Text('Error: ${state.error}');
                          } else {
                            return const Text('Loading...');
                          }
            },
          );
  }

  Widget _buildShimmerLoader() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 200,
        width: double.infinity,
        color: Colors.white,
      ),
    );
  }

  Widget _nameShimmerLoader() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 15,
        width: 100,
        color: Colors.white,
      ),
    );
  }


  void _navigateToScreen(BuildContext context, int index) {
    // Example navigation based on the index
    switch (index) {
      case 0:
      // presensi
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AttendancePage()),
        );
        break;
      case 1:
      // kunjungan
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const KunjunganPage()),
        );
        break;
      case 2:
      // cuti
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CutiPage()),
        );
        break;
        //history
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HistoryPage()),
        );
        break;
      case 4:
        // callplan
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CallPlanPage()),
        );
        break;
      case 5:
        // kunjungan
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ScanPage()),
        );
        break;
      // case 6:
      //   // scan
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => const ScanPage()),
      //   );
      //   break;
      default:
        break;
    }
  }


}
