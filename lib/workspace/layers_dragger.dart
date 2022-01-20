import 'package:flutter/material.dart';
import 'package:sashimetri/workspace/proyect_layers_view.dart';
import 'metrioptionsviews/crearcapa.dart';

class LayersDragger extends StatefulWidget {
  @override
  _LayersDraggerState createState() => _LayersDraggerState();
}

class _LayersDraggerState extends State<LayersDragger> {
  bool hide = false;
  Offset layerOffset = Offset(0, 0);
  void dragStart() => setState(() => hide = true);
  void onDragEnd(DraggableDetails d) => setState(() => hide = false);
  void dragUpdte(DragUpdateDetails d) => setState(() => layerOffset += d.delta);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: layerOffset.dx,
      top: layerOffset.dy,
      child: AnimatedContainer(
        margin: EdgeInsets.all(5),
        width: hide ? 30 : 350,
        height: hide ? 30 : 450,
        duration: Duration(milliseconds: 100),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(hide ? 50 : 5),
          color: Colors.grey.shade700,
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: hide
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Draggable(
                        onDragUpdate: dragUpdte,
                        onDragStarted: dragStart,
                        onDragEnd: onDragEnd,
                        feedback: Container(),
                        child: Center(
                          child: Icon(Icons.grid_view_rounded,
                              color: Colors.white, size: 15),
                        ),
                      ),
                      !hide
                          ? Text(" Layers",
                              style: TextStyle(color: Colors.white))
                          : Container(),
                    ],
                  ),
                ),
                !hide ? Expanded(child: ProyectLayersView()) : Container(),
                !hide ? CrearCapa() : Container(),
              ],
            ),
            !hide
                ? Positioned(
                    right: 0,
                    bottom: 0,
                    child: Draggable(
                      onDragUpdate: dragUpdte,
                      feedback: Container(),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Icon(
                            Icons.grid_view_rounded,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
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