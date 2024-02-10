import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wikitrack/utils/AppColors.dart';
import 'package:wikitrack/utils/AppFontStyle.dart';

TextFormField commonTextField(
    {String? Function(String?)? validator,
    TextEditingController? controller,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
    Widget? prefixIcon}) {
  return TextFormField(
    style: const TextStyle(color: Color(0xff999999)),
    validator: validator,
    controller: controller,
    inputFormatters: inputFormatters,
    keyboardType: keyboardType,
    cursorColor: AppColors.primaryColor,
    decoration: InputDecoration(
      hintText: "Enter here",
      prefixIcon: prefixIcon,
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      hintStyle: textGreyMedium16TextStyle,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xffE8E8E8), width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffE8E8E8), width: 1), borderRadius: BorderRadius.circular(8)),
      errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffE8E8E8), width: 1), borderRadius: BorderRadius.circular(8)),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffE8E8E8), width: 1), borderRadius: BorderRadius.circular(8)),
    ),
  );
}
