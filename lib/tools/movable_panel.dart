import 'package:flutter/material.dart';
import 'package:sashimetri/workspace/layer%20dragger/layers_dragger.dart';

import 'custom_drag_target.dart';
import 'drag_points.dart';
import 'movable_panel_clippers.dart';

class MovablePanel extends StatefulWidget {
  MovablePanel({Key? key}) : super(key: key);

  @override
  _MovablePanelState createState() => _MovablePanelState();
}

class _MovablePanelState extends State<MovablePanel> {
  DragPoints previewPosition = DragPoints.right;

  @override
  Widget build(BuildContext context) {
    bool onDragView = true;
    return Stack(
      children: [
        if (onDragView) BottomDropPreview(),
        if (onDragView) TopDropPreview(),
        if (onDragView) LeftDropPreview(),
        if (onDragView) RightDropPreview(),
        LayersDragger(),
      ],
    );
  }
}

class RightDropPreview extends StatelessWidget {
  const RightDropPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(),
          flex: 6,
        ),
        CustomDragTarget(
          dragablePosition: DragPoints.right,
          clipper: RightClipper(),
          boxConstraints: BoxConstraints(
            maxWidth: 80,
            maxHeight: double.infinity,
          ),
        ),
      ],
    );
  }
}

class LeftDropPreview extends StatelessWidget {
  const LeftDropPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomDragTarget(
          dragablePosition: DragPoints.left,
          clipper: LeftCliper(),
          boxConstraints: BoxConstraints(
            maxWidth: 80,
            maxHeight: double.infinity,
          ),
        ),
        Expanded(
          child: Container(),
          flex: 6,
        ),
      ],
    );
  }
}

class TopDropPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDragTarget(
          dragablePosition: DragPoints.top,
          clipper: TopClipper(),
          boxConstraints: BoxConstraints(
            maxHeight: 80,
            maxWidth: double.infinity,
          ),
        ),
        Expanded(
          child: Container(),
          flex: 6,
        ),
      ],
    );
  }
}

class BottomDropPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(),
          flex: 6,
        ),
        CustomDragTarget(
          dragablePosition: DragPoints.bottom,
          clipper: BottomClipper(),
          boxConstraints: BoxConstraints(
            maxHeight: 80,
            maxWidth: double.infinity,
          ),
        ),
      ],
    );
  }
}
