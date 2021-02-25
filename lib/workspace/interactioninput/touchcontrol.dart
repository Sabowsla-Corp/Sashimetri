import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:sashimetriweb/models/sashimetrimodel.dart';
import 'package:sashimetriweb/workspace/painters/glowpainter.dart';
import 'package:sashimetriweb/workspace/painters/metripainter.dart';
import 'package:sashimetriweb/workspace/sashimetrifunctions.dart';

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
    final model = SashimetriModel.of(context, rebuild: true);

    void _handlePanStart(DragStartDetails details) {
      model.startRepaint();
      List<Offset> startPoints = model.selectedMetri.points;
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

    return Expanded(
      child: Listener(
        onPointerMove: onPointerMove,
        onPointerSignal: onPointerSignal,
        child: PageView(
          children: [
            GestureDetector(
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
          ],
        ),
      ),
    );
  }
}
