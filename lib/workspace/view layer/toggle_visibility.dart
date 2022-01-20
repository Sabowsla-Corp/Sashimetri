import 'package:flutter/material.dart';

class ToggleVisibilty extends StatefulWidget {
  const ToggleVisibilty({
    Key? key,
    required this.onToggle,
    required this.visible,
  }) : super(key: key);
  final bool visible;
  final onToggle;

  @override
  State<ToggleVisibilty> createState() => _ToggleVisibiltyState();
}

class _ToggleVisibiltyState extends State<ToggleVisibilty> {
  bool hover = false;
  void onHover(bool e) {
    setState(() {
      hover = e;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: hover ? Colors.white30 : Colors.white10,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onToggle,
          borderRadius: BorderRadius.circular(5),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Icon(
              getIcon(widget.visible),
              size: 16,
              color: widget.visible ? Colors.white : Colors.grey,
            ),
          ),
          onHover: onHover
        ),
      ),
    );
  }

  IconData getIcon(bool selected) {
    return selected ? Icons.visibility : Icons.visibility_off;
  }
}
