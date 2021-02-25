import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'dart:math';

class Background extends StatefulWidget {
  final delay;
  Background({this.delay});
  @override
  _BackgroundState createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  Color backColor = Colors.pinkAccent;

  @override
  void initState() {
    Timer(
      Duration(milliseconds: widget.delay),
      () => changeColors(),
    );

    super.initState();
  }

  void changeColors() {
    setState(() {
      backColor = Colors.white.withOpacity(0);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple[700], Colors.blue[700]],
            ),
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: Sun(),
          ),
        ),
        BlurContainer(),
        Sun(),
        IgnorePointer(
          ignoring: true,
          child: SunErase(),
        ),
        IgnorePointer(
          ignoring: true,
          child: _OldTvFx(),
        ),
        IgnorePointer(
          ignoring: true,
          child: AnimatedContainer(
            height: MediaQuery.of(context).size.height,
            duration: Duration(seconds: 1),
            color: backColor,
          ),
        ),
      ],
    );
  }
}

class BlurContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      child: Center(
        child: ClipRect(
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(
              sigmaX: 5.0,
              sigmaY: 5.0,
            ),
            child: Container(
              alignment: Alignment.center,
              width: 220.0,
              height: 220.0,
              child: Text(" "),
            ),
          ),
        ),
      ),
    );
  }
}

class Sun extends StatelessWidget {
  final child;
  Sun({this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      child: Center(
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.yellow, Colors.pink],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
            borderRadius: BorderRadius.circular(500),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.pink.withOpacity(0.2),
              highlightColor: Colors.yellow.withOpacity(0.2),
              borderRadius: BorderRadius.circular(500),
              onTap: () => {},
              child: Center(
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SunErase extends StatelessWidget {
  final baseDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.purple[700], Colors.blue[700]],
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 70),
        Container(height: 2, decoration: baseDecoration),
        Container(height: 10),
        Container(height: 2, decoration: baseDecoration),
        Container(height: 10),
        Container(height: 2, decoration: baseDecoration),
        Container(height: 10),
        Container(height: 3, decoration: baseDecoration),
        Container(height: 10),
        Container(height: 5, decoration: baseDecoration),
        Container(height: 10),
        Container(height: 6, decoration: baseDecoration),
        Container(height: 10),
        Container(height: 7, decoration: baseDecoration),
        Container(height: 10),
        Container(height: 9, decoration: baseDecoration),
        Container(height: 10),
        Container(height: 11, decoration: baseDecoration),
        Container(height: 10),
        Container(height: 13, decoration: baseDecoration),
      ],
    );
  }
}

class _OldTvFx extends StatefulWidget {
  @override
  _OldTvFxState createState() => _OldTvFxState();
}

class _OldTvFxState extends State<_OldTvFx> {
  final List<Color> colors = _fillColors();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}

_fillColors() {
  final List<Color> colors = List();
  for (int i = 0; i < 150; i++) {
    var opacity = Random.secure().nextDouble() * 0.05 + 0.01;
    colors.add(Colors.black.withOpacity(opacity));
    colors.add(Colors.white.withOpacity(opacity));
  }
  return colors;
}
