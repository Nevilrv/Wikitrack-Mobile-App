import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wikitrack/common/appbar.dart';
import 'package:wikitrack/socket/socket_service.dart';
import 'package:wikitrack/utils/AppColors.dart';
import 'package:wikitrack/utils/AppFontStyle.dart';
import 'package:wikitrack/utils/AppImages.dart';
import 'package:wikitrack/utils/AppStrings.dart';
import 'package:wikitrack/utils/FontSize.dart';
import 'package:wikitrack/views/trip_history/controller/trip_history_controller.dart';

class TripHistoryScreen extends StatefulWidget {
  const TripHistoryScreen({super.key});

  @override
  State<TripHistoryScreen> createState() => _TripHistoryScreenState();
}

class _TripHistoryScreenState extends State<TripHistoryScreen> {
  TripHistoryController tripHistoryController = Get.find();
  Position? currentPosition;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    _getCurrentPosition();
    SocketConnection.connectSocket(() {
      tripHistoryController.getSocketLiveMapData();
      tripHistoryController.getLiveMapDataListener();
      print("socket connection----");
    });
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
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
        setState(() => currentPosition = position);
        log('currentPosition!.latitude==========>>>>>${currentPosition!.latitude}');
        log('currentPosition!.longitude==========>>>>>${currentPosition!.longitude}');
        tripHistoryController.lat = currentPosition!.latitude;
        tripHistoryController.long = currentPosition!.longitude;
      }).catchError((e) {
        debugPrint("ERROR=========$e");
      });
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonSubTitleAppBar(
        title: AppStrings.tripHistory,
        subTitle: AppStrings.bmtc,
        onTap: () {
          Get.back();
        },
      ),
      body: GetBuilder<TripHistoryController>(builder: (controller) {
        return Column(
          children: [
            Container(
              height: h * 0.57,
              width: w * 1,
              child: isLoading == true
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ))
                  : GoogleMap(
                      onTap: (argument) {
                        Get.back(result: argument);
                      },
                      initialCameraPosition: CameraPosition(
                        target: LatLng(currentPosition!.latitude, currentPosition!.longitude),
                        zoom: 12,
                      ),
                    ),
            ),
            Stack(
              children: [
                Container(
                  height: h * 0.3,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: h * 0.07),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    right: w * 0.05,
                    left: w * 0.03,
                    top: h * 0.02,
                    // bottom: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              AppStrings.selectTrip,
                              style: whiteMedium16TextStyle,
                            ),
                            SizedBox(
                              width: w * 0.02,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: AppColors.whiteColor,
                            ),
                            Spacer(),
                            GestureDetector(
                                onTap: () {
                                  showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        height: h * 0.35,
                                        decoration: BoxDecoration(
                                          color: AppColors.whiteColor,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: h * 0.03,
                                                ),
                                                buildContainerTile(
                                                    h, w, AppStrings.byRoute, AppImages.routeManage, () {}),
                                                SizedBox(
                                                  height: h * 0.03,
                                                ),
                                                buildContainerTile(
                                                    h, w, AppStrings.byVehicle, AppImages.vehicleManage, () {}),
                                                SizedBox(
                                                  height: h * 0.03,
                                                ),
                                                buildContainerTile(h, w, AppStrings.byTime, AppImages.time, () {}),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: SvgPicture.asset(AppImages.menuIcon)),
                          ],
                        ),
                        SizedBox(
                          height: h * 0.03,
                        ),
                        SizedBox(
                          height: h * 0.2,
                          child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: GestureDetector(
                                  onTap: () {
                                    controller.indexCheck = index;
                                    controller.update();
                                  },
                                  child: Container(
                                    height: h * 0.055,
                                    width: w * 1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade200,
                                          spreadRadius: 0.1,
                                          blurRadius: 5,
                                          offset: const Offset(0, 5),
                                        )
                                      ],
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: h * 0.015, horizontal: w * 0.03),
                                      child: Text(
                                        "314: 14-Jan-2023 4.15",
                                        style: controller.indexCheck == index
                                            ? primaryBold12TextStyle.copyWith(fontSize: FontSize().font14)
                                            : greyMedium14TextStyle,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    )),
              ],
            )
          ],
        );
      }),
    );
  }

  GestureDetector buildContainerTile(double height, double width, String title, String image, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height * 0.07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 5),
            )
          ],
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              SvgPicture.asset(
                image,
                height: height * 0.033,
                width: height * 0.033,
                color: AppColors.grey1Color,
              ),
              SizedBox(
                width: width * 0.03,
              ),
              Text(
                title,
                style: blackMedium14TextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
