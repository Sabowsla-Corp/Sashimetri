import 'package:flutter/material.dart';
import 'package:sashimetriweb/models/sashimetrimodel.dart';
import 'package:sashimetriweb/workspace/viewmodels/collectionobjectslider.dart';

class DivisionesCuadriculaRadial extends StatelessWidget {
  const DivisionesCuadriculaRadial({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = SashimetriModel.of(context);
    return CollectionObjectSlider(
      title: "Division Cuadricula",
      onResetValue: () {
        model.ajustarDivisionesRadiales(20);
      },
      onValueChange: (newValue) {
        model.ajustarDivisionesRadiales(newValue.round());
      },
      value: model.radialDivisions.toDouble(),
      max: 30,
      min: 5,
      label: model.radialDivisions.toString(),
    );
  }
}
