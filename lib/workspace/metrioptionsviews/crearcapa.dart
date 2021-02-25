import 'package:flutter/material.dart';
import 'package:sashimetriweb/models/sashimetrimodel.dart';
import '../viewmodels/collectionobject.dart';

class CrearCapa extends StatelessWidget {
  const CrearCapa({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = SashimetriModel.of(context);
    return CollectionObject(
      activeIcon: Icons.add,
      visible: true,
      bgColor: Colors.grey.shade900,
      title: "Añadir Capa",
      height: 30,
      leadingIcon: Container(),
      onToggle: model.createNewMetri,
      onSelect: model.createNewMetri,
    );
  }
}
