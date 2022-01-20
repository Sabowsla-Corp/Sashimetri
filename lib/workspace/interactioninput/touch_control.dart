import 'package:flutter/material.dart';
import 'package:sashimetri/models/app_data.dart';
import 'package:sashimetri/workspace/painters/touch_control_painter.dart';

import '../sashi_functions.dart';

class TouchControl extends StatefulWidget {
  const TouchControl({Key? key}) : super(key: key);

  @override
  TouchControlState createState() => new TouchControlState();
}

class TouchControlState extends State<TouchControl> {
  int nearestMetriIndex = 0;

  @override
  Widget build(BuildContext context) {
    /*
    final model = AppData.of(context, rebuild: true);

    void _handlePanStart(DragStartDetails details) {
      print(model.selectedLayer.points);
      List<Offset> startPoints = model.selectedLayer.points;
      print(startPoints);
      setState(
        () {
          nearestMetriIndex = nearestPointToTouch(
              details.localPosition - model.canvasCenter, startPoints);
        },
      );
    }

    void _handlePanUpdate(DragUpdateDetails details) {
      if (true) {
        model.moveCenterByDelta(details.delta);
      } else {
        model.dragMetriPoint(details.delta, nearestMetriIndex);
      }
    }

    void _handlePanEnd(DragEndDetails details) {
      model.snapMetriToItsGrid();
    }

    void onPointerMove(PointerEvent details) {
      if (details.buttons == 4) model.moveCenterByDelta(details.delta);
    }


    void onPointerSignal(PointerSignalEvent details) {
      PointerScrollEvent scrollEvent = details;

      model.ajustarEscalaCuadricula(scrollEvent.scrollDelta.dy / 100);
    }
*/    

final model = AppData.of(context, rebuild: true);
    return Listener(
      //onPointerMove: onPointerMove,
      // onPointerSignal: onPointerSignal,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
      //  onPanStart: _handlePanStart,
      //  onPanEnd: _handlePanEnd,
      //  onPanUpdate: _handlePanUpdate,
        child: CustomPaint(
          size: Size(1080, 1920),
          painter: TouchControlPainter(
            model: model,
          ),
        ),
      ),
    );
  }
}
