import 'package:flutter/material.dart';
import 'dart:math' as math;

Size phoneSize(context) {
  return MediaQuery.of(context).size;
}

fillStartPoints(int iterations, List<Offset> obj) {
  List<Offset> points = List<Offset>(iterations + 1);
  double xStep = (obj[1].dx - obj[0].dx) / (iterations);
  double yStep = (obj[1].dy - obj[0].dy) / (iterations);

  for (int i = 0; i <= iterations; i++) {
    points[i] = Offset(obj[0].dx + i * xStep, obj[0].dy + i * yStep);
  }

  return points;
}

fillEndPoints(int iterations, List<Offset> obj) {
  List<Offset> points = List<Offset>(iterations + 1);
  double xStep = (obj[2].dx - obj[1].dx) / (iterations);
  double yStep = (obj[2].dy - obj[1].dy) / (iterations);

  for (int i = 0; i <= iterations; i++) {
    points[i] = Offset(obj[1].dx + i * xStep, obj[1].dy + i * yStep);
  }

  return points;
}

int nearestPointToTouch(Offset newP, List<Offset> oldP) {
  int nearest = 0;
  List<double> magnitudes = List();

  for (int i = 0; i < oldP.length; i++) {
    double currentMag = (newP - oldP[i]).distance;
    magnitudes.add(currentMag);
  }

  if (magnitudes[0] <= magnitudes[1] && magnitudes[0] <= magnitudes[2]) {
    nearest = 0;
  }
  if (magnitudes[1] <= magnitudes[0] && magnitudes[1] <= magnitudes[2]) {
    nearest = 1;
  }
  if (magnitudes[2] <= magnitudes[0] && magnitudes[2] <= magnitudes[1]) {
    nearest = 2;
  }

  return nearest;
}

detectTwoNearest(Offset newP, List<Offset> oldP) {
  List<NearPoint> pointsByMag = List();

  for (int i = 0; i < oldP.length; i++) {
    double currentMag = (newP - oldP[i]).distance;
    pointsByMag.add(
      NearPoint(i, currentMag),
    );
  }
  pointsByMag.sort((a, b) => a.mag.compareTo(b.mag));

  print("Two Nearest ${[pointsByMag[0].index, pointsByMag[1].index]}");
  return [pointsByMag[0].index, pointsByMag[1].index];
}

class NearPoint {
  int index;
  double mag;
  NearPoint(this.index, this.mag);
}

getColorShade(int index, int shade) {
  if (shade == 50) {
    return Colors.primaries[index].shade50;
  }
  if (shade == 100) {
    return Colors.primaries[index].shade100;
  }
  if (shade == 200) {
    return Colors.primaries[index].shade200;
  }
  if (shade == 300) {
    return Colors.primaries[index].shade300;
  }
  if (shade == 400) {
    return Colors.primaries[index].shade400;
  }
  if (shade == 500) {
    return Colors.primaries[index].shade500;
  }
  if (shade == 600) {
    return Colors.primaries[index].shade600;
  }
  if (shade == 700) {
    return Colors.primaries[index].shade700;
  }
  if (shade == 800) {
    return Colors.primaries[index].shade800;
  }
  if (shade == 900) {
    return Colors.primaries[index].shade900;
  }
}

List<Offset> createCircularGrid(
    int radialSubdvisions, int layers, double distance) {
  List<Offset> grid = List<Offset>();
  for (int r = 0; r < layers; r++) {
    for (int thetaIndex = 0; thetaIndex < radialSubdvisions; thetaIndex++) {
      double anglePercent = (thetaIndex / radialSubdvisions);
      double theta = math.pi * 2 * anglePercent;
      double x = math.cos(theta) * distance * r;
      double y = math.sin(theta) * distance * r;
      grid.add(Offset(x, y));
    }
  }
  return grid;
}

List<Offset> createSquaredGrid(double scale, int repeat) {
  List<Offset> grid = List<Offset>();
  for (int y = -repeat; y <= repeat; y++) {
    for (int x = -repeat; x <= repeat; x++) {
      grid.add(Offset((x * scale), (y * scale)));
    }
  }
  return grid;
}

bool nearSliderEnd(double value, double min, double max) {
  if (abs(max - value) < 0.1) {
    print("Near Max");
    return true;
  }
  if (abs(min - value) < 0.1 && min > 1) {
    print("Near Min");
    return true;
  }
  return false;
}

double nearSliderEndDirection(double value, double min, double max) {
  if (abs(max - value) < 0.1) {
    return 1;
  }
  if (abs(min - value) < 0.1 && min > 1) {
    print("Near Min");
    return -1;
  }
  return 0;
}

rRange() {
  return math.Random.secure().nextDouble() * 400;
}

abs(double val) {
  if (val < 0) {
    val = -val;
  }
  return val;
}
