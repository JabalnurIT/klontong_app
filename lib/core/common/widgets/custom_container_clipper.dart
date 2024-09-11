import 'package:flutter/material.dart';

class CustomContainerClipper extends CustomClipper<Path> {
  final double topLeftOffset;
  final double topRightOffset;
  final double bottomLeftOffset;
  final double bottomRightOffset;

  CustomContainerClipper({
    required this.topLeftOffset,
    required this.topRightOffset,
    required this.bottomLeftOffset,
    required this.bottomRightOffset,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(
        0, topLeftOffset); // Start at top-left with the specified offset
    path.lineTo(size.width,
        topRightOffset); // Line to top-right with the specified offset
    path.lineTo(
        size.width,
        size.height -
            bottomRightOffset); // Line to bottom-right with the specified offset
    path.lineTo(
        0,
        size.height -
            bottomLeftOffset); // Line to bottom-left with the specified offset
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
