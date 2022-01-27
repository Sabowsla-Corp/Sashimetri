import 'dart:math';

import 'package:flutter/material.dart';

class ToggleRomboid extends StatelessWidget {
  const ToggleRomboid({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    double size = 8;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Transform.rotate(
        angle: pi / 4,
        child: Container(
          width: size,
          height: size,
          color: Colors.grey.shade600,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Container(
                margin: EdgeInsets.all(2),
                width: size - 4,
                height: size - 4,
                child: Text(""),
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
