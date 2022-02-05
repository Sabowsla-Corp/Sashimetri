import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sashimetri/time%20line/time_line_data.dart';

import 'package:sashimetri/tools/drag_points.dart';
import 'layer_model.dart';
import 'package:scoped_model/scoped_model.dart';

class AppData extends Model {
  static AppData of(BuildContext context, {bool rebuild: true}) {
    return ScopedModel.of<AppData>(context, rebuildOnChange: rebuild);
  }

//Timeline Variables
  TimeLineData timeLineData = TimeLineData();

//-------------------------------

  int _selectedLayer = 0;
  int selectedMetriIndex = 0;
  int lastMetriPointIndex = 0;
  bool canChangeMetriIndex = true;
  bool onBackgroundColorSelection = false;
  DragPoints currentToolPostion = DragPoints.left;
  Color backgroundColor = Colors.black;
  BlendMode blendMode = BlendMode.srcOver;
  Offset canvasCenter = Offset(0, 0);
  Timer? timer;

  List<LayerModel> proyectLayers = [
    LayerModel(propertiesOverTime: []).randomLayer(),
  ];

  void updateTimeLineFrame(int frame) {
    timeLineData.frame = frame;
    notifyListeners();
  }

  void stopTimeLineAnimation() {
    timer!.cancel();
    notifyListeners();
  }

  void selectLayer(LayerModel _layerModel) {
    proyectLayers.forEach((e) => e.deselect());
    _selectedLayer = proyectLayers.indexOf(_layerModel);
    proyectLayers[_selectedLayer].select();
    notifyListeners();
  }

  LayerModel selectedLayer() {
    return proyectLayers[_selectedLayer];
  }

  void moveLayerCenter(Offset delta) {
    selectedLayer().center += delta;
    notifyListeners();
  }

/*
  void setNewToolPosition(DragPoints newPosition) {
    currentToolPostion = newPosition;
    updateConstraints(newPosition);
    notifyListeners();
  }


  void updateConstraints(DragPoints newPosition) {}
*/
  void snapLayer(LayerModel layer) {
    layer.gridSnapping = !layer.gridSnapping;
    layer.snapPoints();
    repaintOnce();
  }

  void handlePanEnd() {
    selectedLayer().snapPoints();
    repaintOnce();
  }

  void randomize(LayerModel layerModel) {
    //layerModel.randomize();
    repaintOnce();
  }

  void resetCenter(LayerModel layerModel) {
    layerModel.resetCenter();
    repaintOnce();
  }

  void deleteLayer(LayerModel _layer) {
    proyectLayers.remove(_layer);
    repaintOnce();
  }

  void toggleLayerGridDraw(LayerModel _layer) {
    _layer.toggleGridView();
    repaintOnce();
  }

  void toggleVisibility() {
    selectedLayer().toggleVisibility();
    repaintOnce();
  }

  void changeGlowSize(double newSize) {
    selectedLayer().glowSize = newSize;
    repaintOnce();
  }

  void ajustarDivisionesRadiales(int newDivisiones) {
    selectedLayer().radialDivisions = newDivisiones;

    selectedLayer().snapPoints();

    repaintOnce();
  }

  void adjustGridScale(double deltaScale) {
    selectedLayer().adjustGridScale(deltaScale);
    repaintOnce();
  }

  void ajustarExtensionCuadricula(int extent) {
    selectedLayer().gridExtent = extent;

    selectedLayer().snapPoints();

    repaintOnce();
  }

  void cambiarGrosor(double newGrosor) {
    selectedLayer().thickness = newGrosor;
    repaintOnce();
  }

  void setGridType(GridType _newGrid) {
    selectedLayer().setGridType(_newGrid);
    selectedLayer().snapPoints();
    repaintOnce();
  }

  void changeBackgroundColor(Color newColor) {
    backgroundColor = newColor;
    repaintOnce();
  }

  String getBlendModeName() {
    return blendMode.toString().replaceAll("BlendMode.", "").toUpperCase();
  }

  void toggleSymmetry() {
    selectedLayer().symetryc = !selectedLayer().symetryc;
    repaintOnce();
  }

  void ajustarSubdivisionesMetri(int newSubdvs) {
    selectedLayer().subdivisions = newSubdvs;
    repaintOnce();
  }

  void toggleBackgroundColorSelecion() {
    onBackgroundColorSelection = !onBackgroundColorSelection;

    notifyListeners();
  }

  void setLayerColor(Color newColor, LayerModel layerModel) {
    layerModel.setColor(timeLineData.frame, newColor);
    repaintOnce();
  }

  void repaintOnce() {
    notifyListeners();
  }

  void createLayer() {
    proyectLayers.forEach((element) {
      element.deselect();
    });
    var newLayer = LayerModel(propertiesOverTime: []).randomLayer();
    proyectLayers.add(newLayer);
    _selectedLayer = proyectLayers.length - 1;
    repaintOnce();
  }

  void deleteMetri(int index) {
    if (proyectLayers.length > 1) {
      proyectLayers.removeAt(index);
    }
    selectedMetriIndex = proyectLayers.length - 1;

    selectedLayer().selected = true;
    repaintOnce();
  }

  void symetrizeLayer(LayerModel layer) {
    layer.symetryc = !layer.symetryc;
    repaintOnce();
  }

  void dragLayerPoint(Offset delta, int index) {
    selectedLayer().dragPoint(index, delta);
    repaintOnce();
    notifyListeners();
  }

  void changeMetriVisibility(int index) {
    proyectLayers[index].toggleVisibility();
    repaintOnce();
  }

  void disableMetriPointIndexChange(bool state) {
    canChangeMetriIndex = state;
    notifyListeners();
  }

  void oldPointFn(int newPoint) {
    lastMetriPointIndex = newPoint;
  }
}
