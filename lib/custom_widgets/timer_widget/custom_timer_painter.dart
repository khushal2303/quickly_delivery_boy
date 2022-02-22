import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:quickly_delivery/styles/colors.dart';

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter(
      {this.animation,
      this.fillColor,
      this.fillGradient,
      this.ringColor,
      this.ringGradient,
      this.strokeWidth,
      this.strokeCap,
      this.backgroundColor,
      this.backgroundGradient})
      : super(repaint: animation);

  final Animation<double>? animation;
  final Color? fillColor, ringColor, backgroundColor;
  final double? strokeWidth;
  final StrokeCap? strokeCap;
  final Gradient? fillGradient, ringGradient, backgroundGradient;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = ringColor!
      ..strokeWidth = strokeWidth!
      ..strokeCap = strokeCap!
      ..style = PaintingStyle.stroke;

    if (ringGradient != null) {
      final rect = Rect.fromCircle(
          center: size.center(Offset.zero), radius: size.width / 2);
      paint..shader = ringGradient!.createShader(rect);
    } else {
      paint..shader = null;
    }

    final backgroundPaint = Paint();
    backgroundPaint.color = backgroundColor!;
    backgroundPaint.shader = RadialGradient(colors: [
      AppColors.primaryColor,
      Color(0xff2C295E),
      AppColors.primaryColor,
      Color(0xff2C295E),
      Color(0xff2C295E),
    ], stops: [
      0.0,
      1,
      0.5,
      0.7,
      0.4,
    ]).createShader(Rect.fromCircle(
      center: size.center(Offset.zero),
      radius: size.width / 1.9,
    ));
    canvas.drawCircle(
        size.center(Offset.zero), size.width / 1.9, backgroundPaint);

    canvas.drawCircle(size.center(Offset.zero), size.width / 1.9, paint);
    double progress = (animation!.value) * 2 * math.pi;

    if (fillGradient != null) {
      final rect = Rect.fromCircle(
          center: size.center(Offset.zero), radius: size.width / 2);
      paint..shader = fillGradient!.createShader(rect);
    } else {
      paint..shader = null;
      paint.color = fillColor!;
    }

    canvas.drawArc(Offset.zero & size, math.pi * 1.5, progress, false, paint);

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = math.min(size.width / 2, size.height / 2);
    double angle = 2 * math.pi * (progress / 100);

    final offset = Offset(
      center.dx + radius * math.cos(-math.pi / 2 + progress),
      center.dy + radius * math.sin(-math.pi / 2 + progress),
    );
    canvas.drawCircle(
      offset,
      8,
      Paint()
        ..strokeWidth = 5
        ..color = AppColors.primaryColor
        ..style = PaintingStyle.fill,
    );
    canvas.drawCircle(
      offset,
      5,
      Paint()
        ..strokeWidth = 5
        ..color = AppColors.whiteColor
        ..style = PaintingStyle.fill,
    );

    if (backgroundColor != null || backgroundGradient != null) {
      final backgroundPaint = Paint();

      if (backgroundGradient != null) {
        final rect = Rect.fromCircle(
            center: size.center(Offset.zero), radius: size.width / 2.2);
        backgroundPaint..shader = backgroundGradient!.createShader(rect);
      } else {
        backgroundPaint.color = backgroundColor!;
      }
      // canvas.drawCircle(
      //     size.center(Offset.zero), size.width / 1.9, backgroundPaint);
    }
  }

  @override
  bool shouldRepaint(CustomTimerPainter old) {
    return animation!.value != old.animation!.value ||
        ringColor != old.ringColor ||
        fillColor != old.fillColor;
  }
}
