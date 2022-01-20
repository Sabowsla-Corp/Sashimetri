import 'package:flutter/material.dart';
import 'package:sashimetri/workspace/sashimetrifunctions.dart';
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

  LayerModel selectedLayer;
  int blendModeIndex = 0;
  int selectedMetriIndex = 0;
  int lastMetriPointIndex = 0;
  bool symmetry = false;
  bool onDrawView = false;
  bool onDragPanel = false;
  bool onTranslateMode = false;
  bool repaintWorkspace = true;
  bool cuadriculaActiva = false;
  bool canChangeMetriIndex = true;
  bool onBackgroundColorSelection = false;

  DragPoints currentToolPostion = DragPoints.left;

  Color currentColor;
  double maxGlow = 5;
  double glowSize = 2;
  double minGlow = 0;
  double gridScale = 50;
  int gridExtent = 20;
  int radialDivisions = 20;
  List<Offset> grid;
  Color backgroundColor = Colors.black;
  BlendMode blendMode = BlendMode.srcOver;

  Offset canvasCenter = Offset(0, 0);

  GridType tipoCuadricula = GridType.squared;
  List<LayerModel> proyectLayers = [];


  void setupAppData() {}

  void selectLayer(LayerModel _layerModel) {
    selectedLayer = _layerModel;
    notifyListeners();
  }

  void starDragView() {
    onDrawView = true;
    notifyListeners();
  }

  void endDragView() {
    onDrawView = false;
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

  void startRepaint() {
    repaintWorkspace = true;
    notifyListeners();
  }

  void deleteSelectedMetri() {
    proyectLayers.removeAt(selectedMetriIndex);
    selectedMetriIndex--;
    selectedLayer = proyectLayers[selectedMetriIndex];

    repaintOnce();
  }

  void stopRepaint() {
    Future.delayed(const Duration(milliseconds: 500), () {
      repaintWorkspace = false;
      notifyListeners();
    });
  }

  void changeGlowSize(double newSize) {
    glowSize = newSize;

    repaintOnce();
  }

  void ajustarDivisionesRadiales(int newDivisiones) {
    radialDivisions = newDivisiones;
    actualizarCuadricula();
    proyectLayers.forEach((element) {
      element.grid = grid;
      element.snapPoints();
    });

    repaintOnce();
  }

  void ajustarEscalaCuadricula(double deltaScale) {
    gridScale += deltaScale;
    if (gridScale < 30) {
      gridScale = 30;
    }
    actualizarCuadricula();
    proyectLayers.forEach((element) {
      element.grid = grid;
      element.snapPoints();
    });

    repaintOnce();
  }

  void ajustarExtensionCuadricula(int extent) {
    gridExtent = extent;
    actualizarCuadricula();
    proyectLayers.forEach((element) {
      element.grid = grid;
      element.snapPoints();
    });

    repaintOnce();
  }

  void actualizarCuadricula() {
    switch (tipoCuadricula) {
      case GridType.circular:
        grid = createCircularGrid(radialDivisions, gridExtent, gridScale);
        break;
      case GridType.squared:
        grid = createSquaredGrid(gridScale, gridExtent);
        break;
    }
  }

  void cambiarGrosor(double newGrosor) {
    selectedLayer.thickness = newGrosor;
    repaintOnce();
  }

  void cambiarTipoDeCuadricula() {
    if (tipoCuadricula == GridType.circular) {
      tipoCuadricula = GridType.squared;
    } else {
      tipoCuadricula = GridType.circular;
    }
    actualizarCuadricula();
    proyectLayers.forEach((element) {
      element.grid = grid;
      element.snapPoints();
    });
    repaintOnce();
  }

  void changeBackgroundColor(Color newColor) {
    backgroundColor = newColor;
    repaintOnce();
  }

  void changeBlendMode(BlendMode newBlendMode) {
    blendMode = newBlendMode;
    blendModeIndex = BlendMode.values.indexOf(blendMode);
    repaintOnce();
  }

  void changeBlenModeIndex(int index) {
    blendModeIndex = index;

    if (BlendMode.values[index] != BlendMode.dst &&
        BlendMode.values[index] != BlendMode.clear) {
      blendMode = BlendMode.values[index];
    }

    repaintOnce();
  }

  String getBlendModeName() {
    return blendMode.toString().replaceAll("BlendMode.", "").toUpperCase();
  }

  void toggleSymmetry() {
    symmetry = !symmetry;
    repaintOnce();
  }

  void ajustarSubdivisionesMetri(int newSubdvs) {
    selectedLayer.subdivisions = newSubdvs;
    repaintOnce();
  }

  void toggleTranslateMode() {
    onTranslateMode = !onTranslateMode;
    print("Translate Mode");
    notifyListeners();
  }

  void resetCenter(Size windowSize) {
    onTranslateMode = false;
    canvasCenter = Offset(windowSize.width / 2, windowSize.height / 2);
    notifyListeners();
  }

  void initWorkSpace() {
    if (proyectLayers.length == 0) createLayer();
  }

  void moveCenterByDelta(Offset delta) {
    canvasCenter += delta;
    repaintOnce();
  }

  void setCenter(Offset position) {
    canvasCenter = position;
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
      selectedLayer.changeColor(newColor);
    }
    repaintOnce();
  }

  void toggleDragPanels() {
    onDragPanel = !onDragPanel;
    notifyListeners();
  }

  void changeActiveShape(int index) {
    selectedMetriIndex = index;
    selectedLayer = proyectLayers[selectedMetriIndex];
    notifyListeners();
  }

  void repaintOnce() {
    repaintWorkspace = true;
    notifyListeners();
    stopRepaint();
  }

  void createLayer() {
    actualizarCuadricula();
    selectedLayer = LayerModel(
      points: [
        Offset(300, 0),
        Offset(0, 0),
        Offset(0, 300),
      ],
      color: Colors.grey,
      selected: true,
      grid: grid,
      gridType: tipoCuadricula,
      gridSnapping: cuadriculaActiva,
    );
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

  void mostrarCuadricula() {
    cuadriculaActiva = !cuadriculaActiva;
    proyectLayers.forEach((element) {
      element.gridSnapping = cuadriculaActiva;
    });
    repaintOnce();
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
