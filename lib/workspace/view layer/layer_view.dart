import 'package:flutter/material.dart';
import 'package:sashimetri/models/app_data.dart';
import 'package:sashimetri/models/layer_model.dart';
import 'package:sashimetri/workspace/metrioptionsviews/color_palette.dart';
import 'package:sashimetri/workspace/metrioptionsviews/styles.dart';

import '../../locator.dart';
import 'delete_layer.dart';
import 'layer_icon.dart';
import 'layer_option.dart';
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
        if (!e) {
          onSelect();
        }
      });
    }

    void onChangeText() {}
    void resetCenter() => appData.resetCenter(layerModel);
    void snapLayer() => appData.snapLayer(layerModel);
    void deleteLayer() => appData.deleteLayer(layerModel);
    void onToggleVisibility() => appData.toggleVisibility();
    void symetrizeLayer() => appData.symetrizeLayer(layerModel);
    void onToggleGrid() => appData.toggleLayerGridDraw(layerModel);
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
          Column(
            children: [
              Row(
                children: [
                  LayerOption(
                    onTap: symetrizeLayer,
                    icon: "assets/symetrize_icon.png",
                    enabled: layerModel.symetryc,
                    visible: expanded,
                  ),
                  LayerOption(
                    onTap: snapLayer,
                    icon: "assets/snap_icon.png",
                    enabled: layerModel.gridSnapping,
                    visible: expanded,
                  ),
                  LayerOption(
                    onTap: onToggleGrid,
                    icon: "assets/grid_draw.png",
                    enabled: layerModel.gridDrawing,
                    visible: expanded,
                  ),
                  LayerOption(
                    onTap: resetCenter,
                    icon: "assets/reset_center.png",
                    enabled: true,
                    visible: expanded,
                  ),
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
        ],
      ),
    );
  }
}
