import 'package:flutter/material.dart';
import 'package:sashimetri/models/app_data.dart';

class GlowPainter extends CustomPainter {
  final AppData model;

  GlowPainter({required this.model});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint();

    for (int i = 0; i < model.proyectLayers.length; i++) {
      model.proyectLayers[i].draw(paint, canvas);
    }
  }

  @override
  bool shouldRepaint(GlowPainter old) => false;
}
