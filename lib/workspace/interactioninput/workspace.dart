import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sashimetri/models/sashimetrimodel.dart';
import 'package:sashimetri/workspace/interactioninput/touchcontrol.dart';

import '../layersmanager.dart';

class WorkSpace extends StatelessWidget {
  const WorkSpace({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = AppData.of(context, rebuild: false);
    model.resetCenter(MediaQuery.of(context).size);

    model.initWorkSpace();

    return Stack(
      children: [
        TouchControl(),
        LayersManager(),
      ],
    );
  }
}
