import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sashimetri/models/app_data.dart';
import 'package:sashimetri/time%20line/time_line.dart';

import 'interactioninput/touch_control.dart';
import 'layers_dragger.dart';

class ProjectPage extends StatefulWidget {
  ProjectPage({Key? key}) : super(key: key);

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  @override
  Widget build(BuildContext context) {
    var model = AppData.of(context);
    return Scaffold(
      backgroundColor: model.backgroundColor,
      body: Column(
        children: [
          Expanded(
            
            child: Stack(
              children: [
                TouchControl(),
                LayersDragger(),
              ],
            ),
          ),
          TimeLineInspector(),
        ],
      ),
    );
  }
}

