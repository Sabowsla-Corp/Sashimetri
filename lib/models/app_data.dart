import 'package:flutter/material.dart';
import 'package:sashimetri/workspace/sashi_functions.dart';
import 'layer_model.dart';
import '../tools/toolpanel.dart';
import 'package:scoped_model/scoped_model.dart';

class AppData extends Model {
  AppData() {
    setupAppData();
  }
  static AppData of(BuildContext context, {bool rebuild: true}) {
    return ScopedModel.of<AppData>(context, rebuildOnChange: rebuild);
  }

  int selectedMetriIndex = 0;
  int lastMetriPointIndex = 0;
  bool canChangeMetriIndex = true;
  bool onBackgroundColorSelection = false;
  DragPoints currentToolPostion = DragPoints.left;
  Color backgroundColor = Colors.black;
  BlendMode blendMode = BlendMode.srcOver;
  Offset canvasCenter = Offset(0, 0);
  List<LayerModel> proyectLayers = [];
  LayerModel selectedLayer = LayerModel(
    points: [
      Offset(300, 0),
      Offset(300, 0),
      Offset(300, 0),
    ],
    grid: createSquaredGrid(50, 10),
  );

  void setupAppData() {
    selectedLayer = LayerModel(
      points: [
        Offset(300, 0),
        Offset(300, 0),
        Offset(300, 0),
      ],
      grid: createSquaredGrid(50, 10),
    );
    proyectLayers.add(selectedLayer);
    notifyListeners();
  }

  void selectLayer(LayerModel _layerModel) {
    selectedLayer = _layerModel;
    notifyListeners();
  }

  void setNewToolPosition(DragPoints newPosition) {
    currentToolPostion = newPosition;
    updateConstraints(newPosition);
    notifyListeners();
  }

  void updateConstraints(DragPoints newPosition) {}

  void snapMetriToItsGrid() {
    selectedLayer.snapPoints();
    notifyListeners();
  }

  void deleteSelectedMetri() {
    proyectLayers.removeAt(selectedMetriIndex);
    selectedMetriIndex--;
    selectedLayer = proyectLayers[selectedMetriIndex];

    repaintOnce();
  }

  void changeGlowSize(double newSize) {
    selectedLayer.glowSize = newSize;
    repaintOnce();
  }

  void ajustarDivisionesRadiales(int newDivisiones) {
    selectedLayer.radialDivisions = newDivisiones;

    selectedLayer.snapPoints();

    repaintOnce();
  }

  void adjustGridScale(double deltaScale) {
    selectedLayer.adjustGridScale(deltaScale);
    repaintOnce();
  }

  void ajustarExtensionCuadricula(int extent) {
    selectedLayer.gridExtent = extent;

    selectedLayer.snapPoints();

    repaintOnce();
  }

  void cambiarGrosor(double newGrosor) {
    selectedLayer.thickness = newGrosor;
    repaintOnce();
  }

  void setGridType(GridType _newGrid) {
    selectedLayer.setGridType(_newGrid);
    selectedLayer.snapPoints();
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
    selectedLayer.symetryc = !selectedLayer.symetryc;
    repaintOnce();
  }

  void ajustarSubdivisionesMetri(int newSubdvs) {
    selectedLayer.subdivisions = newSubdvs;
    repaintOnce();
  }



  void initWorkSpace() {
    if (proyectLayers.length == 0) createLayer();
  }


 
  void toggleBackgroundColorSelecion() {
    onBackgroundColorSelection = !onBackgroundColorSelection;

    notifyListeners();
  }

  void setColorFromPalete(Color newColor) {
    if (onBackgroundColorSelection) {
      backgroundColor = newColor;
    } else {
      selectedLayer.changeColor(newColor);
    }
    repaintOnce();
  }

  void changeActiveShape(int index) {
    selectedMetriIndex = index;
    selectedLayer = proyectLayers[selectedMetriIndex];
    notifyListeners();
  }

  void repaintOnce() {
    notifyListeners();
  }

  void createLayer() {
    selectedLayer = LayerModel(
      points: [
        Offset(300, 0),
        Offset(300, 0),
        Offset(300, 0),
      ],
      grid: createSquaredGrid(50, 10),
    );
    proyectLayers.add(selectedLayer);
    selectedLayer.snapPoints();
    for (int i = 0; i < proyectLayers.length; i++) {
      proyectLayers[i].selected = false;
    }

    proyectLayers.add(selectedLayer);

    selectedMetriIndex = proyectLayers.length - 1;
    repaintOnce();
  }

  void deleteMetri(int index) {
    if (proyectLayers.length > 1) {
      proyectLayers.removeAt(index);
    }
    selectedMetriIndex = proyectLayers.length - 1;
    selectedLayer = proyectLayers[selectedMetriIndex];
    selectedLayer.selected = true;
    repaintOnce();
  }

  void selectMetri(int index) {
    selectedLayer.selected = false;
    selectedLayer = proyectLayers[index];
    selectedLayer.selected = true;
    selectedMetriIndex = index;
    repaintOnce();
  }

  void symetrizeMetri(int index) {
    selectedLayer.symetryc = !selectedLayer.symetryc;
    repaintOnce();
  }

  void dragMetriPoint(Offset delta, int index) {
    selectedLayer.points[index] += delta;
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
