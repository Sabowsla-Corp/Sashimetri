import 'package:flutter/material.dart';
import 'package:sashimetri/models/metrimodel.dart';
import 'package:sashimetri/models/sashimetrimodel.dart';
import 'package:sashimetri/workspace/metrioptionsviews/ajustargrosor.dart';
import 'package:sashimetri/workspace/scenecollection.dart';
import 'Ajustes Cuadricula/ajustartamañocuadricula.dart';
import 'Ajustes Cuadricula/divisionescuadricula.dart';
import 'Ajustes Cuadricula/mostrarcuadricula.dart';
import 'Ajustes Cuadricula/tipocuadricula.dart';
import 'metrioptionsviews/ajustarmodomezclado.dart';
import 'metrioptionsviews/ajustarresplandor.dart';
import 'metrioptionsviews/ajustarsubdivisiones.dart';
import 'metrioptionsviews/colorPalete.dart';
import 'metrioptionsviews/crearcapa.dart';
import 'metrioptionsviews/eliminarcapa.dart';

class LayersManager extends StatefulWidget {
  @override
  _LayersManagerState createState() => _LayersManagerState();
}

class _LayersManagerState extends State<LayersManager> {
  @override
  Widget build(BuildContext context) {
    final model = SashimetriModel.of(context);
    return Container(
      width: 250,
      child: Card(
        color: Colors.grey.shade700,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SceneCollection(),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  CrearCapa(),
                  EliminarCapa(),
                  MostrarCuadricula(),
                  TipoDeCuadricula(),
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
            ),
          ],
        ),
      ),
    );
  }
}
