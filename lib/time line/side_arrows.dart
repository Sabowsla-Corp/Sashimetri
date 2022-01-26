import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sashimetri/models/app_data.dart';
import 'package:scoped_model/scoped_model.dart';

class SideArrows extends StatefulWidget {
  const SideArrows({
    Key? key,
    required this.increment,
    required this.hover,
    this.leftBorder = false,
    this.rightBorder = false,
    this.isLeft = false,
  }) : super(key: key);

  final increment;
  final bool hover;
  final bool isLeft;
  final bool leftBorder;
  final bool rightBorder;

  @override
  State<SideArrows> createState() => _SideArrowsState();
}

class _SideArrowsState extends State<SideArrows> {
  var r3 = Radius.circular(4);
  @override
  Widget build(BuildContext context) {
    var leftBox = BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: widget.leftBorder ? r3 : Radius.zero,
        bottomLeft: widget.leftBorder ? r3 : Radius.zero,
        topRight: widget.rightBorder ? r3 : Radius.zero,
        bottomRight: widget.rightBorder ? r3 : Radius.zero,
      ),
      color: Colors.grey.shade700,
    );
    return Container(
      decoration: leftBox,
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
