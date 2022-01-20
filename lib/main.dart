import 'package:sashimetri/locator.dart';

import 'mainwindow/newsashiprojectview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'models/sashimetrimodel.dart';
import 'workspace/projectpage.dart';

//flutter pub pub run flutter_launcher_icons:main
void main() async {
  runApp(MyApp(model: setupLocator()));
}

class MyApp extends StatelessWidget {
  final AppData model;
  MyApp({this.model});
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppData>(
      model: model,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sashimetri',
        theme: ThemeData(
          primarySwatch: Colors.pink,
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
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: ProjectPage(),
    );
  }
}
