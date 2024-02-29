import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikitrack/common/appbar.dart';
import 'package:wikitrack/common/button.dart';
import 'package:wikitrack/utils/AppColors.dart';
import 'package:wikitrack/utils/AppFontStyle.dart';
import 'package:wikitrack/utils/AppStrings.dart';

class BusStopDisplayScreen extends StatefulWidget {
  const BusStopDisplayScreen({super.key});

  @override
  State<BusStopDisplayScreen> createState() => _BusStopDisplayScreenState();
}

class _BusStopDisplayScreenState extends State<BusStopDisplayScreen> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonSubTitleAppBar(
        title: AppStrings.busStopDisplay,
        subTitle: AppStrings.bmtc,
        onTap: () {
          Get.back();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.05),
          child: Column(
            children: [
              SizedBox(
                height: h * 0.02,
              ),
              commonBorderButton(onTap: () {}, title: AppStrings.selectStop),
              SizedBox(
                height: h * 0.02,
              ),
              commonBorderButton(
                height: h * 0.055,
                onTap: () {},
                title: AppStrings.selectStop,
                child: Row(
                  children: [
                    SizedBox(
                      width: w * 0.03,
                    ),
                    Text(
                      AppStrings.route,
                      style: blackMedium14TextStyle,
                    ),
                    Spacer(),
                    Text(
                      "Time (S)",
                      style: blackMedium14TextStyle,
                    ),
                    SizedBox(
                      width: w * 0.03,
                    ),
                  ],
                ),
                color: AppColors.lightGreyColor,
                borderColor: Colors.transparent,
              ),
              ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            spreadRadius: 0.01,
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          )
                        ],
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: h * 0.012),
                        child: Row(
                          children: [
                            SizedBox(
                              width: w * 0.02,
                            ),
                            Text(
                              index == 1
                                  ? "314B Shivajinagar to CV Raman Nagar"
                                  : index == 2
                                      ? "134 Shivajinagar to JB Nagar"
                                      : "314 Shivajinagar to CV Raman Nagar",
                              style: blackMedium14TextStyle,
                            ),
                            Spacer(),
                            Text(
                              index == 1 ? "5 Sec" : "2 Sec",
                              style: blackMedium14TextStyle,
                            ),
                            SizedBox(
                              width: w * 0.018,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
