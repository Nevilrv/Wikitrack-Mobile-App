import 'package:flutter/material.dart';
import 'package:wikitrack/utils/AppColors.dart';

class AppDropDown extends StatelessWidget {
  final dynamic values;
  final ValueChanged onChanged;
  final double? height;
  final Widget hint;
  final Color? borderColor;
  final List<DropdownMenuItem<dynamic>>? items;
  final bool ignoring;
  final double opacity;
  void Function()? onTap;
  Color? color;
  double? iconSize;
  final EdgeInsetsGeometry padding;
  double? horizontal;
  TextStyle? style;
  AppDropDown({
    super.key,
    this.values,
    required this.onChanged,
    this.height,
    required this.hint,
    this.borderColor,
    this.items,
    this.onTap,
    this.style,
    this.ignoring = false,
    this.opacity = 1,
    this.horizontal,
    this.iconSize,
    this.color,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Padding(
      padding: padding,
      child: IgnorePointer(
        ignoring: ignoring,
        child: Opacity(
          opacity: opacity,
          child: Container(
            height: height ?? h * 0.056,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: color ?? AppColors.whiteColor,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: borderColor ?? AppColors.grey2Color),
            ),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: horizontal ?? w * 0.032),
              child: DropdownButton(
                menuMaxHeight: h / 2,
                hint: hint,
                onTap: onTap,
                style: style,
                icon: Icon(
                  Icons.arrow_drop_down_sharp,
                  size: iconSize ?? 35,
                  color: AppColors.grey2Color,
                ),
                value: values,
                isExpanded: true,
                borderRadius: BorderRadius.circular(8),
                underline: const SizedBox(),
                items: items,
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
