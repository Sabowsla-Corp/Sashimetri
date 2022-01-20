import 'package:flutter/material.dart';
import 'package:sashimetri/models/app_data.dart';

import 'interactioninput/workspace.dart';

class ProjectPage extends StatefulWidget {
  ProjectPage({Key key}) : super(key: key);

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  @override
  Widget build(BuildContext context) {
  var model = AppData.of(context);
    return Scaffold(
      backgroundColor:  model.backgroundColor,
      appBar: AppBar(
        title: InkWell(
          child: Icon(Icons.settings),
          onTap: openSettings,
        ),
        actions: [],
      ),
      body: WorkSpace(),
    );
  }
}

void openSettings(){
  //TODO:
  //locator<AppData>().openSettings();
}