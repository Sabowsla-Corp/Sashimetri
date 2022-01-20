import 'package:flutter/material.dart';
import 'package:sashimetri/models/app_data.dart';
import 'package:sashimetri/models/layer_model.dart';
import 'package:sashimetri/workspace/metrioptionsviews/styles.dart';

import '../../locator.dart';
import 'delete_layer.dart';
import 'layer_icon.dart';
import 'toggle_visibility.dart';

class LayerView extends StatefulWidget {
  final LayerModel layerModel;
  const LayerView({
    Key? key,
    required this.layerModel,
  }) : super(key: key);

  @override
  State<LayerView> createState() => _LayerViewState();
}

class _LayerViewState extends State<LayerView> {
  bool expanded = false;

  void onSelect() {
    locator<AppData>().selectLayer(widget.layerModel);
  }

  void onExpand(bool e) {
    setState(() => expanded = !expanded);
  }

  void onChangeText() {}

  void onToggleVisibility() {}
  void deleteLayer() {}
  @override
  Widget build(BuildContext context) {
    LayerModel selectedLayer = widget.layerModel;
    LayerModel sLayer = AppData.of(context).selectedLayer;
    bool visible = selectedLayer.visible;
    bool selected = selectedLayer == sLayer;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2),
      decoration: darkestBox5,
      margin: EdgeInsets.all(2),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              LayerIcon(onTap: onSelect, selected: selected),
              ExpandIcon(
                onPressed: onExpand,
                isExpanded: expanded,
                color: Colors.white,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onChangeText,
                      borderRadius: BorderRadius.circular(5),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          selectedLayer.name,
                          style: collection,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ToggleVisibilty(onToggle: onToggleVisibility, visible: visible),
              DeleteLayer(onTap: deleteLayer),
            ],
          ),
          AnimatedContainer(
            height: expanded ? 80 : 0,
            duration: Duration(milliseconds: 250),
            child: Text("Settings"),
          ),
        ],
      ),
    );
  }
}
