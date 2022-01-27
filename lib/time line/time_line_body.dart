import 'package:flutter/material.dart';
import 'package:sashimetri/models/app_data.dart';
import 'package:sashimetri/workspace/metrioptionsviews/styles.dart';

class TimeLineProgressBar extends StatelessWidget {
  const TimeLineProgressBar({Key? key, required this.animationController})
      : super(key: key);
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double percent = animationController.value / animationController.upperBound;
    double pos = width * percent;
    return Container(
      color: Colors.grey.shade800,
      child: Column(
        children: [
          Divider(height: 1),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 5,
            child: Stack(
              children: [
                Positioned(
                  left: pos,
                  height: 5,
                  width: 5,
                  child: Container(
                    color: Colors.white,
                    width: 5,
                    height: 30,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1),
        ],
      ),
    );
  }
}
