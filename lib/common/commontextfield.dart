import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wikitrack/utils/AppColors.dart';
import 'package:wikitrack/utils/AppFontStyle.dart';

TextFormField commonTextField({
  String? Function(String?)? validator,
  TextEditingController? controller,
  bool? enabled,
  List<TextInputFormatter>? inputFormatters,
  void Function()? onTap,
  void Function(String)? onChanged,
  TextInputType? keyboardType,
  Widget? prefixIcon,
  Color? color,
  Color? textColor,
  bool? readOnly,
  String? hintMsg,
  void Function(String)? onSubmitted,
}) {
  return TextFormField(
    style: TextStyle(color: textColor ?? AppColors.textGreyColor),
    validator: validator,
    controller: controller,
    inputFormatters: inputFormatters,
    onTap: onTap,
    readOnly: readOnly ?? false,
    enabled: enabled,
    onChanged: onChanged,
    onFieldSubmitted: onSubmitted,
    keyboardType: keyboardType,
    cursorColor: AppColors.primaryColor,
    decoration: InputDecoration(
      hintText: hintMsg ?? "Enter here",
      prefixIcon: prefixIcon,
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      hintStyle: textGreyMedium16TextStyle,
      enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: color ?? const Color(0xffE8E8E8), width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedErrorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: color ?? const Color(0xffE8E8E8), width: 1),
          borderRadius: BorderRadius.circular(8)),
      errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffE8E8E8), width: 1),
          borderRadius: BorderRadius.circular(8)),
      focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: color ?? const Color(0xffE8E8E8), width: 1),
          borderRadius: BorderRadius.circular(8)),
    ),
  );
}
