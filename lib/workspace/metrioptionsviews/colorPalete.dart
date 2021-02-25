import 'package:flutter/material.dart';
import 'package:sashimetriweb/models/sashimetrimodel.dart';

class ColorPalette extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = SashimetriModel.of(context, rebuild: false);

    return Container(
      color: Colors.grey.shade900,
      height: 50,
      padding: EdgeInsets.all(2),
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Colors.primaries.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 30,
            color: Colors.primaries[index],
            child: Material(
              borderRadius: BorderRadius.circular(2),
              color: Colors.transparent,
              child: InkWell(
                child: model.currentColor == Colors.primaries[index]
                    ? Icon(
                        Icons.check,
                        color: Colors.white,
                      )
                    : Text(""),
                onTap: () => {
                  model.setColorFromPalete(Colors.primaries[index]),
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
