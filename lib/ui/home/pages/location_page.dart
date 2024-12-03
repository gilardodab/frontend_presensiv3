import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../../../core/core.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  GoogleMapController? mapController;  // Make mapController nullable
  LatLng? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // Fetch the current location with error handling
  Future<void> _getCurrentLocation() async {
    try {
      final hasPermission = await _handleLocationPermission();
      if (!hasPermission) {
        // Optionally show a message to the user
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        print('Current Position: $_currentPosition');
      });

      // Ensure map moves to the current position if mapController is available
      if (_currentPosition != null && mapController != null) {
        mapController!.animateCamera(
          CameraUpdate.newLatLngZoom(_currentPosition!, 15),
        );
      }
    } catch (e) {
      // Handle the error gracefully, e.g., show a message to the user
      print('Error fetching location: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to get location. Please try again.')),
      );
    }
  }

  // Check and handle location permissions
  Future<bool> _handleLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location permission is required.')),
        );
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Suggest user to enable permission in settings
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location permission is permanently denied.')),
      );
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //back button
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        backgroundColor: const Color.fromARGB(255, 114, 76, 175),
        titleTextStyle: const TextStyle(fontWeight: FontWeight.bold),
        title: const Text('Lokasi'),
      ),
      body: Stack(
        children: [
          _currentPosition == null
              ? const Center(child: CircularProgressIndicator()) // Loading indicator
              : GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition!, 
                    zoom: 15,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;  // Initialize mapController here
                  },
                  markers: {
                    Marker(
                      markerId: MarkerId("currentLocation"),
                      position: _currentPosition!,
                      infoWindow: InfoWindow(title: "Kamu Ada di sini"),
                    ),
                  },
                ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 50.0,
            ),
            // child: GestureDetector(
            //   onTap: () => Navigator.pop(context), // Use Navigator.pop
            //   child: const Icon(
            //     Icons.arrow_back,
            //     color: Color.fromARGB(255, 114, 76, 175),
            //     size: 30.0,
            //   )
            // ),
          ),
        ],
      ),
    );
  }
}
