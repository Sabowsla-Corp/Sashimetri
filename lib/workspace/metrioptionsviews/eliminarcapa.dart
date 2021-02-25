import 'package:flutter/material.dart';
import 'package:sashimetriweb/models/sashimetrimodel.dart';
import '../viewmodels/collectionobject.dart';

class EliminarCapa extends StatelessWidget {
  const EliminarCapa({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = SashimetriModel.of(context);
    return CollectionObject(
      activeIcon: Icons.delete,
      visible: true,
      bgColor: Colors.grey.shade900,
      title: "Eliminar Capa",
      height: 30,
      leadingIcon: Container(),
      onToggle: () {
        model.deleteSelectedMetri();
      },
      onSelect: () {
        model.deleteSelectedMetri();
      },
    );
  }
}
