import 'dart:io';
import 'dart:convert'; // For Base64 encoding
import 'package:geolocator/geolocator.dart';
import 'package:image/image.dart' as img;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/core.dart';
import '../../../data/datasources/add_presensi_datasource.dart';
import 'attendance_success_page.dart';
import 'location_page.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  List<CameraDescription>? _availableCameras;
  CameraController? _controller;
  String? _imagePath; // To store the path of the taken picture
  File? _imageFile;  // To store the compressed image file

  final AddPresensiDataSource _dataSource = AddPresensiDataSource(); // Data source instance

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  // Initialize camera with error handling
  void _initializeCamera() async {
    try {
      _availableCameras = await availableCameras();
      CameraDescription? frontCamera = _availableCameras?.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => _availableCameras!.first,
      );
      if (frontCamera != null) {
        await _initCamera(frontCamera);
      } else {
        await _initCamera(_availableCameras!.first);
      }
    } catch (e) {
      print("Error initializing camera: $e");
      // Handle camera initialization error (e.g. show user-friendly message)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Camera initialization failed. Please try again.')),
      );
    }
  }

  // Initialize the CameraController
  Future<void> _initCamera(CameraDescription description) async {
    try {
      _controller = CameraController(description, ResolutionPreset.high);
      await _controller!.initialize();
      if (!mounted) return; // Ensure widget is still mounted
      setState(() {});
    } catch (e) {
      print("Error initializing camera controller: $e");
      // Handle error initializing camera controller
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Camera initialization failed. Please try again.')),
      );
    }
  }

  // Capture and process the picture
  void _takePicture() async {
    try {
      if (_controller == null || !_controller!.value.isInitialized) {
        print("Camera controller not initialized.");
        return;
      }

      final XFile picture = await _controller!.takePicture();
      setState(() {
        _imagePath = picture.path;
      });

      if (_imagePath != null) {
        File imageFile = File(_imagePath!);
        img.Image? originalImage = img.decodeImage(imageFile.readAsBytesSync());

        if (originalImage != null) {
          img.Image compressedImage = img.copyResize(originalImage, width: 200);
          List<int> compressedBytes = img.encodeJpg(compressedImage, quality: 70);

          final compressedImageFile = File('${imageFile.parent.path}/compressed_${imageFile.uri.pathSegments.last}')
            ..writeAsBytesSync(compressedBytes);

          setState(() {
            _imageFile = compressedImageFile;
          });
        }

        // Encode the image to Base64 for submission
        String base64Image = base64Encode(await _imageFile!.readAsBytes());

        // Get the current location
        Position position = await _getLocation();

        // Submit the attendance data
        _submitAttendance(base64Image, position.latitude, position.longitude);
      }
    } catch (e) {
      print("Error taking picture: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to capture picture. Please try again.')),
      );
    }
  }

  // Method to get the current location using Geolocator
  Future<Position> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled. Please enable them to continue.');
    }

    // Check for location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied. Please enable it to continue.');
      }
    }

    // Get the current position
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  // Submit the attendance data to the backend
  Future<void> _submitAttendance(String base64Image, double latitude, double longitude) async {
    try {
      final response = await _dataSource.addPresensi(
        latitude: latitude.toString(),
        longitude: longitude.toString(),
        pictureBase64: base64Image,
      );

      if (response.status == 'success') {
        _showSuccessPopup();
      } else {
        _showErrorPopup(response.message ?? 'Failed to record attendance');
      }
    } catch (e) {
      _showErrorPopup('An error occurred while submitting attendance: $e');
    }
  }

  // Show success popup
  void _showSuccessPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Berhasil Presensi'),
          content: const Text('Presensi berhasil disimpan!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AttendanceSuccessPage()),
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Show error popup
  void _showErrorPopup(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Reverse camera lens direction (front/back)
  void _reverseCamera() {
    final lensDirection = _controller!.description.lensDirection;
    CameraDescription newDescription;
    if (lensDirection == CameraLensDirection.front) {
      newDescription = _availableCameras!.firstWhere((description) =>
          description.lensDirection == CameraLensDirection.back);
    } else {
      newDescription = _availableCameras!.firstWhere((description) =>
          description.lensDirection == CameraLensDirection.front);
    }
    _initCamera(newDescription);
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      body: Stack(
        children: [
          AspectRatio(
            aspectRatio: 9.0 / 16.0,
            child: CameraPreview(_controller!),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 102, 86, 244).withOpacity(0.47),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Presensi',
                            style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Harian',
                            style: TextStyle(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          context.push(const LocationPage());
                        },
                        child: Assets.images.seeLocation.image(height: 30.0),
                      ),
                    ],
                  ),
                ),
                const SpaceHeight(30.0),
                Row(
                  children: [
                    IconButton(
                      onPressed: _reverseCamera,
                      icon: const Icon(
                        Icons.flip_camera_android,
                        size: 40.0,
                        color: AppColors.black,
                      ),
                      ),
                    const Spacer(),
                    IconButton(
                      onPressed: _takePicture,
                      icon: const Icon(
                        Icons.circle,
                        size: 70.0,
                      ),
                      color: AppColors.red,
                    ),
                    const Spacer(),
                    const SpaceWidth(50.0),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
