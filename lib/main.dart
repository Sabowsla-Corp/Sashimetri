import 'package:sashimetri/locator.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'models/app_data.dart';
import 'workspace/proyect_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(model: setupLocator()));
}

class MyApp extends StatelessWidget {
  final AppData model;
  MyApp({required this.model});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppData>(
      model: model,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sashimetri',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          brightness: Brightness.dark,
        ),
        home: ProjectPage(),
      ),
    );
  }
}
//TODO: make the layers painter instanceable so it doesnt redraws all layers when 1 layer change and also for the bloom efect to work for every layer

