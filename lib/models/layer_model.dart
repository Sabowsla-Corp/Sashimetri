import 'package:flutter/material.dart';
import 'package:sashimetri/workspace/sashi_functions.dart';

class LayerModel {
  List<Offset> points;
  Color color;
  double thickness;
  bool visible;
  String name;
  bool symetryc;
  bool gridSnapping;
  GridType gridType;
  List<Offset> grid;
  bool selected;
  double gridScale = 50;
  Color currentColor = Colors.white10;
  double maxGlow = 5;
  double glowSize = 2;
  double minGlow = 0;
  int gridExtent = 20;
  int radialDivisions = 20;
  int subdivisions;

  LayerModel({
    required this.points,
    this.color: Colors.white,
    this.name: "Capa 0",
    this.selected: true,
    this.thickness: 1,
    this.visible: true,
    this.subdivisions: 10,
    this.symetryc: true,
    this.gridSnapping: false,
    this.gridType: GridType.squared,
    required this.grid,
  }) {
    points = [
      Offset(300, 0),
      Offset(0, 0),
      Offset(0, 300),
    ];
    setGridType(gridType);
  }

  void changeColor(Color newColor) {
    color = newColor;
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
    for (int i = 0; i < points.length; i++) {
      int nearestGridIndex = 0;
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

  void setGridType(GridType _newGrid) {
    print("Set up Grid Type");
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
