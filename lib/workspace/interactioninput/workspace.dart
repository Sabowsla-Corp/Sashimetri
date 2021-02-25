import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sashimetriweb/models/sashimetrimodel.dart';
import 'package:sashimetriweb/workspace/layersmanager.dart';
import 'package:sashimetriweb/workspace/interactioninput/touchcontrol.dart';

class WorkSpace extends StatelessWidget {
  const WorkSpace({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = SashimetriModel.of(context, rebuild: false);
    model.resetCenter(MediaQuery.of(context).size);

    model.initWorkSpace();

    return Stack(
      children: [
        Container(color: model.backgroundColor),
        Row(
          children: [
            TouchControl(),
            LayersManager(),
          ],
        ),
      ],
    );
  }
}
