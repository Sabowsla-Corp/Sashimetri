import 'dart:async';

import 'package:sashimetri/models/utils.dart';

class TimeLineData {
  double time = 1;
  double startTime = 1;
  int duration = 30;

  TimeLineData();

  int getMilis() {
    return duration.toInt() * 1000;
  }
  /*
  double getLinePosition() {
    double percentaje = currentFrame.toDouble() / endFrame.toDouble();
    double windowWidth = getWindowSize().width;
    return percentaje * windowWidth;
  }
  */
}
