import 'package:flutter/material.dart';
import 'package:sashimetri/workspace/metrioptionsviews/styles.dart';
import 'side_arrows.dart';

class TimeLineNumber extends StatefulWidget {
  final int number;
  final String prefix;
  final EdgeInsetsGeometry padding;
  final Function(int newValue) onChange;
  final bool rightBorder;
  final bool leftBorder;

  const TimeLineNumber({
    Key? key,
    required this.number,
    required this.onChange,
    this.prefix = "",
    required this.padding,
    this.rightBorder = true,
    this.leftBorder = true,
  }) : super(key: key);

  @override
  State<TimeLineNumber> createState() => _TimeLineNumberState();
}

class _TimeLineNumberState extends State<TimeLineNumber> {
  bool hover = false;

  void decrement() {
    int newNuymber = widget.number - 1;
    widget.onChange(newNuymber);
  }

  void increment() {
    int newNuymber = widget.number + 1;
    widget.onChange(newNuymber);
  }

  void onHover(bool e) {
    setState(() {
      hover = e;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: InkWell(
        onTap: () {},
        onHover: onHover,
        child: Row(
          children: [
            SideArrows(
              increment: decrement,
              hover: hover,
              isLeft: true,
              leftBorder: widget.leftBorder,
              toolTip: "Remove 1 Second",
            ),
            Tooltip(
              message: "Duration in Seconds",
              child: Container(
                decoration: BoxDecoration(
                  color: boxColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    widget.prefix + "   " + widget.number.toString() + "   ",
                    style: timeLineNumberStyle,
                  ),
                ),
              ),
            ),
            SideArrows(
              increment: increment,
              hover: hover,
              rightBorder: widget.rightBorder,
              toolTip: "Add 1 Second",
            ),
          ],
        ),
      ),
    );
  }
}
