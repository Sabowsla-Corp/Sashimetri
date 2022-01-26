import 'package:flutter/material.dart';
import 'package:sashimetri/models/app_data.dart';
import 'time_line_number.dart';

class TimeLineHead extends StatelessWidget {
  const TimeLineHead({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppData appData = AppData.of(context);
    return Container(
      padding: EdgeInsets.all(4),
      color: Colors.grey.shade900,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TimeLineNumber(
            number: appData.currentFrame,
            onChange: (int newValue) {},
            padding: EdgeInsets.symmetric(horizontal: 5),
          ),
          TimeLineNumber(
            number: appData.startFrame,
            onChange: (int newValue) {},
            prefix: " Start ",
            rightBorder: false,
            padding: EdgeInsets.only(left: 5, right: 1),
          ),
          TimeLineNumber(
            number: appData.endFrame,
            onChange: (int newValue) {},
            prefix: " End ",
            leftBorder: false,
            padding: EdgeInsets.only(right: 5),
          ),
        ],
      ),
    );
  }
}
