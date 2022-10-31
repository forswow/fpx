import 'package:flutter/material.dart';

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  final Color? bodyBackground;
  final Color? headerBackground;
  final Color? backPaintColor;
  final Color? fieldPaintColor;

  const CustomColors(
      {required this.bodyBackground,
      required this.headerBackground,
      required this.backPaintColor,
      required this.fieldPaintColor});

  @override
  CustomColors copyWith(
      {Color? bodyBackground,
      Color? headerBackground,
      Color? backPaintColor,
      Color? fieldPaintColor}) {
    return CustomColors(
        bodyBackground: bodyBackground ?? this.bodyBackground,
        headerBackground: headerBackground ?? this.headerBackground,
        backPaintColor: backPaintColor ?? this.backPaintColor,
        fieldPaintColor: fieldPaintColor ?? this.fieldPaintColor);
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      bodyBackground: Color.lerp(bodyBackground, other.bodyBackground, t),
      headerBackground: Color.lerp(headerBackground, other.headerBackground, t),
      backPaintColor: Color.lerp(backPaintColor, other.backPaintColor, t),
      fieldPaintColor: Color.lerp(fieldPaintColor, other.fieldPaintColor, t),
    );
  }
}
