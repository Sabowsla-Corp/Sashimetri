import 'package:flutter/material.dart';
import 'package:sashimetriweb/models/sashimetrimodel.dart';

class TouchControlPainter extends CustomPainter {
  final SashimetriModel model;

  TouchControlPainter({this.model});

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = model.canvasCenter;
    final paint = new Paint();
    paint.blendMode = model.blendMode;
    for (int i = 0; i < model.projectMetris.length; i++) {
      model.projectMetris[i].draw(paint, canvas, center);
    }
  }

  @override
  bool shouldRepaint(TouchControlPainter old) => model.repaintWorkspace;
}
