import 'package:flutter/material.dart';

import '../../res/colours.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({
    required this.image,
    required this.child,
    super.key,
  });

  final String image;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            constraints: const BoxConstraints.expand(),
            height: double.infinity,
            color: Colours.primaryColour,
          ),
        ),
        child,
      ],
    );
  }
}
