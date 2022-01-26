import 'dart:html';

import 'package:flutter/material.dart';
import 'package:sashimetri/models/app_data.dart';

import 'drag_points.dart';
import 'movable_panel.dart';

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
  @override
  Widget build(BuildContext context) {
    final model = AppData.of(context);
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
onMove: (dynamic shiMoived){

  print("Shit Moved");
},
onWillAccept: (dynamic ibje){
  print("ill accept");
   return true;
},
            builder: (context, info1, info2) {
              return Container(
                color: Colors.greenAccent,
                child: Text("sadasdasdasd"),
              );
            },
          ),
        ),
      ),
    );
  }
}
