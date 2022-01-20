import 'package:flutter/material.dart';import 'package:sashimetri/models/sashimetrimodel.dart';
import 'package:sashimetri/workspace/viewmodels/collectionobjectslider.dart';

class AjustarSubdivisiones extends StatelessWidget {
  const AjustarSubdivisiones({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = AppData.of(context);
    return CollectionObjectSlider(
      title: "Ajustar Subdivisiones",
      onResetValue: () {
        model.ajustarSubdivisionesMetri(10);
      },
      onValueChange: (newValue) {
        model.ajustarSubdivisionesMetri(newValue.round());
      },
      value: model.selectedMetri.subdivisions.toDouble(),
      max: 30,
      min: 5,
      label: model.selectedMetri.subdivisions.toString(),
    );
  }
}
