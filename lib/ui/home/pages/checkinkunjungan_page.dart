import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_presensiv3/data/datasources/kunjungan_remote_datasource.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image/image.dart' as img; // For image manipulation
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart'; // For sharing images

import '../../../core/core.dart';
import '../bloc/addkunjungan/selfie_kunjugan_state.dart';
import '../bloc/addkunjungan/selfie_kunjungan_bloc.dart';
import '../bloc/addkunjungan/selfie_kunjungan_event.dart';
import 'attendance_success_page.dart';
import 'location_page.dart';

class CheckinkunjunganPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final kunjunganId; // Define the kunjunganId parameter
  const CheckinkunjunganPage(
      {super.key,
      required this.kunjunganId}); // Make sure the kunjunganId is passed via constructor

  @override
  State<CheckinkunjunganPage> createState() => _CheckinkunjunganPageState();
}

class _CheckinkunjunganPageState extends State<CheckinkunjunganPage> {
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
  final KunjunganRemoteDatasource _dataSource = KunjunganRemoteDatasource();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _getCurrentLocation(); // Get location when the app starts
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
      _controller = CameraController(description, ResolutionPreset.medium);
      await _controller!.initialize();
      if (!mounted) return; // Ensure widget is still mounted
      setState(() {});
    } catch (e) {
      print("Error initializing camera controller: $e");
      // Handle error initializing camera controller
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Camera initialization failed. Please try again.')),
      );
    }
  }

  double? latitude;
  double? longitude;
  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        setState(() {
          _location =
              "${placemarks[0].street}, ${placemarks[0].subThoroughfare},  ${placemarks[0].subLocality}, ${placemarks[0].locality}, ${placemarks[0].country}";
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
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    
    // Add watermark to the image
    img.Image image = img.decodeImage(imageFile.readAsBytesSync())!;
    img.drawString(image, img.arial_14, 10, 10, 'E-Presensi');
    if (_location != null) {
      img.drawString(image, img.arial_14, 10, 70, 'Lokasi: $_location');
    } else {
      img.drawString(image, img.arial_14, 10, 70, 'Lokasi: ${position.latitude}, ${position.longitude}');
    }
    if (_timeStamp != null) {
      img.drawString(image, img.arial_14, 10, 20, '$_timeStamp');
    }

    // Save the new image with watermark
    File watermarkedImage = await File(imageFile.path).writeAsBytes(img.encodeJpg(image));

    // Encode the image to Base64 for submission
    String base64Image = base64Encode(await watermarkedImage.readAsBytes());
    print (base64Image);
    if (mounted) {
      context.read<SelfieKunjunganBloc>().add(
        SelfieKunjunganEvent.checkin(
          latitude.toString(),
          longitude.toString(),
          base64Image,
          widget.kunjunganId,
        ),
      );
    }

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
          title: Text("Hasil Foto",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              textAlign: TextAlign.center),
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
  Widget build(BuildContext context) {
    if (_controller == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(
          title: const Text('Masuk Kunjungan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              )),
          backgroundColor: Color.fromARGB(255, 114, 76, 175)),
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
                            'Kunjungan',
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
                      Text(
                        'Kunjungan ID: ${widget.kunjunganId}',
                        style: const TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w700,
                        ),
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
                    BlocConsumer<SelfieKunjunganBloc, SelfieKunjunganState>(
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
// child: Text('Kunjungan ID: ${widget.kunjunganId}'),