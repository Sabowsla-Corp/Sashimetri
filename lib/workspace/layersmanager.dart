import 'package:flutter/material.dart';
import 'package:sashimetriweb/models/metrimodel.dart';
import 'package:sashimetriweb/models/sashimetrimodel.dart';
import 'package:sashimetriweb/workspace/Ajustes%20Cuadricula/ajustartama%C3%B1ocuadricula.dart';
import 'package:sashimetriweb/workspace/Ajustes%20Cuadricula/divisionescuadricula.dart';
import 'package:sashimetriweb/workspace/metrioptionsviews/ajustargrosor.dart';
import 'package:sashimetriweb/workspace/metrioptionsviews/ajustarmodomezclado.dart';
import 'package:sashimetriweb/workspace/metrioptionsviews/ajustarsubdivisiones.dart';

import 'package:sashimetriweb/workspace/metrioptionsviews/colorPalete.dart';
import 'package:sashimetriweb/workspace/metrioptionsviews/crearcapa.dart';
import 'package:sashimetriweb/workspace/metrioptionsviews/ajustarresplandor.dart';
import 'package:sashimetriweb/workspace/metrioptionsviews/Ajustes%20Cuadricula/tipocuadricula.dart';
import 'package:sashimetriweb/workspace/scenecollection.dart';

import 'package:sashimetriweb/workspace/metrioptionsviews/eliminarcapa.dart';
import 'Ajustes Cuadricula/mostrarcuadricula.dart';

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
