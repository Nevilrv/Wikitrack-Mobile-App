import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikitrack/utils/app_colors.dart';
import 'package:wikitrack/utils/app_font_style.dart';

Widget CommonButton(
    {String? title,
    Function()? onTap,
    double? width,
    double? height,
    Color? buttonColor,
    TextStyle? style}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: height ?? Get.height * 0.065,
      width: width ?? Get.width,
      decoration: BoxDecoration(
          color: buttonColor ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(8)),
      child:
          Center(child: Text(title!, style: style ?? whiteMedium16TextStyle)),
    ),
  );
}

Widget commonBorderButton(
    {String? title,
    Function()? onTap,
    Color? borderColor,
    Color? color,
    Widget? child,
    double? height,
    Color? textColor,
    List<BoxShadow>? boxShadow}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: height ?? Get.height * 0.065,
      width: Get.width,
      decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? AppColors.primaryColor),
          color: color ?? AppColors.whiteColor,
          boxShadow: boxShadow,
          borderRadius: BorderRadius.circular(8)),
      child: child ??
          Center(
              child: Text(title!,
                  style: whiteMedium16TextStyle.copyWith(
                      color: textColor ?? AppColors.primaryColor,
                      fontWeight: FontWeight.w600))),
    ),
  );
}
