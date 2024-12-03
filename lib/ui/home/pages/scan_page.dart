import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String? scanResult;
  DateTime scanDateTime = DateTime.now();
  bool isScanTabActive = true;  // Untuk memeriksa tab yang aktif
  double? latitude;
  double? longitude;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Dapatkan lokasi saat halaman dimuat
  }

  void dispose() {
    super.dispose();
    // layanan GPS diaktifkan

    // Geolocator.openLocationSettings();
  }

  // Fungsi untuk mendapatkan lokasi GPS
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Memeriksa apakah layanan GPS diaktifkan
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        latitude = null;
        longitude = null;
      });
      return;
    }

    // Memeriksa izin lokasi
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    // Mendapatkan posisi saat ini
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });
  }

  // Fungsi untuk melakukan pemindaian QR code
  Future<void> _scanQRCode() async {
    try {
      var result = await BarcodeScanner.scan();
      setState(() {
        scanResult = result.rawContent;
        scanDateTime = DateTime.now();
      });
    } catch (e) {
      setState(() {
        scanResult = 'Scan dibatalkan';
      });
    }
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
        title: const Text('Scan Alat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tab Bar (Scan dan Riwayat)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTabItem('Scan', isScanTabActive),
                _buildTabItem('Riwayat', !isScanTabActive),
              ],
            ),
            const SizedBox(height: 16.0),

            // Konten berdasarkan tab aktif
            if (isScanTabActive) ...[
              // Kartu Informasi Pemindaian
              _buildScanCard(),
            ] else ...[
              // Kartu Riwayat dengan Lokasi
              _buildHistoryCard(),
            ],

            const SizedBox(height: 16.0),
            // Tombol untuk Memulai Pemindaian QR Code
            SizedBox(
              width: double.infinity, // Make the button full-width
              child: ElevatedButton.icon(
                onPressed: _scanQRCode,
                icon: const Icon(Icons.qr_code_scanner),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                label: const Text('Pemindaian QR Code'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membangun item tab bar
  Widget _buildTabItem(String title, bool isActive) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isScanTabActive = (title == 'Scan');
        });
      },
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: isActive ? Colors.purple : Colors.black54,
            ),
          ),
          if (isActive)
            Container(
              margin: const EdgeInsets.only(top: 4.0),
              height: 3.0,
              width: 40.0,
              color: Colors.purple,
            ),
        ],
      ),
    );
  }

  // Widget untuk kartu informasi pemindaian
  Widget _buildScanCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ikon dan Tanggal/Waktu Pemindaian
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Menampilkan Lokasi
                  const Text(
                    'Lokasi Anda:',
                    style: TextStyle(fontSize: 14.0, color: Colors.black54),
                  ),
                  const SizedBox(height: 4.0),
                  latitude != null && longitude != null
                      ? Text(
                          'Lokasi: ${latitude?.toStringAsFixed(4)},${longitude?.toStringAsFixed(4)}',
                          style: const TextStyle(fontSize: 14.0, color: Colors.black54),
                        )
                      : const Text(
                          'Lokasi tidak tersedia',
                          style: TextStyle(fontSize: 14.0, color: Colors.black54),
                        ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    DateFormat('dd MMM yyyy').format(scanDateTime),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    DateFormat('hh:mm:ss a').format(scanDateTime),
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          // Hasil Scan Barcode
          const Text(
            'Barcode:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
          ),
          const SizedBox(height: 8.0),
          Container(
            color: Colors.black12,
            width: double.infinity,
            height: 200,
            child: scanResult != null
                ? Center(child: Text(scanResult!, style: const TextStyle(fontSize: 16.0)))
                : const Center(child: Text('Belum ada hasil scan')),
          ),
        ],
      ),
    );
  }

  // Widget untuk kartu riwayat dengan lokasi
  Widget _buildHistoryCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Menampilkan Lokasi
          const Text(
            'Lokasi Anda:',
            style: TextStyle(fontSize: 14.0, color: Colors.black54),
          ),
          const SizedBox(height: 4.0),
          latitude != null && longitude != null
              ? Text(
                  'Latitude: ${latitude?.toStringAsFixed(4)}, Longitude: ${longitude?.toStringAsFixed(4)}',
                  style: const TextStyle(fontSize: 14.0, color: Colors.black54),
                )
              : const Text(
                  'Lokasi tidak tersedia',
                  style: TextStyle(fontSize: 14.0, color: Colors.black54),
                ),
        ],
      ),
    );
  }
}
