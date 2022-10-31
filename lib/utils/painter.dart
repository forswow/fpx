import 'dart:math';

import 'package:flutter/material.dart';

import '../screens/settings/settingsController.dart';

class HealthBar extends CustomPainter {
  HealthBar({required this.percent});
  final double percent;

  @override
  void paint(Canvas canvas, Size size) {
    final arcRect = const Offset(4, 4) & Size(size.width - 8, size.height - 8);
    const doublePi = pi * 2;
    const halfPi = pi / 2;

    final backPaint = Paint()
      ..color = SettingsController().isDark
                ? const Color(0xFF141C2B)
                : const Color(0xFFF7FAFE)
      ..style = PaintingStyle.fill;

    canvas.drawOval(Offset.zero & size, backPaint);

    final fieldPaint = Paint()
      ..color = SettingsController().isDark
                ? const Color(0xFF596882)
                : const Color(0xFFE3E7ED)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(arcRect, doublePi * percent - (halfPi),
        doublePi * (1.0 - percent), false, fieldPaint);

    final feelPaint = Paint()
      ..color = const Color(0xFF00B8D4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(arcRect, -halfPi, doublePi * percent, false, feelPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * .65);

    var firstControlPoint = Offset(0, size.height * .75);
    var firstEndPoint = Offset(size.width / 6, size.height * .75);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    path.lineTo(size.width / 1.2, size.height * .75);

    var secControlPoint = Offset(size.width, size.height * .75);
    var secEndPoint = Offset(size.width, size.height * 0.85);

    path.quadraticBezierTo(
        secControlPoint.dx, secControlPoint.dy, secEndPoint.dx, secEndPoint.dy);

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
