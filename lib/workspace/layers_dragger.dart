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
  bool opened = true;
  void dragUpdte(DragUpdateDetails d) => setState(() => layerOffset += d.delta);
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
        height: opened ? windowSize.dy + wSOffset.dy : 50,
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
                DraggableHead(
                  dragUpdte: dragUpdte,
                  onToggle: onCloseOpen,
                  isExpanded: opened,
                ),
                opened ? Expanded(child: ProyectLayersView()) : Container(),
                opened ? CrearCapa() : Container(),
              ],
            ),
            opened
                ? Positioned(
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
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class DraggableHead extends StatelessWidget {
  const DraggableHead(
      {Key? key, this.dragUpdte, required this.onToggle, this.isExpanded})
      : super(key: key);

  final bool? isExpanded;
  final dragUpdte;
  final Function(bool) onToggle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Draggable(
            data: this,
            onDragUpdate: dragUpdte,
            feedback: Container(),
            child: Center(
              child:
                  Icon(Icons.grid_view_rounded, color: Colors.white, size: 15),
            ),
          ),
          ExpandIcon(
            isExpanded: !isExpanded!,
            onPressed: onToggle,
            color: Colors.white,
          ),
          Text(
            " Layers",
            style: TextStyle(color: Colors.white),
          ),
        ],
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