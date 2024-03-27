import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wikitrack/utils/AppColors.dart';
import 'package:wikitrack/utils/AppFontStyle.dart';
import 'package:wikitrack/utils/AppImages.dart';

AppBar commonAppBar({String? title, Function()? onTap}) {
  final height = Get.height;
  final width = Get.width;

  return AppBar(
      backgroundColor: AppColors.primaryColor,
      centerTitle: true,
      leading: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Center(
              child: SvgPicture.asset(AppImages.whiteLogo,
                  height: height * 0.037, width: height * 0.037)),
        ),
      ),
      title: Text(
        title!,
        style: whiteMedium20TextStyle,
      ));
}

AppBar commonImageAppBar({Widget? image, Function()? onTap}) {
  final height = Get.height;
  final width = Get.width;

  return AppBar(
      backgroundColor: AppColors.primaryColor,
      centerTitle: true,
      leading: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Center(
              child: SvgPicture.asset(AppImages.whiteLogo,
                  height: height * 0.037, width: height * 0.037)),
        ),
      ),
      title: image);
}

AppBar commonSubTitleAppBar(
    {String? title,
    String? subTitle,
    Function()? onTap,
    List<Widget>? actions}) {
  final height = Get.height;
  final width = Get.width;

  return AppBar(
      backgroundColor: AppColors.primaryColor,
      centerTitle: true,
      leading: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Center(
              child: SvgPicture.asset(AppImages.whiteLogo,
                  height: height * 0.037, width: height * 0.037)),
        ),
      ),
      actions: actions,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title!,
            style: whiteMedium20TextStyle,
          ),
          Text(
            subTitle!,
            style: whiteMedium14TextStyle,
          ),
        ],
      ));
}
