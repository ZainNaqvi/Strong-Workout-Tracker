import 'package:flutter/material.dart';

import '../src/presentation/animation/fade_in_animation.dart';

extension StringExtension on String {
  String get addOverFlow {
    if (length < 22) {
      return this;
    } else {
      return "${substring(0, 22)}...";
    }
  }
}

extension WidgetExtension on Widget {
  Widget fadeAnimation(double delay) {
    return FadeInAnimation(delay: delay, child: this);
  }
}

String formatTime(int seconds, bool pad) {
  return (pad)
      ? "${(seconds / 60).floor()}:${(seconds % 60).toString().padLeft(2, '0')}"
      : (seconds > 59)
          ? "${(seconds / 60).floor()}:${(seconds % 60).toString().padLeft(2, '0')}"
          : seconds.toString();
}
