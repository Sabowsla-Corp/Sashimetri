import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sashimetri/locator.dart';
import 'package:sashimetri/models/app_data.dart';
import 'package:sashimetri/workspace/sashi_functions.dart';

class LayerModel {
  List<Offset>? grid;
  List<Offset>? mainPoints;
  List<Offset>? starts;
  List<Offset>? ends;

  Offset center = Offset(250, 250);
  Color color;
  double thickness;
  bool visible;
  String name;
  bool symetryc;
  bool gridSnapping;
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
    this.mainPoints,
    this.color: Colors.pink,
    this.name: "Layer",
    this.selected: false,
    this.thickness: 1,
    this.visible: true,
    this.subdivisions: 10,
    this.symetryc: true,
    this.gridSnapping: false,
    this.gridType: GridType.squared,
    this.grid,
  }) {
    mainPoints = [
      Offset(300, 0),
      Offset(0, 0),
      Offset(0, 300),
    ];
    starts = fillStartPoints(subdivisions, mainPoints);
    ends = fillEndPoints(subdivisions, mainPoints);
    center = Offset(250, 250);
    setGridType(gridType);
  }

  void changeColor(Color newColor) {
    color = newColor;
  }

  LayerModel randomLayer() {
    double randomX = Random.secure().nextDouble() * 300;
    return LayerModel(
      mainPoints: [
        Offset(randomX, randomX),
        Offset(-randomX, 0),
        Offset(randomX, randomX),
      ],
      selected: true,
      grid: createSquaredGrid(50, 10),
    );
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

  void deselect() => selected = false;
  void select() => selected = true;

  void draw(Paint paint, Canvas canvas, Offset center) {
    /*
    if (!visible) return;

    if (selected) {
      paint.color = Colors.amber;
      paint.strokeWidth = thickness + 1;
      for (int i = 0; i <= subdivisions; i++) {
        print("Start $i " + starts[i].toString());
        print("Center " + center.toString());
        print("End $i " + ends[i].toString());
        canvas.drawLine(starts[i] + center, ends[i] + center, paint);
      }
    }
  
    paint.color = color;
    paint.strokeWidth = thickness;

    for (int i = 0; i <= subdivisions; i++) {
      canvas.drawLine(starts[i] + center, ends[i] + center, paint);
    }
    if (symetryc) _drawSymetry(paint, canvas, center);
   if (gridSnapping && selected) drawGrid(paint, canvas, center);
   */
  }
  void dragPoint(int index, Offset delta) {
    mainPoints![index] += delta;
  }

  void drawGrid(Paint paint, Canvas canvas, Offset center) {
    /* print("Drawing Grid");
    grid.forEach((element) {
         canvas.drawCircle(element + center, 2, paint);
    });
    */
  }

  void _drawSymetry(Paint paint, Canvas canvas, Offset center) {
    /*
    var symetrycPoints = symetrycMetriPoints(mainPoints);
    symetrycPoints.forEach((symetrycPoint) {
      paint.color = color;
      List<Offset> starts = fillStartPoints(subdivisions, symetrycPoint);
      List<Offset> ends = fillEndPoints(subdivisions, symetrycPoint);
      for (int i = 0; i <= subdivisions; i++) {
        //canvas.drawLine(starts[i] + center, ends[i] + center, paint);
      }
    });
    */
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
    print("SnapingPoints");
    for (int i = 0; i < mainPoints.length; i++) {
      int nearestGridIndex = 0;
      double near = double.infinity;
      for (int k = 0; k < grid.length; k++) {
        double d = abs((grid[k] - mainPoints[i]).distance);
        if (d < near) {
          near = d;
          nearestGridIndex = k;
        }
      }
      mainPoints[i] = grid[nearestGridIndex];
    }
    */
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
}

void snapedPointOnEdge() {}

enum GridType { circular, squared }
