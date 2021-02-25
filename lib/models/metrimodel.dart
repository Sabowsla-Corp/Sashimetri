import 'package:flutter/material.dart';
import 'package:sashimetriweb/workspace/sashimetrifunctions.dart';

class Metri {
  List<Offset> points;
  Color color;
  double thickness;
  bool visible;

  bool symetryc;
  bool gridSnapping;
  GridType gridType;
  List<Offset> grid;
  bool selected;

  int subdivisions;

  Metri({
    this.points,
    this.color,
    this.selected: false,
    this.thickness: 1,
    this.visible: true,
    this.subdivisions: 10,
    this.symetryc: true,
    this.gridSnapping: false,
    this.gridType: GridType.squared,
    @required this.grid,
  });

  void changeColor(Color newColor) {
    color = newColor;
  }

  void toggleVisibility() {
    visible = !visible;
  }

  void draw(Paint paint, Canvas canvas, Offset center) {
    if (!visible) return;
    if (selected) drawOutline(paint, canvas, center);
    paint.color = color;
    paint.strokeWidth = thickness;
    List<Offset> starts = fillStartPoints(subdivisions, points);
    List<Offset> ends = fillEndPoints(subdivisions, points);
    for (int i = 0; i <= subdivisions; i++) {
      canvas.drawLine(starts[i] + center, ends[i] + center, paint);
    }
    if (symetryc) _drawSymetry(paint, canvas, center);
    if (gridSnapping && selected) drawGrid(paint, canvas, center);
  }

  void drawOutline(Paint paint, Canvas canvas, Offset center) {
    paint.color = Colors.amber;
    paint.strokeWidth = thickness + 1;
    List<Offset> starts = fillStartPoints(subdivisions, points);
    List<Offset> ends = fillEndPoints(subdivisions, points);
    for (int i = 0; i <= subdivisions; i++) {
      canvas.drawLine(starts[i] + center, ends[i] + center, paint);
    }
  }

  void drawGrid(Paint paint, Canvas canvas, Offset center) {
    grid.forEach((element) {
      canvas.drawCircle(element + center, 2, paint);
    });
  }

  void _drawSymetry(Paint paint, Canvas canvas, Offset center) {
    var symetrycPoints = symetrycMetriPoints(points);
    symetrycPoints.forEach((symetrycPoint) {
      paint.color = color;
      List<Offset> starts = fillStartPoints(subdivisions, symetrycPoint);
      List<Offset> ends = fillEndPoints(subdivisions, symetrycPoint);
      for (int i = 0; i <= subdivisions; i++) {
        canvas.drawLine(starts[i] + center, ends[i] + center, paint);
      }
    });
  }

  List<List<Offset>> symetrycMetriPoints(points) {
    List<List<Offset>> temp = List<List<Offset>>();
    temp.add(invertX(points));
    temp.add(invertY(points));
    temp.add(invertXY(points));
    return temp;
  }

  List<Offset> invertX(List<Offset> points) {
    List<Offset> newPoints = List();
    for (int i = 0; i < points.length; i++) {
      newPoints.add(new Offset(-points[i].dx, points[i].dy));
    }
    return newPoints;
  }

  List<Offset> invertY(List<Offset> points) {
    List<Offset> newPoints = List();
    for (int i = 0; i < points.length; i++) {
      newPoints.add(new Offset(points[i].dx, -points[i].dy));
    }
    return newPoints;
  }

  List<Offset> invertXY(List<Offset> points) {
    List<Offset> newPoints = List();
    for (int i = 0; i < points.length; i++) {
      newPoints.add(new Offset(-points[i].dx, -points[i].dy));
    }
    return newPoints;
  }

  void snapPoints() {
    for (int i = 0; i < points.length; i++) {
      int nearestGridIndex;
      double near = double.infinity;
      for (int k = 0; k < grid.length; k++) {
        double d = abs((grid[k] - points[i]).distance);
        if (d < near) {
          near = d;
          nearestGridIndex = k;
        }
      }
      points[i] = grid[nearestGridIndex];
    }
  }

  void calculateGrid() {
    switch (gridType) {
      case GridType.circular:
        grid = createCircularGrid(10, 30, 50);
        break;
      case GridType.squared:
        grid = createSquaredGrid(50, 10);
        break;
      default:
        grid = createSquaredGrid(50, 10);
        break;
    }
  }
}

void snapedPointOnEdge() {}

enum GridType {
  circular,

  squared
}
