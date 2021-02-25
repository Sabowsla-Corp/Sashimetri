import 'package:flutter/material.dart';
import 'package:sashimetriweb/models/sashimetrimodel.dart';
import '../viewmodels/collectionobjectslider.dart';

class AjustarResplandor extends StatelessWidget {
  const AjustarResplandor({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = SashimetriModel.of(context);
    return CollectionObjectSlider(
      title: "Ajustar Resplandor",
      color: Colors.grey.shade900,
      height: 30,
      margin: EdgeInsets.symmetric(horizontal: 4),
      onValueChange: model.changeGlowSize,
      value: model.glowSize,
      max: model.maxGlow,
      min: model.minGlow,
      onResetValue: () {
        model.changeGlowSize(2);
      },
      label: model.glowSize.toStringAsFixed(2),
    );
  }
}
