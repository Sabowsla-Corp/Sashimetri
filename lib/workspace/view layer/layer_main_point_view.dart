import 'package:flutter/material.dart';

import 'package:sashimetri/workspace/metrioptionsviews/styles.dart';

import 'layer_point_view.dart';

class LayerMainPointsView extends StatelessWidget {
  final List<Offset> mainPoints;
  final bool expanded;
  const LayerMainPointsView({
    Key? key,
    required this.mainPoints,
    this.expanded = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (expanded)
          Text(
            " Position",
            style: timeLineNumberStyle,
          ),
        if (expanded) ...buildPoints(),
      ],
    );
  }

  List<Widget> buildPoints() {
    List<Widget> list = [];
    for (int i = 0; i < mainPoints.length; i++) {
      BorderRadius left = BorderRadius.circular(0);
      BorderRadius right = BorderRadius.circular(0);
      if (i == 0) {
        var r5 = Radius.circular(5);
        left = BorderRadius.only(topLeft: r5);
        right = BorderRadius.only(topRight: r5);
      }
      if (i == mainPoints.length - 1) {
        var r5 = Radius.circular(5);
        left = BorderRadius.only(bottomLeft: r5);
        right = BorderRadius.only(bottomRight: r5);
      }
      list.add(LayerPointView(
        offset: mainPoints[i],
        onTap: () {},
        lBradius: left,
        rBradius: right,
      ));
      //if (i < mainPoints.length) list.add(Divider(height: 1));
    }
    return list;
  }
}
