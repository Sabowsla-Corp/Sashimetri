import 'package:flutter/material.dart';
import 'package:sashimetri/models/app_data.dart';

class TouchControlPainter extends CustomPainter {
  final AppData model;

  TouchControlPainter({required this.model});

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = model.canvasCenter;
    final paint = new Paint();
    paint.blendMode = model.blendMode;
    for (int i = 0; i < model.proyectLayers.length; i++) {
      print(model.proyectLayers.first.points.length);
      model.proyectLayers[i].draw(paint, canvas, center);
    }
  }

  @override
  bool shouldRepaint(TouchControlPainter old) => false;
}
