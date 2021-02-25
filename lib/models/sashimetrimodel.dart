import 'package:flutter/material.dart';
import 'package:sashimetriweb/workspace/sashimetrifunctions.dart';
import 'metrimodel.dart';
import '../tools/toolpanel.dart';
import '../mainwindow/newsashiprojectview.dart';
import 'package:scoped_model/scoped_model.dart';

class SashimetriModel extends Model {
  Metri selectedMetri;
  int selectedMetriIndex = 0;

  bool onWorkSpace = true;

  static SashimetriModel of(BuildContext context, {bool rebuild: true}) =>
      ScopedModel.of<SashimetriModel>(context, rebuildOnChange: rebuild);

  void createNewProject(ProjectType type) {
    onWorkSpace = true;
    notifyListeners();
  }

  void exitWorkSpace() {
    onWorkSpace = false;
    notifyListeners();
  }

  //Tool Panel COnfig

  bool onDrawView = false;
  DragPoints currentToolPostion = DragPoints.left;

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
    selectedMetri.snapPoints();
    notifyListeners();
  }

  double glowSize = 2;
  Color currentColor;

  bool repaintWorkspace = true;

  void startRepaint() {
    repaintWorkspace = true;
    notifyListeners();
  }

  void deleteSelectedMetri() {
    projectMetris.removeAt(selectedMetriIndex);
    selectedMetriIndex--;
    selectedMetri = projectMetris[selectedMetriIndex];

    repaintOnce();
  }

  void stopRepaint() {
    Future.delayed(const Duration(milliseconds: 500), () {
      repaintWorkspace = false;
      notifyListeners();
    });
  }

  double maxGlow = 5;
  double minGlow = 0;

  void changeGlowSize(double newSize) {
    glowSize = newSize;

    repaintOnce();
  }

  double gridScale = 50;
  int gridExtent = 20;
  int radialDivisions = 20;

  List<Offset> grid;

  void ajustarDivisionesRadiales(int newDivisiones) {
    radialDivisions = newDivisiones;
    actualizarCuadricula();
    projectMetris.forEach((element) {
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
    projectMetris.forEach((element) {
      element.grid = grid;
      element.snapPoints();
    });

    repaintOnce();
  }

  void ajustarExtensionCuadricula(int extent) {
    gridExtent = extent;
    actualizarCuadricula();
    projectMetris.forEach((element) {
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
    selectedMetri.thickness = newGrosor;
    repaintOnce();
  }

  void cambiarTipoDeCuadricula() {
    if (tipoCuadricula == GridType.circular) {
      tipoCuadricula = GridType.squared;
    } else {
      tipoCuadricula = GridType.circular;
    }
    actualizarCuadricula();
    projectMetris.forEach((element) {
      element.grid = grid;
      element.snapPoints();
    });
    repaintOnce();
  }

  Color backgroundColor = Colors.black;

  void changeBackgroundColor(Color newColor) {
    backgroundColor = newColor;
    repaintOnce();
  }

  BlendMode blendMode = BlendMode.srcOver;
  int blendModeIndex = 0;

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

  bool symmetry = false;

  void toggleSymmetry() {
    symmetry = !symmetry;
    repaintOnce();
  }

  void ajustarSubdivisionesMetri(int newSubdvs) {
    selectedMetri.subdivisions = newSubdvs;
    repaintOnce();
  }

  bool onTranslateMode = false;

  void toggleTranslateMode() {
    onTranslateMode = !onTranslateMode;
    print("Translate Mode");
    notifyListeners();
  }

  Offset canvasCenter = Offset(0, 0);

  void resetCenter(Size windowSize) {
    onTranslateMode = false;
    canvasCenter = Offset(windowSize.width / 2, windowSize.height / 2);
    notifyListeners();
  }

  void initWorkSpace() {
    if (projectMetris.length == 0) createNewMetri();
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

  bool onBackgroundColorSelection = false;

  void setColorFromPalete(Color newColor) {
    if (onBackgroundColorSelection) {
      backgroundColor = newColor;
    } else {
      selectedMetri.changeColor(newColor);
    }
    repaintOnce();
  }

  bool onDragPanel = false;

  void toggleDragPanels() {
    onDragPanel = !onDragPanel;
    notifyListeners();
  }

  void changeActiveShape(int index) {
    selectedMetriIndex = index;
    selectedMetri = projectMetris[selectedMetriIndex];
    notifyListeners();
  }

  void repaintOnce() {
    repaintWorkspace = true;
    notifyListeners();
    stopRepaint();
  }

  List<Metri> projectMetris = List<Metri>();

  void createNewMetri() {
    actualizarCuadricula();
    selectedMetri = Metri(
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
    selectedMetri.snapPoints();
    for (int i = 0; i < projectMetris.length; i++) {
      projectMetris[i].selected = false;
    }

    projectMetris.add(selectedMetri);

    selectedMetriIndex = projectMetris.length - 1;
    repaintOnce();
  }

  void deleteMetri(int index) {
    if (projectMetris.length > 1) {
      projectMetris.removeAt(index);
    }
    selectedMetriIndex = projectMetris.length - 1;
    selectedMetri = projectMetris[selectedMetriIndex];
    selectedMetri.selected = true;
    repaintOnce();
  }

  void selectMetri(int index) {
    selectedMetri.selected = false;
    selectedMetri = projectMetris[index];
    selectedMetri.selected = true;
    selectedMetriIndex = index;
    repaintOnce();
  }

  void symetrizeMetri(int index) {
    selectedMetri.symetryc = !selectedMetri.symetryc;
    repaintOnce();
  }

  void dragMetriPoint(Offset delta, int index) {
    selectedMetri.points[index] += delta;
    notifyListeners();
  }

  bool cuadriculaActiva = false;
  GridType tipoCuadricula = GridType.squared;

  void mostrarCuadricula() {
    cuadriculaActiva = !cuadriculaActiva;
    projectMetris.forEach((element) {
      element.gridSnapping = cuadriculaActiva;
    });
    repaintOnce();
  }

  void changeMetriVisibility(int index) {
    projectMetris[index].toggleVisibility();
    repaintOnce();
  }

  bool canChangeMetriIndex = true;
  void disableMetriPointIndexChange(bool state) {
    canChangeMetriIndex = state;
    notifyListeners();
  }

  int lastMetriPointIndex = 0;

  void oldPointFn(int newPoint) {
    lastMetriPointIndex = newPoint;
  }
}
