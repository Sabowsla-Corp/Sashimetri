import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sashimetri/models/app_data.dart';
import 'package:scoped_model/scoped_model.dart';

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
              rightBorder: widget.rightBorder,
            ),
          ],
        ),
      ),
    );
  }
}
