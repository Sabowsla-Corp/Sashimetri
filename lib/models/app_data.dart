import 'package:flutter/material.dart';
import 'layer_model.dart';
import 'package:scoped_model/scoped_model.dart';

class AppData extends Model {
  static AppData of(BuildContext context, {bool rebuild: true}) {
    return ScopedModel.of<AppData>(context, rebuildOnChange: rebuild);
  }

  int _selectedLayer = 0;

  int selectedMetriIndex = 0;
  int lastMetriPointIndex = 0;
  bool canChangeMetriIndex = true;
  bool onBackgroundColorSelection = false;
  //DragPoints currentToolPostion = DragPoints.left;
  Color backgroundColor = Colors.black;
  BlendMode blendMode = BlendMode.srcOver;
  Offset canvasCenter = Offset(0, 0);
  List<LayerModel> proyectLayers = [
    LayerModel().randomLayer(),
  ];

  void selectLayer(LayerModel _layerModel) {
    proyectLayers.forEach((e) => e.deselect());
    _selectedLayer = proyectLayers.indexOf(_layerModel);
    proyectLayers[_selectedLayer].select()
;    notifyListeners();
  }

  LayerModel selectedLayer() {
    return proyectLayers[_selectedLayer];
  }

/*
  void setNewToolPosition(DragPoints newPosition) {
    currentToolPostion = newPosition;
    updateConstraints(newPosition);
    notifyListeners();
  }


  void updateConstraints(DragPoints newPosition) {}
*/
  void snapMetriToItsGrid() {
    selectedLayer().snapPoints();
    notifyListeners();
  }

  void deleteLayer(LayerModel _layer) {
    proyectLayers.remove(_layer);
    repaintOnce();
  }

  void toggleVisibility() {
    selectedLayer().toggleVisibility();
    repaintOnce();
  }

  void selectLayerColor(Color color) {
    selectedLayer().color = color;
    notifyListeners();
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

  void setColorFromPalete(Color newColor) {
    if (onBackgroundColorSelection) {
      backgroundColor = newColor;
    } else {
      selectedLayer().changeColor(newColor);
    }
    repaintOnce();
  }

  void repaintOnce() {
    notifyListeners();
  }

  void createLayer() {
    proyectLayers.forEach((element) {
      element.deselect();
    });
    var newLayer = LayerModel().randomLayer();
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

  void symetrizeMetri(int index) {
    selectedLayer().symetryc = !selectedLayer().symetryc;
    repaintOnce();
  }

  void dragMetriPoint(Offset delta, int index) {
    selectedLayer().mainPoints![index] += delta;
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