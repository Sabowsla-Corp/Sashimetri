import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sashimetri/models/app_data.dart';
import 'package:sashimetri/time%20line/time_line_body.dart';
import 'package:sashimetri/time%20line/time_line_data.dart';

import 'time_line_head.dart';

class TimeLineInspector extends StatefulWidget {
  final AppData appData;
  const TimeLineInspector({Key? key, required this.appData}) : super(key: key);

  @override
  State<TimeLineInspector> createState() => _TimeLineInspectorState();
}

class _TimeLineInspectorState extends State<TimeLineInspector>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    TimeLineData timeLineData = widget.appData.timeLineData;
    animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: timeLineData.getMilis(),
      ),
      lowerBound: 0,
      upperBound: timeLineData.duration.toDouble(),
    );
    animationController.addListener(() {
      setState(() {
        widget.appData
            .updateTimeLineFrame(animationController.value.truncate());
      });
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void onAnimate() {
    print("On animate");
    setState(() {});
    animationController.repeat();
  }

  void onStopAnimation() {
    print("Animation Stoped");
    setState(() {});
    animationController.stop();
  }

  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TimeLineProgressBar(
          animationController: animationController,
        ),
        TimeLineHead(
          controllerInfo: animationController,
          onAnimate: onAnimate,
          onStopAnimate: onStopAnimation,
        ),
      ],
    );
  }
}
