import 'package:flutter/material.dart';import 'package:sashimetri/models/app_data.dart';
import '../viewmodels/collectionobjectslider.dart';

class AjustarGrosor extends StatelessWidget {
  const AjustarGrosor({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = AppData.of(context);
    return CollectionObjectSlider(
      title: "Ajustar Grosor",
      color: Colors.grey.shade900,
      height: 30,
      margin: EdgeInsets.symmetric(horizontal: 4),
      onValueChange: model.cambiarGrosor,
      value: model.selectedLayer.thickness,
      max: 5,
      min: 0.5,
      onResetValue: () {
        model.cambiarGrosor(1);
      },
      label: model.selectedLayer.thickness.toStringAsFixed(2),
    );
  }
}
