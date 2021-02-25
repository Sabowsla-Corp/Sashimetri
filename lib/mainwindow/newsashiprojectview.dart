import 'package:flutter/material.dart';
import 'package:sashimetriweb/models/sashimetrimodel.dart';
import 'package:scoped_model/scoped_model.dart';

class NewProjectSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var titulo = Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        "New project",
        style: TextStyle(
            fontSize: 30, color: Colors.yellow, fontWeight: FontWeight.w600),
      ),
    );
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          titulo,
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NewProjectView(type: ProjectType.squared),
                NewProjectView(type: ProjectType.circular),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum ProjectType { squared, circular }

class NewProjectView extends StatefulWidget {
  final ProjectType type;

  const NewProjectView({Key key, this.type: ProjectType.squared})
      : super(key: key);

  @override
  _NewProjectViewState createState() => _NewProjectViewState();
}

class _NewProjectViewState extends State<NewProjectView> {
  Duration d500 = new Duration(milliseconds: 300);
  Gradient lightGradient = LinearGradient(
    colors: [
      Colors.yellow.withAlpha(50),
      Colors.pink.withAlpha(50),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  Gradient darkGradient = LinearGradient(
    colors: [
      Colors.yellow,
      Colors.pink,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final model =
        ScopedModel.of<SashimetriModel>(context, rebuildOnChange: false);
    return Expanded(
      child: AnimatedContainer(
        duration: d500,
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: hovered ? darkGradient : lightGradient,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              model.createNewProject(widget.type);
            },
            onHover: (value) {
              setState(() {
                hovered = !hovered;
              });
            },
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.type == ProjectType.circular
                      ? Icons.blur_circular
                      : Icons.grid_on,
                  color: Colors.purple[900],
                  size: 200,
                ),
                Text(
                  widget.type.toString().replaceAll("ProjectType.", ""),
                  style: TextStyle(
                    color: Colors.purple[700].withAlpha(150),
                    fontSize: 50,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
