import 'dart:io';
import 'dart:convert'; // For Base64 encoding
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image/image.dart' as img;  // For image manipulation
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';  // For sharing images
import 'package:image_picker/image_picker.dart';

import '../../../core/components/spaces.dart';
import '../../../core/core.dart';  // For handling image file paths


//slefie kunjungan khusus callplan
class SelfieKunjungan extends StatefulWidget {
  const SelfieKunjungan({super.key});

  @override
  State<SelfieKunjungan> createState() => _SelfieKunjunganState();
}

class _SelfieKunjunganState extends State<SelfieKunjungan> {
  List<CameraDescription>? _availableCameras;
  CameraController? _controller;
  String? _imagePath; // To store the path of the taken picture
  File? _imageFile;
    String? _location;
  String? _name;
  String? _thoroughfare;
  String? _locality;
  String? _administrativeArea;
  String? _postalCode;
  String? _country;
  String? _timeStamp;
  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _getCurrentLocation();  // Get location when the app starts
    _timeStamp = DateFormat('HH:mm:ss dd-MM-yyyy').format(DateTime.now());
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _initializeCamera() async {
    try {
      _availableCameras = await availableCameras();
      CameraDescription? frontCamera = _availableCameras?.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => _availableCameras!.first,
      );
      _controller = CameraController(
        frontCamera!,
        ResolutionPreset.medium,
      );
      await _controller?.initialize();
      setState(() {});
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

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

    Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
        if (placemarks.isNotEmpty) {
          setState(() {
            _location = "${placemarks[0].street}, ${placemarks[0].subThoroughfare},  ${placemarks[0].subLocality}, ${placemarks[0].locality}, ${placemarks[0].country}";  
          });

        } else {
          setState(() {
            _location = "${position.latitude}, ${position.longitude}";
          });
        }

    } catch (e) {
      print('Error getting location: $e');
    }
  }

  Future<void> _takePicture() async {
    try {
      // Take a picture
      XFile picture = await _controller!.takePicture();
      File imageFile = File(picture.path);
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      // Add watermark to the image
      img.Image image = img.decodeImage(imageFile.readAsBytesSync())!;
      img.drawString(image, img.arial_24, 10, 10, 'E-Presensi'); // Adjust watermark position
    if (_location  != null) {
      img.drawString(image, img.arial_14, 10, 70, '$_location');
    }else { //latitude longitude
      img.drawString(image, img.arial_14, 10, 70, '${position.latitude}, ${position.longitude}');
    }
    // Add timestamp text
    if (_timeStamp != null) {
      img.drawString(image, img.arial_14, 10, 40, '$_timeStamp');
    }
      // Save the new image with watermark
      File watermarkedImage = await File(imageFile.path)
          .writeAsBytes(img.encodeJpg(image));

      // Display dialog with the photo and share option
      _showPhotoDialog(watermarkedImage);
    } catch (e) {
      print("Error taking picture: $e");
    }
  }

  void _showPhotoDialog(File imageFile) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Hasil Foto", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center),
          content: Image.file(imageFile),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Share the photo
                Share.shareXFiles([XFile(imageFile.path)]);
              },
              child: Text("Share"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
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
  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        title: const Text('Selfie Kunjungan'),
        titleTextStyle: const TextStyle(fontWeight: FontWeight.bold),
        backgroundColor: const Color.fromARGB(255, 114, 76, 175),
      ),
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
