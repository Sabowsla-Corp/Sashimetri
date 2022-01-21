import 'package:flutter/material.dart';
import 'package:sashimetri/models/app_data.dart';
import 'package:sashimetri/models/layer_model.dart';

class TouchControlPainter extends CustomPainter {
  final AppData model;

  TouchControlPainter({required this.model});

  @override
  void paint(Canvas canvas, Size size) {
    
    final paint = new Paint();
    paint.blendMode = model.blendMode;
    for (int i = 0; i < model.proyectLayers.length; i++) {
      LayerModel layer = model.proyectLayers[i];
      if (layer.visible) {
        paint.color = layer.color;
        paint.strokeWidth = layer.thickness + 1;
        for (int i = 0; i <= layer.subdivisions; i++) {
          canvas.drawLine(
            layer.starts![i] + layer.center!,
            layer.ends![i] +  layer.center!,
            paint,
          );
        }
      }

      
    }
  }

  @override
  bool shouldRepaint(TouchControlPainter old) => true;
}
