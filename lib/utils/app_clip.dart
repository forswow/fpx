import 'painter.dart';
import 'package:flutter/material.dart';

class AppClip extends StatelessWidget {
  const AppClip({
    Key? key,
    required this.colorStart,
    required this.colorEnd,
  }) : super(key: key);

  final Color colorStart, colorEnd;
  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: ClipPath(
        clipBehavior: Clip.hardEdge,
        clipper: WaveClipper(),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            colorStart,
            colorEnd,
          ])),
          height: 150,
        ),
      ),
    );
  }
}
