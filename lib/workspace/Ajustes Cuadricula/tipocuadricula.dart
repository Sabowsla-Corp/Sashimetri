import 'package:flutter/material.dart';
import 'package:sashimetri/models/metrimodel.dart';
import 'package:sashimetri/models/sashimetrimodel.dart';
import 'package:sashimetri/workspace/viewmodels/collectionobject.dart';

class TipoDeCuadricula extends StatelessWidget {
  const TipoDeCuadricula({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = SashimetriModel.of(context);
    return CollectionObject(
      bgColor: Colors.grey.shade900,
      title: "Tipo De Cuadricula",
      onSelect: () {},
      onToggle: model.cambiarTipoDeCuadricula,
      activeIcon: Icons.grid_on,
      inactiveIcon: Icons.blur_circular,
      visible: model.tipoCuadricula == GridType.squared,
    );
  }
}
