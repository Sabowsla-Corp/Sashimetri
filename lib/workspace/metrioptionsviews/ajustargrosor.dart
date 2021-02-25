import 'package:flutter/material.dart';
import 'package:sashimetriweb/models/sashimetrimodel.dart';
import '../viewmodels/collectionobjectslider.dart';

class AjustarGrosor extends StatelessWidget {
  const AjustarGrosor({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = SashimetriModel.of(context);
    return CollectionObjectSlider(
      title: "Ajustar Grosor",
      color: Colors.grey.shade900,
      height: 30,
      margin: EdgeInsets.symmetric(horizontal: 4),
      onValueChange: model.cambiarGrosor,
      value: model.selectedMetri.thickness,
      max: 5,
      min: 0.5,
      onResetValue: () {
        model.cambiarGrosor(1);
      },
      label: model.selectedMetri.thickness.toStringAsFixed(2),
    );
  }
}
