import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sashimetriweb/models/sashimetrimodel.dart';
import 'package:scoped_model/scoped_model.dart';

class MovablePanel extends StatefulWidget {
  MovablePanel({Key key}) : super(key: key);

  @override
  _MovablePanelState createState() => _MovablePanelState();
}

class _MovablePanelState extends State<MovablePanel> {
  DragPoints previewPosition = DragPoints.left;
  bool onDragView = false;
  @override
  Widget build(BuildContext context) {
    final model = SashimetriModel.of(context);
    bool onDragView = ScopedModel.of<SashimetriModel>(context).onDrawView;
    return Stack(
      children: [
        if (onDragView) BottomDropPreview(),
        if (onDragView) TopDropPreview(),
        if (onDragView) LeftDropPreview(),
        if (onDragView) RightDropPreview(),
        ToolsPanel(),
        if (model.onDragPanel) DragablePanel(),
      ],
    );
  }
}

enum DragPoints { top, bottom, left, right }

class DragablePanel extends StatefulWidget {
  DragablePanel({Key key}) : super(key: key);

  @override
  _DragablePanelState createState() => _DragablePanelState();
}

class _DragablePanelState extends State<DragablePanel> {
  bool onDrag = false;

  @override
  Widget build(BuildContext context) {
    final model = SashimetriModel.of(context);
    return Draggable(
      child: Container(
        color: Colors.transparent,
      ),
      feedback: Container(
        child: DragItem(),
      ),
      childWhenDragging: Container(
        child: DragItem(),
      ),
      onDragStarted: () {
        model.starDragView();
      },
      onDragCompleted: () {
        model.endDragView();
      },
      onDragEnd: (drag) {
        model.endDragView();
      },
    );
  }
}

class ToolsPanel extends StatelessWidget {
  const ToolsPanel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade700,
      child: Container(
        width: 350,
        child: Column(
          children: [
            Container(
              height: 1,
              color: Colors.grey.shade800,
            ),
            Container(
              height: 1,
              color: Colors.grey.shade800,
            ),
            Container(
              height: 1,
              color: Colors.grey.shade800,
            ),
            //BlendModeWidget(),
          ],
        ),
      ),
    );
  }
}

class DragItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.view_headline,
      size: 30,
    );
  }
}

class RightDropPreview extends StatelessWidget {
  const RightDropPreview({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(),
          flex: 6,
        ),
        DropPreview(
          dragablePosition: DragPoints.right,
          clipper: RightClipper(),
          boxConstraints: BoxConstraints(
            maxWidth: 80,
            maxHeight: double.infinity,
          ),
        ),
      ],
    );
  }
}

class LeftDropPreview extends StatelessWidget {
  const LeftDropPreview({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DropPreview(
          dragablePosition: DragPoints.left,
          clipper: LeftCliper(),
          boxConstraints: BoxConstraints(
            maxWidth: 80,
            maxHeight: double.infinity,
          ),
        ),
        Expanded(
          child: Container(),
          flex: 6,
        ),
      ],
    );
  }
}

class TopDropPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropPreview(
          dragablePosition: DragPoints.top,
          clipper: TopClipper(),
          boxConstraints: BoxConstraints(
            maxHeight: 80,
            maxWidth: double.infinity,
          ),
        ),
        Expanded(
          child: Container(),
          flex: 6,
        ),
      ],
    );
  }
}

class BottomDropPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(),
          flex: 6,
        ),
        DropPreview(
          dragablePosition: DragPoints.bottom,
          clipper: BottomClipper(),
          boxConstraints: BoxConstraints(
            maxHeight: 80,
            maxWidth: double.infinity,
          ),
        ),
      ],
    );
  }
}

class DropPreview extends StatefulWidget {
  final BoxConstraints boxConstraints;
  final DragPoints dragablePosition;
  final clipper;
  DropPreview(
      {Key key,
      this.clipper,
      this.boxConstraints,
      @required this.dragablePosition})
      : super(key: key);

  @override
  _DropPreviewState createState() => _DropPreviewState();
}

class _DropPreviewState extends State<DropPreview> {
  Duration d500 = Duration(milliseconds: 500);
  Curve ease = Curves.ease;
  bool onHover = false;
  @override
  Widget build(BuildContext context) {
    final model = SashimetriModel.of(context);
    return ConstrainedBox(
      constraints: widget.boxConstraints,
      child: ClipPath(
        clipper: widget.clipper,
        child: AnimatedContainer(
          duration: d500,
          width: double.infinity,
          curve: ease,
          decoration: BoxDecoration(
            color: onHover
                ? Colors.black.withAlpha(60)
                : Colors.black.withAlpha(30),
          ),
          child: InkWell(
            mouseCursor: MouseCursor.uncontrolled,
            onHover: (value) {
              setState(() {
                onHover = value;
                model.setNewToolPosition(widget.dragablePosition);
              });
            },
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {},
          ),
        ),
      ),
    );
  }
}

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    List<Offset> points = new List();
    points.add(Offset(0, size.height));
    points.add(Offset(size.height, 0));
    points.add(Offset(size.width - size.height, 0));
    points.add(Offset(size.width, size.height));
    path.addPolygon(points, true);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    List<Offset> points = new List();
    points.add(Offset(0, 0));
    points.add(Offset(size.height, size.height));
    points.add(Offset(size.width - size.height, size.height));
    points.add(Offset(size.width, 0));
    path.addPolygon(points, true);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class LeftCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    List<Offset> points = new List();
    points.add(Offset(0, 0));
    points.add(Offset(size.height, size.height));
    points.add(Offset(size.width, size.height - size.width));
    points.add(Offset(0, size.height));
    path.addPolygon(points, true);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class RightClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    List<Offset> points = new List();
    points.add(Offset(size.width, 0));
    points.add(Offset(0, size.width));
    points.add(Offset(0, size.height - size.width));
    points.add(Offset(size.width, size.height));
    path.addPolygon(points, true);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
