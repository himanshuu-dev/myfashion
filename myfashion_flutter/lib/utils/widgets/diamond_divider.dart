import 'package:flutter/material.dart';
import 'dart:math' as math;

class DiamondDivider extends StatelessWidget {
  final double? width; // 👈 total width of divider
  final Color color;
  final double lineThickness;
  final double diamondSize;
  final double gap;

  const DiamondDivider({
    super.key,
    this.width = 130,
    this.color = Colors.grey,
    this.lineThickness = 1,
    this.diamondSize = 10,
    this.gap = 0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        children: [
          Expanded(child: _line()),
          SizedBox(width: gap),
          _diamond(),
          SizedBox(width: gap),
          Expanded(child: _line()),
        ],
      ),
    );
  }

  Widget _line() {
    return Container(height: lineThickness, color: color);
  }

  Widget _diamond() {
    return Transform.rotate(
      angle: math.pi / 4,
      child: Container(
        width: diamondSize,
        height: diamondSize,
        decoration: BoxDecoration(
          border: Border.all(color: color, width: lineThickness),
        ),
      ),
    );
  }
}
class DiamondDividerDecoration extends Decoration {
  final Color color;
  final Color filledColor; // New: Color inside the diamond
  final double lineThickness;
  final double diamondSize;
  final double gap;

  const DiamondDividerDecoration({
    this.color = Colors.orange,
    this.filledColor = Colors.white, // Default to white background
    this.lineThickness = 1,
    this.diamondSize = 8,
    this.gap = 4,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _DiamondPainter(
      color: color,
      filledColor: filledColor,
      lineThickness: lineThickness,
      diamondSize: diamondSize,
      gap: gap,
    );
  }
}

class _DiamondPainter extends BoxPainter {
  final Color color;
  final Color filledColor;
  final double lineThickness;
  final double diamondSize;
  final double gap;

  _DiamondPainter({
    required this.color,
    required this.filledColor,
    required this.lineThickness,
    required this.diamondSize,
    required this.gap,
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    if (configuration.size == null) return;

    final Rect rect = offset & configuration.size!;
    final double centerX = rect.center.dx;
    
    // Calculate vertical position:
    // We want the indicator at the bottom of the tab.
    // rect.bottom is the very edge. We move up slightly so the stroke isn't cut off.
    final double halfDiagonal = (diamondSize * math.sqrt(2)) / 2;
    final double centerY = rect.bottom - halfDiagonal - 1.0; 

    // 1. Define the Diamond Path
    final Path diamondPath = Path();
    diamondPath.moveTo(centerX, centerY - halfDiagonal); // Top
    diamondPath.lineTo(centerX + halfDiagonal, centerY); // Right
    diamondPath.lineTo(centerX, centerY + halfDiagonal); // Bottom
    diamondPath.lineTo(centerX - halfDiagonal, centerY); // Left
    diamondPath.close();

    // 2. Draw the Lines (Left and Right)
    final Paint linePaint = Paint()
      ..color = color
      ..strokeWidth = lineThickness
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round; // Softens the ends of the lines

    // Left Line
    canvas.drawLine(
      Offset(rect.left, centerY),
      Offset(centerX - halfDiagonal - gap, centerY),
      linePaint,
    );

    // Right Line
    canvas.drawLine(
      Offset(centerX + halfDiagonal + gap, centerY),
      Offset(rect.right, centerY),
      linePaint,
    );

    // 3. Draw the Diamond
    // First, fill it with white (to look hollow/opaque)
    canvas.drawPath(
      diamondPath,
      Paint()..color = filledColor..style = PaintingStyle.fill,
    );

    // Then, draw the colored border
    canvas.drawPath(
      diamondPath,
      Paint()
        ..color = color
        ..strokeWidth = lineThickness
        ..style = PaintingStyle.stroke,
    );
  }
}