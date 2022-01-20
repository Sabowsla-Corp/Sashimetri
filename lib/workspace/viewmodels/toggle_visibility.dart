
import 'package:flutter/material.dart';

class ToggleVisibilty extends StatelessWidget {
  const ToggleVisibilty({
    Key key,
    @required this.onToggle,
    @required this.visible,
  }) : super(key: key);
  final bool visible;
  final Function onToggle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(5),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Icon(
                getIcon(visible),
                size: 16,
                color: visible ? Colors.white : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
  IconData getIcon(bool selected) {
  return selected ? Icons.visibility : Icons.visibility_off;
}
}

