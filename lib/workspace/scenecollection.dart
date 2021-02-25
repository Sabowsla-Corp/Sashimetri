import 'package:flutter/material.dart';
import 'package:sashimetriweb/models/sashimetrimodel.dart';

import 'viewmodels/collectionobject.dart';

class SceneCollection extends StatelessWidget {
  const SceneCollection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = SashimetriModel.of(context);
    return Expanded(
      child: RawKeyboardListener(
        focusNode: FocusScopeNode(),
        autofocus: true,
        onKey: (key) {
          if (key.data.keyLabel == "Delete") {
            model.deleteMetri(model.selectedMetriIndex);
          }
        },
        child: ListView.builder(
          itemCount: model.projectMetris.length,
          itemBuilder: (BuildContext context, int index) {
            Color color = model.selectedMetriIndex == index
                ? Color.alphaBlend(Colors.pinkAccent, Colors.grey.shade800)
                : index % 2 == 0 ? Colors.grey.shade800 : Colors.grey.shade700;
            return CollectionObject(
              activeIcon: Icons.visibility,
              inactiveIcon: Icons.visibility_off,
              visible: model.projectMetris[index].visible,
              height: 30,
              bgColor: color,
              leadingIcon: Padding(
                padding: const EdgeInsets.all(2),
                child: Icon(
                  Icons.layers,
                  color: model.projectMetris[index].visible
                      ? Colors.white
                      : Colors.grey,
                  size: 13,
                ),
              ),
              title: " Capa " + (index + 1).toString(),
              onToggle: () {
                model.changeMetriVisibility(index);
              },
              onSelect: () {
                model.selectMetri(index);
              },
            );
          },
        ),
      ),
    );
  }
}
