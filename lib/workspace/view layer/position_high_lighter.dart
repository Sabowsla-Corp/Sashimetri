import 'package:flutter/material.dart';

class PositionHighLighter extends StatefulWidget {
  PositionHighLighter({Key? key, required this.offset}) : super(key: key);
  final Offset offset;
  @override
  _PositionHighLighterState createState() => _PositionHighLighterState();
}

class _PositionHighLighterState extends State<PositionHighLighter> {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill
    (
    
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height*0.5,
        decoration: BoxDecoration(color: Colors.green),
        child: Text(""),
      ),
    );
  }
}

enum direction { top, left, right, bottom }
