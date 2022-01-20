import 'package:flutter/material.dart';
import 'package:sashimetri/models/app_data.dart';

import 'view layer/layer_view.dart';

class ProyectLayersView extends StatelessWidget {
  const ProyectLayersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = AppData.of(context);
    print(model);
    print(model.proyectLayers[0].currentColor);
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
