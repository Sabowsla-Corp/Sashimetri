import 'package:flutter/material.dart';
import 'package:sashimetri/workspace/proyect_layers_view.dart';
import 'metrioptionsviews/crearcapa.dart';

class LayersDragger extends StatefulWidget {
  @override
  _LayersDraggerState createState() => _LayersDraggerState();
}

class _LayersDraggerState extends State<LayersDragger> {
  Offset layerOffset = Offset(0, 0);
  Offset windowSize = Offset(250, 550);
  Offset wSOffset = Offset(0, 0);
  void dragUpdte(DragUpdateDetails d) => setState(() => layerOffset += d.delta);
  void resizeUpdate(DragUpdateDetails d) => setState(() {
        wSOffset += d.delta;
        if (wSOffset.dx < -50) {
          wSOffset = Offset(-50, wSOffset.dy);
        } else if (wSOffset.dy < -200) {
          wSOffset = Offset(wSOffset.dx, -200);
        }
      });
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: layerOffset.dx,
      top: layerOffset.dy,
      child: AnimatedContainer(
        margin: EdgeInsets.all(5),
        width: windowSize.dx + wSOffset.dx,
        height: windowSize.dy + wSOffset.dy,
        duration: Duration(milliseconds: 100),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Draggable(
                        onDragUpdate: dragUpdte,
                        feedback: Container(),
                        child: Center(
                          child: Icon(Icons.grid_view_rounded,
                              color: Colors.white, size: 15),
                        ),
                      ),
                      Text(
                        " Layers",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Expanded(child: ProyectLayersView()),
                CrearCapa(),
              ],
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Draggable(
                onDragUpdate: resizeUpdate,
                feedback: Container(),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Icon(
                      Icons.api,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
              ),
            ),
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