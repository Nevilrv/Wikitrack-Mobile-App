import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikitrack/common/appbar.dart';
import 'package:wikitrack/common/button.dart';
import 'package:wikitrack/utils/AppRoutes.dart';
import 'package:wikitrack/utils/AppStrings.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonSubTitleAppBar(
        title: AppStrings.reports,
        subTitle: AppStrings.bmtc,
        onTap: () {
          Get.back();
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.04),
        child: Column(
          children: [
            SizedBox(
              height: h * 0.02,
            ),
            commonBorderButton(
                title: AppStrings.dailyTripReport,
                onTap: () {
                  Get.toNamed(Routes.dailyTripReportScreen);
                }),
          ],
        ),
      ),
    );
  }
}
