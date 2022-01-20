import 'package:flutter/material.dart';
import 'package:sashimetri/models/app_data.dart';
import 'package:sashimetri/workspace/scenecollection.dart';
import 'metrioptionsviews/crearcapa.dart';

class LayersDragger extends StatefulWidget {
  @override
  _LayersDraggerState createState() => _LayersDraggerState();
}

class _LayersDraggerState extends State<LayersDragger> {
  bool hide = false;
  Offset layerOffset = Offset(0, 0);
  void dragStart() {
    setState(() {
      hide = true;
    });
  }

  void onDragEnd(DraggableDetails d) {
    setState(() {
      hide = false;
    });
  }

  void onDragUpdate(DragUpdateDetails d) {
    setState(() {
      layerOffset += d.delta;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable

    final model = AppData.of(context);
    return Positioned(
      left: layerOffset.dx,
      top: layerOffset.dy,
      child: AnimatedContainer(
        margin: EdgeInsets.all(5),
        width: hide ? 50 : 350,
        height: hide ? 50 : 450,
        duration: Duration(milliseconds: 100),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(hide ? 50 : 5),
          color: Colors.grey.shade700,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Draggable(
                    onDragUpdate: onDragUpdate,
                    onDragStarted: dragStart,
                    onDragEnd: onDragEnd,
                    feedback: Icon(Icons.add_location),
                    child: Center(
                      child: Icon(
                        Icons.add_location,
                      ),
                    ),
                  ),
                  !hide ? Text("Layers") : Container(),
                ],
              ),
            ),
            !hide ? Expanded(child: ProyectLayersView()) : Container(),
            !hide ? CrearCapa() : Container(),
          ],
        ),
      ),
    );
  }
}




  /*
            Column(
              children: [
                CrearCapa(),
                AjustarSubdivisiones(),
                AjustarResplandor(),
                AjustarGrosor(),
                AjustarModoMezclado(),
                AjustarExtensionCuadricula(),
                if (model.tipoCuadricula == GridType.circular)
                  DivisionesCuadriculaRadial(),
                ColorPalette(),
              ],
            ),
            */