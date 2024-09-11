import 'package:flutter/material.dart';

import '../../res/colours.dart';
import 'custom_container_clipper.dart';

class ButtonBackround extends StatelessWidget {
  const ButtonBackround({
    super.key,
    required this.width,
    required this.height,
    this.child,
    this.active = true,
  });

  final double width;
  final double height;
  final bool active;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return active
        ? ClipPath(
            clipper: CustomContainerClipper(
              topLeftOffset: 10,
              topRightOffset: 0,
              bottomLeftOffset: 0,
              bottomRightOffset: 10,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  gradient: Colours.lightLinearGradient(opacity: 1),
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: Colors.white.withOpacity(0.1),
                      width: 1,
                    ),
                    // vertical: BorderSide(
                    //   color: Colors.black.withOpacity(0.5),
                    //   width: 2,
                    // ),
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.elliptical(27, 18),
                    bottomRight: Radius.elliptical(27, 18),
                    bottomLeft: Radius.elliptical(12, 9),
                    topRight: Radius.elliptical(12, 9),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(2, 1),
                    ),
                  ],
                ),
                child: child,
              ),
            ),
          )
        : child ?? const SizedBox();
  }
}
