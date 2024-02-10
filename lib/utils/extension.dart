import 'package:flutter/material.dart';
import 'package:wikitrack/utils/AppFontStyle.dart';

extension SizedExtension on double {
  addHSpace() {
    return SizedBox(height: this);
  }

  addWSpace() {
    return SizedBox(width: this);
  }
}
