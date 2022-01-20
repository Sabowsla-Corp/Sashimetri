
import 'package:flutter/material.dart';

class LayerIcon extends StatelessWidget {
  const LayerIcon({
    Key? key,
    required this.onTap,
    required this.selected,
  }) : super(key: key);

  final onTap;
  final selected;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 3, left: 3),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: Colors.white54,
                    blurRadius: 3,
                  )
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: Icon(
                Icons.layers,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
