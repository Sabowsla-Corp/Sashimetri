import 'package:flutter/material.dart';
import 'package:sashimetri/models/app_data.dart';
import 'package:sashimetri/workspace/layers_dragger.dart';

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
    final model = AppData.of(context);
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

class DragablePanel extends StatefulWidget {
  DragablePanel({Key? key}) : super(key: key);

  @override
  _DragablePanelState createState() => _DragablePanelState();
}

class _DragablePanelState extends State<DragablePanel> {
  bool onDrag = false;

  @override
  Widget build(BuildContext context) {
    final model = AppData.of(context);
    return Draggable(
      child: Container(
        color: Colors.transparent,
      ),
      feedback: Container(
        child: DragItem(),
      ),
      childWhenDragging: Container(
        child: DragItem(),
      ),
    );
  }
}

class ToolsPanel extends StatelessWidget {
  const ToolsPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade700,
      child: Container(
        width: 350,
        child: Column(
          children: [
            Container(
              height: 1,
              color: Colors.grey.shade800,
            ),
            Container(
              height: 1,
              color: Colors.grey.shade800,
            ),
            Container(
              height: 1,
              color: Colors.grey.shade800,
            ),
            //BlendModeWidget(),
          ],
        ),
      ),
    );
  }
}

class DragItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.view_headline,
      size: 30,
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

