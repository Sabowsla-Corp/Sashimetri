import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sashimetriweb/models/sashimetrimodel.dart';

class GlowPainter extends CustomPainter {
  final SashimetriModel model;

  GlowPainter({this.model});

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = model.canvasCenter;
    final paint = new Paint();

    for (int i = 0; i < model.projectMetris.length; i++) {
      model.projectMetris[i].draw(paint, canvas, center);
    }
  }

  @override
  bool shouldRepaint(GlowPainter old) => model.repaintWorkspace;
}
