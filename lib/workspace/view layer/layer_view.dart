import 'package:flutter/material.dart';
import 'package:sashimetri/models/app_data.dart';
import 'package:sashimetri/models/layer_model.dart';
import 'package:sashimetri/workspace/metrioptionsviews/color_palette.dart';
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

  @override
  Widget build(BuildContext context) {
    AppData appData = AppData.of(context);
    LayerModel layerModel = widget.layerModel;

    bool visible = layerModel.visible;

    void onSelect() {
      setState(() {
        layerModel.select();
        appData.selectLayer(layerModel);
      });
    }

    void onExpand(bool e) {
      setState(() {
         expanded = !expanded;
         if(!e){
           onSelect();
         }
      });
    }

    void onChangeText() {}

    void onToggleVisibility() {
      appData.toggleVisibility();
    }

    void deleteLayer() {
      appData.deleteLayer(layerModel);
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2),
      decoration: darkestBox5,
      margin: EdgeInsets.all(2),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              LayerIcon(
                onTap: onSelect,
                selected: layerModel.selected,
              ),
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
                          layerModel.name,
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
            child: ColorPalette(
              layerModel: widget.layerModel,
            ),
          ),
        ],
      ),
    );
  }
}
