import 'package:flutter/material.dart';
import 'dart:math' as math;

class DiamondDecoration extends Decoration {
  final double size;
  final Color? fillColor;
  final Color borderColor;
  final double borderWidth;

  const DiamondDecoration({
    required this.size,
    this.fillColor,
    this.borderColor = Colors.black,
    this.borderWidth = 1.0,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _SingleDiamondPainter(
      size: size,
      fillColor: fillColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
    );
  }
}

class _SingleDiamondPainter extends BoxPainter {
  final double size;
  final Color? fillColor;
  final Color borderColor;
  final double borderWidth;

  _SingleDiamondPainter({
    required this.size,
    required this.fillColor,
    required this.borderColor,
    required this.borderWidth,
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    if (cfg.size == null) return;

    final tabSize = cfg.size!;
    final centerX = offset.dx + tabSize.width / 2;
    final bottomY = offset.dy + tabSize.height;

    final half = size / 2;

    final path = Path()
      ..moveTo(centerX, bottomY - size)
      ..lineTo(centerX + half, bottomY - half)
      ..lineTo(centerX, bottomY)
      ..lineTo(centerX - half, bottomY - half)
      ..close();

    // Fill
    if (fillColor != null) {
      final fillPaint = Paint()
        ..color = fillColor!
        ..style = PaintingStyle.fill
        ..isAntiAlias = true;
      canvas.drawPath(path, fillPaint);
    }

    // Border
    if (borderWidth > 0) {
      final borderPaint = Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth
        ..strokeJoin = StrokeJoin.miter
        ..isAntiAlias = true;
      canvas.drawPath(path, borderPaint);
    }
  }
}

class DiamondContainer extends StatelessWidget {
  final double size;
  final Color? fillColor;
  final Color borderColor;
  final double borderWidth;

  const DiamondContainer({
    super.key,
    required this.size,
    this.fillColor,
    required this.borderColor,
    required this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: math.pi / 4, // Rotates the square 45 degrees
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: fillColor,
          border: borderWidth == 0
              ? null
              : Border.all(color: borderColor, width: borderWidth),
        ),
      ),
    );
  }
}
