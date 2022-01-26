
import 'package:flutter/material.dart';

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    List<Offset> points = [];
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
    List<Offset> points = [];
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
    List<Offset> points = [];
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
    List<Offset> points = [];
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