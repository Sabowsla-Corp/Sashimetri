import 'package:flutter/material.dart';
import 'package:sashimetri/models/app_data.dart';
import 'package:sashimetri/models/layer_model.dart';

class ColorPalette extends StatefulWidget {
  final LayerModel layerModel;

  ColorPalette({Key? key, required this.layerModel});

  @override
  State<ColorPalette> createState() => _ColorPaletteState();
}

class _ColorPaletteState extends State<ColorPalette> {
  @override
  Widget build(BuildContext context) {
    AppData appData = AppData.of(context);
    return Container(
      color: Colors.grey.shade900,
      height: 50,
      padding: EdgeInsets.all(2),
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: Colors.primaries.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: Colors.primaries.length ~/ 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          Color currentColor = Colors.primaries[index];
          bool selected = widget.layerModel.color == currentColor;
          var br25 = BorderRadius.circular(25);
          return AnimatedContainer(
            duration: Duration(milliseconds: 250),
            margin: EdgeInsets.all(selected ? 2 : 5),
            decoration: BoxDecoration(
              borderRadius: br25,
              color: Colors.primaries[index],
            ),
            child: Material(
              borderRadius: br25,
              color: Colors.transparent,
              child: InkWell(
                borderRadius: br25,
                child: Padding(
                  padding: EdgeInsets.all(selected ? 2 : 5),
                  child: Text(""),
                ),
                onTap: () {
                  setState(() {
                    appData.selectLayerColor(currentColor);
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
