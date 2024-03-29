import 'package:flutter/material.dart';
import 'package:sashimetri/models/app_data.dart';
import 'package:sashimetri/models/layer_model.dart';

class ColorPalette extends StatefulWidget {
  final LayerModel layerModel;
  final bool expanded;
  ColorPalette({
    Key? key,
    required this.layerModel,
    this.expanded = false,
  });

  @override
  State<ColorPalette> createState() => _ColorPaletteState();
}

class _ColorPaletteState extends State<ColorPalette> {
  @override
  Widget build(BuildContext context) {
    AppData appData = AppData.of(context);
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: widget.expanded ? null : 0,
      color: Colors.grey.shade900,
      padding: EdgeInsets.all(2),
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: Colors.primaries.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: Colors.primaries.length ~/ 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          Color currentColor = Colors.primaries[index];
          
          var br25 = BorderRadius.circular(25);
          return AnimatedContainer(
            duration: Duration(milliseconds: 250),
            margin: EdgeInsets.all(2),
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
                  padding: EdgeInsets.all( 2),
                  child: Text(""),
                ),
                onTap: () {
                  setState(() {
                    appData.setLayerColor(currentColor, widget.layerModel);
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
