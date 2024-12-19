import 'dart:io';
import 'dart:convert'; // For Base64 encoding
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_presensiv3/ui/home/bloc/addunplan/unplankunjungan_bloc.dart';
import 'package:frontend_presensiv3/ui/home/bloc/addunplan/unplankunjungan_state.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image/image.dart' as img;  // For image manipulation
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';  // For sharing images
import 'package:image_picker/image_picker.dart';

import '../../../core/components/spaces.dart';
import '../../../core/core.dart';
import '../bloc/addunplan/unplankunjungan_event.dart';
import 'attendance_success_page.dart';  // For handling image file paths


//slefie kunjungan khusus callplan
class UnplanKunjungan extends StatefulWidget {
  const UnplanKunjungan({super.key});

  @override
  State<UnplanKunjungan> createState() => _UnplanKunjunganState();
}

class _UnplanKunjunganState extends State<UnplanKunjungan> {
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

  double? latitude;
  double? longitude;

    Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
              Placemark placeMark  = placemarks[0]; 
              String? name = placeMark.name;
              String? subLocality = placeMark.subLocality;
              String? locality = placeMark.locality;
              String? administrativeArea = placeMark.administrativeArea;
              String? postalCode = placeMark.postalCode;
              // String? country = placeMark.country;
              String? address = "${name}, ${subLocality}, ${locality}, ${administrativeArea}, ${postalCode}";
              
          print(address);
        if (placemarks.isNotEmpty) {
          setState(() {
          _location = address;
          latitude = position.latitude;  // Update latitude
          longitude = position.longitude; // Update longitude
            print(_location);
          });

        } else {
          setState(() {
          _location = "${position.latitude}, ${position.longitude}";
          latitude = position.latitude;  // Update latitude
          longitude = position.longitude; // Update longitude
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
      img.drawString(image, img.arial_14, 10, 10, 'E-Presensi'); // Adjust watermark position
    if (_location  != null) {
      img.drawString(image, img.arial_14, 10, 70, 'Lokasi: $_location');
    }else { //latitude longitude
      img.drawString(image, img.arial_14, 10, 70, 'Lokasi: ${position.latitude}, ${position.longitude}');
    }
    // Add timestamp text
    if (_timeStamp != null) {
      img.drawString(image, img.arial_14, 10, 20, '$_timeStamp');
    }
    // Save the new image with watermark
    File watermarkedImage = await File(imageFile.path).writeAsBytes(img.encodeJpg(image));

    // Encode the image to Base64 for submission
    String base64Image = base64Encode(await watermarkedImage.readAsBytes());
    print (base64Image);
if (mounted && latitude != null && longitude != null) {
        context.read<UnplanKunjunganBloc>().add(
          UnplanKunjunganEvent.unplan(
            latitude.toString(),
            longitude.toString(),
            base64Image,
          ),
        );
      }
    print(latitude);

      // Display dialog with the photo and share option
      // _showPhotoDialog(watermarkedImage);
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
      // backgroundColor: Colors.black,
      //leading back
      appBar: AppBar(
        title: const Text('Kunjungan UNPLAN', 
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 114, 76, 175),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          AspectRatio(
            aspectRatio: 9.0 / 16.0,
            child: CameraPreview(_controller!),
          ),
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SpaceHeight(10.0),
                Row(
                  children: [
                    IconButton(
                      onPressed: _reverseCamera,
                      icon: const Icon(
                        Icons.flip_camera_android,
                        size: 40.0,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    const Spacer(),
                    BlocConsumer<UnplanKunjunganBloc, UnplanKunjunganState>(
                      listener: (context, state) {
                        state.maybeWhen(
                          orElse: () {},
                          error: (message) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(message)),
                            );
                          },
                          loaded: (responseModel) {
                            context.pushReplacement(const AttendanceSuccessPage(
                            ));
                          },
                        );
                      },
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () {
                            return IconButton(
                              onPressed: _takePicture,
                              icon: const Icon(
                                Icons.circle,
                                size: 70.0,
                              ),
                              color: AppColors.red,
                            );
                          },
                          loading: () => const Center(child: CircularProgressIndicator()),
                        );
                      },
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
