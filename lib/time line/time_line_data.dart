class TimeLineData {
  double time = 1;
  double startTime = 1;
  int duration = 5;
  int frame = 0;

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
