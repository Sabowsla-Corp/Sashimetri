import 'package:flutter/material.dart';
import 'package:sashimetri/models/app_data.dart';
import 'package:sashimetri/models/layer_model.dart';
import 'package:sashimetri/workspace/metrioptionsviews/styles.dart';
import 'package:sashimetri/workspace/viewmodels/toggle_visibility.dart';

import '../../locator.dart';

class LayerView extends StatefulWidget {
  final LayerModel layerModel;

  const LayerView({
    Key key,
    this.layerModel,
  }) : super(key: key);

  @override
  State<LayerView> createState() => _LayerViewState();
}

class _LayerViewState extends State<LayerView> {
  bool selected = false;
  void onTap() {
    locator<AppData>().selectLayer(widget.layerModel);
    setState(() {
      selected = !selected;
    });
  }

  void onToggleVisibility() {}

  @override
  Widget build(BuildContext context) {
    LayerModel layer = widget.layerModel;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: selected ? Colors.grey : Colors.grey.shade900,
      ),
 
      margin: EdgeInsets.all(2),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.layers,
                  color: Colors.white,
                  size: 18,
                ),
                Expanded(
                  child: Text(
                    layer.name,
                    style: collection,
                  ),
                ),
                ToggleVisibilty(
                  onToggle: onToggleVisibility,
                  visible: layer.visible,
                ),
              ],
            ),
          ),
          AnimatedContainer(
            height: selected ? 50: 0,
            duration: Duration(milliseconds: 500),
            child: Text("Settings"),
          ),
        ],
      ),
    );
  }
}
