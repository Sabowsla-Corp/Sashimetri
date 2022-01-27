import 'package:flutter/material.dart';
import 'package:sashimetri/workspace/metrioptionsviews/styles.dart';

import 'toggled_romboid.dart';

class LayerPointView extends StatelessWidget {
  final Offset offset;
  final Function()? onTap;

  final BorderRadius? lBradius;
  final BorderRadius? rBradius;
  const LayerPointView({
    Key? key,
    required this.offset,
    this.lBradius,
    this.rBradius,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1),
      child: Row(
        children: [
          ToggleRomboid(onTap: onTap),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 1),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: lBradius, color: boxColor),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: lBradius,
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.all(3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(" X"),
                          Text(offset.dx.toStringAsFixed(0))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: rBradius, color: boxColor),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: rBradius,
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.all(3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(" Y"),
                          Text(offset.dy.toStringAsFixed(0))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
