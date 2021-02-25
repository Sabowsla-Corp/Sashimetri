import 'package:flutter/material.dart';
import 'package:sashimetriweb/workspace/metrioptionsviews/styles.dart';

class CollectionObject extends StatelessWidget {
  final height;
  final Color bgColor;
  final Color inactiveIconColor;
  @required
  final Widget leadingIcon;
  @required
  final IconData activeIcon;
  @required
  final IconData inactiveIcon;
  final String title;
  final bool visible;
  final onToggle;
  final onSelect;
  final margin;
  const CollectionObject({
    Key key,
    this.height: 30,
    this.margin,
    this.bgColor: Colors.black38,
    this.inactiveIconColor: Colors.white,
    this.leadingIcon,
    this.inactiveIcon,
    this.activeIcon,
    this.title: "No Name",
    this.visible: true,
    this.onToggle,
    this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      color: bgColor,
      height: height,
      margin: margin,
      child: InkWell(
        onTap: onSelect,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (leadingIcon != null) leadingIcon,
            Text(
              title,
              style: collection,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  child: Icon(
                    visible ? activeIcon : inactiveIcon,
                    size: 16,
                    color: visible ? Colors.white : inactiveIconColor,
                  ),
                  onTap: onToggle,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
