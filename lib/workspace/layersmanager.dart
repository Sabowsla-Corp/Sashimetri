import 'package:flutter/material.dart';
import 'package:sashimetri/models/metrimodel.dart';
import 'package:sashimetri/models/sashimetrimodel.dart';
import 'package:sashimetri/workspace/metrioptionsviews/ajustargrosor.dart';
import 'package:sashimetri/workspace/scenecollection.dart';
import 'Ajustes Cuadricula/ajustartamañocuadricula.dart';
import 'Ajustes Cuadricula/divisionescuadricula.dart';
import 'metrioptionsviews/ajustarmodomezclado.dart';
import 'metrioptionsviews/ajustarresplandor.dart';
import 'metrioptionsviews/ajustarsubdivisiones.dart';
import 'metrioptionsviews/colorPalete.dart';
import 'metrioptionsviews/crearcapa.dart';

class LayersManager extends StatefulWidget {
  @override
  _LayersManagerState createState() => _LayersManagerState();
}

class _LayersManagerState extends State<LayersManager> {
  @override
  Widget build(BuildContext context) {
    final model = AppData.of(context);
    return Container(
      width: 350,
      height: 450,
      child: Card(
        color: Colors.grey.shade700,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(child: ProyectLayersView()),
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
          ],
        ),
      ),
    );
  }
}
