import 'package:flutter/material.dart';

import 'drag_points.dart';

class CustomDragTarget extends StatefulWidget {
  final BoxConstraints boxConstraints;
  final DragPoints dragablePosition;
  final clipper;
  CustomDragTarget(
      {Key? key,
      this.clipper,
      required this.boxConstraints,
      required this.dragablePosition})
      : super(key: key);

  @override
  _CustomDragTargetState createState() => _CustomDragTargetState();
}

class _CustomDragTargetState extends State<CustomDragTarget> {
  Duration d500 = Duration(milliseconds: 500);
  Curve ease = Curves.ease;
  bool onHover = false;
  void onMove(dynamic e) {
    setState(() {
      onHover = true;
    });
  }

  void onLeave(dynamic e) {
    setState(() {
      onHover = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: widget.boxConstraints,
      child: ClipPath(
        clipper: widget.clipper,
        child: AnimatedContainer(
          duration: d500,
          width: double.infinity,
          height: double.infinity,
          curve: ease,
          decoration: BoxDecoration(
            color: onHover
                ? Colors.white.withAlpha(60)
                : Colors.black.withAlpha(30),
          ),
          child: DragTarget(
            onAccept: (dynamic panelInfReference) {
              print("Panel Accepted");
            },
            onMove: onMove,
            onLeave: onLeave,
            builder: (context, info1, info2) {
              return Container(
                color: Colors.transparent,
                child: Text(""),
              );
            },
          ),
        ),
      ),
    );
  }
}
