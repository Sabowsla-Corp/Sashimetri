import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'time_line_head.dart';

class TimeLineInspector extends StatelessWidget {
  const TimeLineInspector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TimeLineHead(),
      ],
    );
  }
}
