import 'package:flutter/material.dart';import 'package:sashimetri/models/app_data.dart';
import 'package:sashimetri/workspace/viewmodels/collectionobjectsliderenum.dart';

class AjustarModoMezclado extends StatelessWidget {
  const AjustarModoMezclado({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = AppData.of(context);
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
