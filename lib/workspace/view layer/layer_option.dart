import 'package:flutter/material.dart';

class LayerOption extends StatefulWidget {
  final onTap;
  final String icon;
  final bool enabled;
  final bool visible;
  final String? toolTip;

  LayerOption({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.enabled,
    required this.visible,
    this.toolTip,
  }) : super(key: key);

  @override
  _LayerOptionState createState() => _LayerOptionState();
}

class _LayerOptionState extends State<LayerOption> {
  @override
  Widget build(BuildContext context) {
    return !widget.visible
        ? Container()
        : Tooltip(
            message: widget.toolTip,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Container(
                width: 22,
                height: 22,
                color: widget.enabled ? Colors.white24 : Colors.white10,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: widget.onTap,
                    child: Padding(
                      padding: EdgeInsets.all(2),
                      child: Image.asset(
                        widget.icon,
                        color: widget.enabled ? Colors.white : Colors.white30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
