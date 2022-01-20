import 'package:flutter/material.dart';
import 'package:sashimetri/models/sashimetrimodel.dart';
import 'package:scoped_model/scoped_model.dart';

import 'interactioninput/workspace.dart';

class ProjectPage extends StatefulWidget {
  ProjectPage({Key key}) : super(key: key);

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  @override
  Widget build(BuildContext context) {
    final model =
        ScopedModel.of<SashimetriModel>(context, rebuildOnChange: false);
    return Scaffold(
      appBar: AppBar(
        title: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => model.exitWorkSpace(),
        ),
        actions: [],
      ),
      body: WorkSpace(),
    );
  }
}
