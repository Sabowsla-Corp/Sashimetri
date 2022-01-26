import 'package:flutter/material.dart';
import 'package:sashimetri/workspace/proyect_layers_view.dart';
import '../metrioptionsviews/crearcapa.dart';
import 'draggable_head.dart';

class LayersDragger extends StatefulWidget {
  @override
  _LayersDraggerState createState() => _LayersDraggerState();
}

class _LayersDraggerState extends State<LayersDragger> {
  Offset layerOffset = Offset(0, 0);
  Offset windowSize = Offset(250, 550);
  Offset wSOffset = Offset(0, 0);
  bool opened = true;
  void dragUpdte(DragUpdateDetails d) => setState(() {
        layerOffset += d.delta;
        opened = false;
      });
  void onDragEnd(DraggableDetails details) => setState(() {
        opened = true;
      });
  void resizeUpdate(DragUpdateDetails d) => setState(() {
        wSOffset += d.delta;
        if (wSOffset.dx < -50) {
          wSOffset = Offset(-50, wSOffset.dy);
        } else if (wSOffset.dy < -200) {
          wSOffset = Offset(wSOffset.dx, -200);
        }
      });
  void onCloseOpen(bool e) => setState(() {
        opened = !opened;
      });
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: layerOffset.dx,
      top: layerOffset.dy,
      child: AnimatedContainer(
        margin: EdgeInsets.all(5),
        width: windowSize.dx + wSOffset.dx,
        duration: Duration(milliseconds: 100),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey.shade700,
        ),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            DraggableHead(
              dragUpdte: dragUpdte,
              onToggle: onCloseOpen,
              onDragEnd: onDragEnd,
              isExpanded: opened,
            ),
            opened ? ProyectLayersView() : Container(),
            opened ? CrearCapa() : Container(),
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