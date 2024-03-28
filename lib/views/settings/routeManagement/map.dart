import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wikitrack/utils/app_colors.dart';
import 'package:wikitrack/views/settings/controller/setting_controller.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  SettingController settingController = Get.find();
  Position? currentPosition;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    _getCurrentPosition();
    super.initState();
  }

  Future<bool> _handleLocationPermission() async {
    setState(() {
      isLoading = true;
    });
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => currentPosition = position);
      log('currentPosition!.latitude==========>>>>>${currentPosition!.latitude}');
      log('currentPosition!.longitude==========>>>>>${currentPosition!.longitude}');
      settingController.lat = currentPosition!.latitude;
      settingController.long = currentPosition!.longitude;
    }).catchError((e) {
      debugPrint("ERROR=========$e");
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ))
          : GetBuilder<SettingController>(
              builder: (controller) {
                return GoogleMap(
                  onTap: (argument) {
                    Get.back(result: argument);
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                        currentPosition!.latitude, currentPosition!.longitude),
                    zoom: 12,
                  ),
                );
              },
            ),
    );
  }
}
