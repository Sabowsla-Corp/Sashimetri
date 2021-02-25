import 'package:flutter/material.dart';
import 'package:sashimetriweb/models/sashimetrimodel.dart';
import 'package:sashimetriweb/workspace/viewmodels/collectionobjectslider.dart';

class AjustarExtensionCuadricula extends StatelessWidget {
  const AjustarExtensionCuadricula({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = SashimetriModel.of(context);
    return CollectionObjectSlider(
      title: "Tamaño Cuadricula",
      onResetValue: () {
        model.ajustarExtensionCuadricula(10);
      },
      onValueChange: (newValue) {
        model.ajustarExtensionCuadricula(newValue.round());
      },
      value: model.gridExtent.toDouble(),
      max: 30,
      min: 5,
      label: model.gridExtent.toString(),
    );
  }
}
