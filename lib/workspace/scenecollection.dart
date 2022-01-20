import 'package:flutter/material.dart';
import 'package:sashimetri/models/sashimetrimodel.dart';

import 'viewmodels/layer_view.dart';

class ProyectLayersView extends StatelessWidget {
  const ProyectLayersView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = AppData.of(context);

    return ListView.builder(
      shrinkWrap: true,
      itemCount: model.proyectLayers.length,
      itemBuilder: (BuildContext context, int index) {
        return LayerView(
          layerModel: model.proyectLayers[index],
        );
      },
    );
  }
}
