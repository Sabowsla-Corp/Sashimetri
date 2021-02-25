import 'mainwindow/newsashiprojectview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'models/sashimetrimodel.dart';
import 'package:sashimetriweb/mainwindow/background.dart';
import 'workspace/projectpage.dart';

//flutter pub pub run flutter_launcher_icons:main
void main() async {
  runApp(MyApp(model: new SashimetriModel()));
}

class MyApp extends StatelessWidget {
  final SashimetriModel model;
  MyApp({this.model});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return ScopedModel<SashimetriModel>(
      model: model,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sashimetri',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final model =
        ScopedModel.of<SashimetriModel>(context, rebuildOnChange: false);
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: model.onWorkSpace
          ? ProjectPage()
          : Stack(
              children: <Widget>[
                Background(delay: 100),
                Column(
                  children: <Widget>[
                    Container(
                      height: 230,
                    ),
                    NewProjectSelector(),
                  ],
                ),
              ],
            ),
    );
  }
}
