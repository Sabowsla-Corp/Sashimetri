import 'package:flutter/material.dart';

Size getWindowSize() {
  return MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size;
}
