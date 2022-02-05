import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sashimetri/models/utils.dart';
import 'package:sashimetri/workspace/sashi_functions.dart';
import 'package:sashimetri/workspace/view%20layer/layer_point_view.dart';

const defaultPoints = [
  Offset(0, 0),
  Offset(100, 100),
  Offset(50, 50),
];

class LayerModel {
  List<Offset>? grid;

  List<Offset>? starts;
  List<Offset>? ends;

  List<LayerProperties> propertiesOverTime;
  Offset center = Offset(50, 50);

  double thickness;
  bool visible;
  String name;
  bool symetryc;
  bool gridSnapping;
  bool gridDrawing;
  GridType gridType;

  bool selected;
  double gridScale = 50;

  double maxGlow = 5;
  double glowSize = 2;
  double minGlow = 0;
  int gridExtent = 20;
  int radialDivisions = 20;
  int subdivisions = 10;

  LayerModel({
    this.name: "Layer",
    this.selected: false,
    this.thickness: 1,
    this.visible: true,
    this.subdivisions: 10,
    this.symetryc: true,
    this.gridSnapping: true,
    this.gridDrawing: false,
    this.gridType: GridType.squared,
    this.grid,
    required this.propertiesOverTime,
  }) {
    starts = fillStartPoints(subdivisions, mainPoints(0));
    ends = fillEndPoints(subdivisions, mainPoints(0));
    resetCenter();
    setGridType(gridType);
  }
  void resetCenter() {
    Size windowSize = getWindowSize();

    center = Offset(windowSize.width / 2, windowSize.height / 2);
  }

  void changeColor(Color newColor, int frame) {}

  LayerModel randomLayer() {
    double randomX = Random.secure().nextDouble() * 100;
    return LayerModel(
      selected: true,
      grid: createSquaredGrid(50, 10),
      propertiesOverTime: [
        LayerProperties().createTopLeft(),
        LayerProperties().createCenterLeftTop(),
      ],
    );
  }

/*
  void randomize() {
    Size windowSize =
        MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size;
    double halfWidth = windowSize.width / 2;
    double halfHeight = windowSize.height / 2;
    for (int i = 0; i < mainPoints.length; i++) {
      double randomX = Random.secure().nextDouble() * halfWidth;
      double randomY = Random.secure().nextDouble() * halfHeight;
      mainPoints[i] = Offset(randomX, randomY);
    }
    recalculateLayer(frame);
  }
  */

  void recalculateLayer(int frame) {
    starts = fillStartPoints(subdivisions, mainPoints(frame));
    ends = fillEndPoints(subdivisions, mainPoints(frame));
  }

  List<Offset> mainPoints(int frame) {
    return evaluatePoints(frame, propertiesOverTime);
  }

  void toggleVisibility() {
    visible = !visible;
  }

  void adjustGridScale(double delta) {
    gridScale += delta;
    if (gridScale < 10) {
      gridScale = 30;
    }
    setGridType(gridType);
    snapPoints();
  }

  void toggleGridView() => gridDrawing = !gridDrawing;
  void deselect() => selected = false;
  void select() => selected = true;

  void draw(Paint paint, Canvas canvas, int frame) {
    if (!visible) return;

    if (selected) {
      paint.color = Colors.amber;
      paint.strokeWidth = thickness + 0.1;
      for (int i = 0; i <= subdivisions; i++) {
        canvas.drawLine(starts![i] + center, ends![i] + center, paint);
      }
    }

    paint.color = evaluateColor(frame)!;
    paint.strokeWidth = thickness;

    for (int i = 0; i <= subdivisions; i++) {
      canvas.drawLine(starts![i] + center, ends![i] + center, paint);
    }
    if (symetryc) _drawSymetry(paint, canvas, center, frame);

    if (gridSnapping && selected) drawGrid(paint, canvas, center);
  }

  void dragPoint(int index, Offset delta) {
    //mainPoints[index] += delta;

    //recalculateLayer();
  }

  void drawGrid(Paint paint, Canvas canvas, Offset center) {
    if (!gridDrawing) return;
    grid!.forEach((element) {
      canvas.drawCircle(element + center, 2, paint);
    });
  }

  void _drawSymetry(Paint paint, Canvas canvas, Offset center, int frame) {
    var mainPoints = evaluatePoints(frame, propertiesOverTime);
    var symetrycPoints = symetrycMetriPoints(mainPoints);
    symetrycPoints.forEach((symetrycPoint) {
      paint.color = evaluateColor(0)!;
      List<Offset> starts = fillStartPoints(subdivisions, symetrycPoint);
      List<Offset> ends = fillEndPoints(subdivisions, symetrycPoint);
      for (int i = 0; i <= subdivisions; i++) {
        canvas.drawLine(starts[i] + center, ends[i] + center, paint);
      }
    });
  }

  List<List<Offset>> symetrycMetriPoints(points) {
    List<List<Offset>> temp = [];
    temp.add(invertX(points));
    temp.add(invertY(points));
    temp.add(invertXY(points));
    return temp;
  }

  List<Offset> invertX(List<Offset> points) {
    List<Offset> newPoints = [];
    for (int i = 0; i < points.length; i++) {
      newPoints.add(new Offset(-points[i].dx, points[i].dy));
    }
    return newPoints;
  }

  List<Offset> invertY(List<Offset> points) {
    List<Offset> newPoints = [];
    for (int i = 0; i < points.length; i++) {
      newPoints.add(new Offset(points[i].dx, -points[i].dy));
    }
    return newPoints;
  }

  List<Offset> invertXY(List<Offset> points) {
    List<Offset> newPoints = [];
    for (int i = 0; i < points.length; i++) {
      newPoints.add(new Offset(-points[i].dx, -points[i].dy));
    }
    return newPoints;
  }

  void snapPoints() {
    /*
        if (!gridSnapping) return;
    for (int i = 0; i < mainPoints.length; i++) {
      int nearestGridIndex = 0;
      double near = double.infinity;
      for (int k = 0; k < grid!.length; k++) {
        double d = abs((grid![k] - mainPoints[i]).distance);
        if (d < near) {
          near = d;
          nearestGridIndex = k;
        }
      }
      mainPoints[i] = grid![nearestGridIndex];
    }

    recalculateLayer();*/
  }

  void setGridType(GridType _newGrid) {
    gridType = _newGrid;
    switch (_newGrid) {
      case GridType.circular:
        grid = createCircularGrid(10, 30, gridScale);
        break;
      case GridType.squared:
        grid = createSquaredGrid(gridScale, 10);
        break;
      default:
        grid = createSquaredGrid(gridScale, 10);
        break;
    }
  }

  void sortByFrame() {
    propertiesOverTime.sort((a, b) => a.frame! < b.frame! ? 0 : 1);
  }

  Color? evaluateColor(int frame) {
    Color? color1;
    Color? color2;

    for (int i = 0; i < propertiesOverTime.length; i++) {
      if (propertiesOverTime[i].frame! == frame) {
        return propertiesOverTime[i].color;
      }
      if (propertiesOverTime[i].frame! < frame) {
        color1 = propertiesOverTime[i].color;
      }
      if (propertiesOverTime[i].frame! > frame) {
        color2 = propertiesOverTime[i].color;
      }
    }
    return Color.lerp(color1, color2, 1.0);
  }

  void setColor(int frame, Color newColor) {
    bool propertyAtFrame = false;
    print("Setting Color For Frame  $frame");
    for (int i = 0; i < propertiesOverTime.length; i++) {
      if (propertiesOverTime[i].frame == frame) {
        propertyAtFrame = true;
        propertiesOverTime[i].color = newColor;
      }
    }

    if (propertyAtFrame == false) {
      print("No Property At Frame" + frame.toString());
      propertiesOverTime.add(
        LayerProperties(color: newColor, frame: frame, points: []),
      );
    }
    sortByFrame();
  }
}

void snapedPointOnEdge() {}

enum GridType { circular, squared }

class LayerProperties {
  //Main Features
  int? frame;
  List<Offset>? points;
  Color? color;

  LayerProperties({
    this.frame,
    this.points,
    this.color,
  }) {
    if (frame == null) {
      frame = 0;
    }
    if (points == null) {
      Size windowSize = getWindowSize();
      Offset first = Offset(windowSize.width / 2, 0);
      Offset second = Offset(0, 0);
      Offset third = Offset(0, windowSize.height / 2);
      points = [first, second, third];
    }
    if (color == null) {
      color = Colors.white;
    }
  }
  LayerProperties createTopLeft() {
    Size windowSize = getWindowSize();
    Offset first = Offset(windowSize.width / 2, 0);
    Offset second = Offset(0, 0);
    Offset third = Offset(0, windowSize.height / 2);
    return LayerProperties(
      color: Colors.blueGrey,
      frame: 0,
      points: [
        first,
        second,
        third,
      ],
    );
  }

  void printData() {
    print("Frame $frame   Points $points  $color");
  }

  LayerProperties createCenterLeftTop() {
    Size windowSize = getWindowSize();
    Offset first = Offset(windowSize.width / 2, 0);
    Offset second = Offset(windowSize.width / 2, windowSize.height / 2);
    Offset third = Offset(0, windowSize.height / 2);
    return LayerProperties(
      color: Colors.deepPurple,
      frame: 5,
      points: [
        first,
        second,
        third,
      ],
    );
  }
}

List<Offset> evaluatePoints(int frame, List<LayerProperties> allProperties) {
  List<Offset> evaluatedPoints = [];
  LayerProperties first = LayerProperties();
  LayerProperties second = LayerProperties();
  int previusFrame = 0;

  for (int i = 0; i < allProperties.length; i++) {
    if (frame >= allProperties[previusFrame].frame! &&
        frame <= allProperties[i].frame!) {
      second = allProperties[i];
      first = allProperties[previusFrame];
      break;
    }
    previusFrame = i;
  }

  for (int i = 0; i < second.points!.length; i++) {
    double weightTarget = frame / (second.frame! - first.frame!).toDouble();
    first.printData();
    second.printData();
    double inverseWeight = 1 - weightTarget;
    double newX = second.points![i].dx * weightTarget +
        first.points![i].dx * inverseWeight;
    double newY = second.points![i].dy * weightTarget +
        first.points![i].dy * inverseWeight;

    Offset newOffset = Offset(newX, newY);

    evaluatedPoints.add(newOffset);
  }

  return evaluatedPoints;
}
