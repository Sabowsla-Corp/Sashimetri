import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class TimeLineData extends Model {}

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

class TimeLineHead extends StatelessWidget {
  const TimeLineHead({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      color: Colors.grey.shade900,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TimeLineNumber(
            number: 2,
            onChange: (int newValue) {},
          ),
          TimeLineNumber(
            number: 2,
            onChange: (int newValue) {},
            prefix: " Start ",
          ),
          TimeLineNumber(
            number: 2,
            onChange: (int newValue) {},
            prefix: " End ",
          ),
        ],
      ),
    );
  }
}

class TimeLineNumber extends StatefulWidget {
  final int number;
  final String prefix;
  final Function(int newValue) onChange;
  const TimeLineNumber(
      {Key? key,
      required this.number,
      required this.onChange,
      this.prefix = ""})
      : super(key: key);

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
      padding:  EdgeInsets.symmetric(horizontal: 3),
      child: InkWell(
        onTap: () {},
        onHover: onHover,
        child: Row(
          children: [
            SideArrows(
              increment: decrement,
              hover: hover,
              isLeft: true,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade700,
              ),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Text(
                  widget.prefix + "   " + widget.number.toString() + "   ",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SideArrows(
              increment: increment,
              hover: hover,
            ),
          ],
        ),
      ),
    );
  }
}

class SideArrows extends StatefulWidget {
  const SideArrows({
    Key? key,
    required this.increment,
    required this.hover,
    this.isLeft = false,
  }) : super(key: key);

  final increment;
  final bool hover;
  final bool isLeft;

  @override
  State<SideArrows> createState() => _SideArrowsState();
}

class _SideArrowsState extends State<SideArrows> {
  var r3 = Radius.circular(3);
  @override
  Widget build(BuildContext context) {
    var rightBox = BoxDecoration(
      borderRadius: BorderRadius.only(topRight: r3, bottomRight: r3),
      color: Colors.grey.shade700,
    );
    var leftBox = BoxDecoration(
      borderRadius: BorderRadius.only(topLeft: r3, bottomLeft: r3),
      color: Colors.grey.shade700,
    );
    return Container(
      decoration: widget.isLeft ? leftBox : rightBox,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.only(topRight: r3, bottomRight: r3),
          onTap: widget.increment,
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Text(
              widget.isLeft ? " < " : " > ",
              style: TextStyle(
                fontSize: 13,
                color: widget.hover ? Colors.white : Colors.white10,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
