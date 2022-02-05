import 'package:flutter/material.dart';
import 'package:sashimetri/models/app_data.dart';

class TouchControlPainter extends CustomPainter {
  final AppData model;

  TouchControlPainter({required this.model});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint();
    paint.blendMode = model.blendMode;
    for (int i = 0; i < model.proyectLayers.length; i++) {
      model.proyectLayers.forEach((layer) {
        layer.draw(paint, canvas, model.timeLineData.frame);
      });
    }
  }

  @override
  bool shouldRepaint(TouchControlPainter old) => true;
}
