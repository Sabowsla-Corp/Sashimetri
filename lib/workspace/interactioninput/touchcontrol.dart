import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sashimetri/models/app_data.dart';
import 'package:sashimetri/workspace/painters/glowpainter.dart';
import 'package:sashimetri/workspace/painters/metripainter.dart';

import '../sashimetrifunctions.dart';

class TouchControl extends StatefulWidget {
  final ValueChanged<Offset> onChanged;

  const TouchControl({this.onChanged, Key key}) : super(key: key);

  @override
  TouchControlState createState() => new TouchControlState();
}

class TouchControlState extends State<TouchControl> {
  TouchControlState();

  int nearestMetriIndex = 0;

  @override
  Widget build(BuildContext context) {
    final model = AppData.of(context, rebuild: true);

    void _handlePanStart(DragStartDetails details) {
      model.startRepaint();
      List<Offset> startPoints = model.selectedLayer.points;
      setState(
        () {
          nearestMetriIndex = nearestPointToTouch(
              details.localPosition - model.canvasCenter, startPoints);
        },
      );
    }

    void _handlePanUpdate(DragUpdateDetails details) {
      model.startRepaint();
      if (model.onTranslateMode) {
        model.moveCenterByDelta(details.delta);
      } else {
        model.dragMetriPoint(details.delta, nearestMetriIndex);
      }
    }

    void _handlePanEnd(DragEndDetails details) {
      model.snapMetriToItsGrid();
      model.stopRepaint();
    }

    void onPointerMove(PointerEvent details) {

      if (details.buttons == 4) model.moveCenterByDelta(details.delta);
    }

    void onPointerSignal(PointerSignalEvent details) {
      PointerScrollEvent scrollEvent = details;

      model.ajustarEscalaCuadricula(scrollEvent.scrollDelta.dy / 100);
    }

    return Listener(
      onPointerMove: onPointerMove,
      onPointerSignal: onPointerSignal,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanStart: _handlePanStart,
        onPanEnd: _handlePanEnd,
        onPanUpdate: _handlePanUpdate,
        child: Stack(
          children: [
            CustomPaint(
              size: Size(1080, 1920),
              painter: GlowPainter(
                model: model,
              ),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: model.glowSize,
                  sigmaY: model.glowSize,
                ),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            CustomPaint(
              size: Size(1080, 1920),
              painter: TouchControlPainter(
                model: model,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
