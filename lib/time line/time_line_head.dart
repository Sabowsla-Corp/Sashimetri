import 'package:flutter/material.dart';
import 'package:sashimetri/models/app_data.dart';
import 'package:sashimetri/workspace/metrioptionsviews/styles.dart';
import 'time_line_number.dart';

class TimeLineHead extends StatelessWidget {
  const TimeLineHead({
    Key? key,
    this.onAnimate,
    this.onStopAnimate,
    required this.controllerInfo,
  }) : super(key: key);
  final Function()? onAnimate;
  final Function()? onStopAnimate;
  final AnimationController controllerInfo;
  @override
  Widget build(BuildContext context) {
    AppData appData = AppData.of(context);
    return Container(
      padding: EdgeInsets.all(4),
      color: Colors.grey.shade900,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: boxColor,
                ),
                child: Center(
                  child: InkWell(
                    onTap: onAnimate,
                    child: controllerInfo.isAnimating
                        ? Container(
                            width: 20,
                            height: 20,
                            padding: EdgeInsets.all(3),
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                              value: controllerInfo.value -
                                  controllerInfo.value.floor(),
                            ),
                          )
                        : Text(
                            "  Animate!  ",
                            style: timeLineNumberStyle,
                          ),
                  ),
                ),
              ),
              Container(
                height: 22,
                margin: EdgeInsets.only(left: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: boxColor,
                ),
                child: Center(
                  child: InkWell(
                    onTap: onStopAnimate,
                    child: Text(
                      "  Stop  ",
                      style: timeLineNumberStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TimeLineNumber(
                number: controllerInfo.value.toInt(),
                onChange: (int newValue) {},
                padding: EdgeInsets.symmetric(horizontal: 5),
              ),
              TimeLineNumber(
                number: appData.timeLineData.duration,
                onChange: (int newValue) {},
                prefix: " Duration ",
                padding: EdgeInsets.only(right: 5),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
