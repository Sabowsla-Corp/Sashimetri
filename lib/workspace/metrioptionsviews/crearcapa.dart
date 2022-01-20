import 'package:flutter/material.dart';
import 'package:sashimetri/models/sashimetrimodel.dart';
import '../viewmodels/layer_view.dart';

class CrearCapa extends StatelessWidget {
  const CrearCapa({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = AppData.of(context);
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: model.createNewMetri,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.add,
              size: 25,
            ),
          ),
        ),
      ),
    );
  }
}
