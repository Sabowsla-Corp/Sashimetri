import 'package:flutter/material.dart';
import 'package:sashimetriweb/models/sashimetrimodel.dart';
import 'package:sashimetriweb/workspace/viewmodels/collectionobjectsliderenum.dart';

class AjustarModoMezclado extends StatelessWidget {
  const AjustarModoMezclado({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = SashimetriModel.of(context);
    return CollectionObjectSliderEnum(
      onResetValue: () {
        model.changeBlendMode(BlendMode.srcOver);
      },
      onValueChange: (newValue) {
        model.changeBlenModeIndex(newValue.round());
      },
      value: model.blendModeIndex,
      divisions: BlendMode.values.length,
      title: "Modo de Mezlcado",
      label: model.getBlendModeName(),
    );
  }
}
