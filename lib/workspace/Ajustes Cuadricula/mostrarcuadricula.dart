import 'package:flutter/material.dart';
import 'package:sashimetri/models/sashimetrimodel.dart';
import 'package:sashimetri/workspace/viewmodels/collectionobject.dart';
class MostrarCuadricula extends StatelessWidget {
  const MostrarCuadricula({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = SashimetriModel.of(context);
    return CollectionObject(
      activeIcon: Icons.grid_on,
      inactiveIcon: Icons.grid_off,
      visible: model.cuadriculaActiva,
      bgColor: Colors.grey.shade900,
      title: "Mostrar Cuadricula",
      height: 30,
      leadingIcon: Container(),
      inactiveIconColor: Colors.grey,
      onToggle: model.mostrarCuadricula,
      onSelect: model.mostrarCuadricula,
    );
  }
}
