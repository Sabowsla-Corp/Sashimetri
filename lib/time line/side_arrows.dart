import 'package:flutter/material.dart';

class SideArrows extends StatefulWidget {
  const SideArrows({
    Key? key,
    required this.increment,
    required this.hover,
    this.leftBorder = false,
    this.rightBorder = false,
    this.isLeft = false,
    this.toolTip = "Change Value",
  }) : super(key: key);

  final increment;
  final bool hover;
  final bool isLeft;
  final bool leftBorder;
  final bool rightBorder;
  final String toolTip;
  @override
  State<SideArrows> createState() => _SideArrowsState();
}

class _SideArrowsState extends State<SideArrows> {
  var r4 = Radius.circular(4);
  @override
  Widget build(BuildContext context) {
    var leftBox = BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: widget.leftBorder ? r4 : Radius.zero,
        bottomLeft: widget.leftBorder ? r4 : Radius.zero,
        topRight: widget.rightBorder ? r4 : Radius.zero,
        bottomRight: widget.rightBorder ? r4 : Radius.zero,
      ),
      color: Colors.grey.shade700,
    );
    return Tooltip(
      message: widget.toolTip,
      child: Container(
        decoration: leftBox,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.only(topRight: r4, bottomRight: r4),
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
      ),
    );
  }
}
