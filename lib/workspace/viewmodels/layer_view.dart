import 'package:flutter/material.dart';
import 'package:sashimetri/models/sashimetrimodel.dart';
import 'package:sashimetri/workspace/metrioptionsviews/styles.dart';

import '../../locator.dart';
import 'layer_model.dart';

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
      selected = true;
    });
  }

  void onToggleVisibility() {

  }

  @override
  Widget build(BuildContext context) {
    LayerModel layer = widget.layerModel;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: selected ? Colors.grey : Colors.grey.shade900,
      ),
      height: 45,
      margin: EdgeInsets.all(2),
      child: InkWell(
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
            Center(
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Icon(
                        getIcon(layer.visible),
                        size: 16,
                        color: layer.visible ? Colors.white : Colors.grey,
                      ),
                    ),
                    onTap: onToggleVisibility,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

IconData getIcon(bool selected) {
  return selected ? Icons.visibility : Icons.visibility_off;
}
