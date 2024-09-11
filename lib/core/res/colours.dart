import 'package:flutter/material.dart';

class Colours {
  const Colours._();
  static const gradient = [
    Color(0xFFEDF8FF),
    Color(0xFFFDC1E8),
    Color(0xFFFFFFFF),
    Color(0xFFFDFAD1),
  ];

  static const Color primaryColour = Color(0xFF242C3B);

  static const Color secondaryColour = Color(0xFF37B6E9);

  static const Color tertiaryColour = Color(0xFF4B4CED);

  static const Color quaternaryColour = Color(0xFF353F54);

  static const Color quinaryColour = Color(0xFF222834);

  static const Color errorColour = Color(0xFFE74C3C);

  static const Color successColour = Color(0xFF2ECC71);

  static const Color warningColour = Color(0xFFF39C12);

  static const Color infoColour = Color(0xFF3498DB);

  static const Color primaryDisabledColour = Color(0xFFB0B0B0);

  static const Color secondaryDisabledColour = Color(0xFFD0D0D0);

  static const Color tertiaryDisabledColour = Color(0xFFE0E0E0);

  static const Color quaternaryDisabledColour = Color(0xFFC0C0C0);

  static const Color quinaryDisabledColour = Color(0xFFA0A0A0);

  static LinearGradient darkLinearGradient({
    AlignmentGeometry begin = Alignment.topCenter,
    AlignmentGeometry end = Alignment.bottomCenter,
    double opacity = 1,
  }) {
    return LinearGradient(
      colors: [
        const Color(0xFF363E51).withOpacity(opacity),
        const Color(0xFF181C24).withOpacity(opacity),
      ],
      begin: begin,
      end: end,
      stops: const [0.0, 1.0],
    );
  }

  static LinearGradient lightLinearGradient({
    AlignmentGeometry begin = Alignment.topCenter,
    AlignmentGeometry end = Alignment.bottomCenter,
    double opacity = 1,
  }) {
    return LinearGradient(
      colors: [
        const Color(0xFF34C8E8).withOpacity(opacity),
        const Color(0xFF4E4AF2).withOpacity(opacity),
      ],
      begin: begin,
      end: end,
      stops: const [0.0, 1.0],
    );
  }
}
