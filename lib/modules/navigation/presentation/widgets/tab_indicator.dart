import 'package:flutter/material.dart';

class LittleTabIndicator extends Decoration {
  final BoxPainter _painter;

  LittleTabIndicator({
    required Color color,
  }) : _painter = _BoxPainter(color);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _BoxPainter extends BoxPainter {
  final Paint _paint;

  _BoxPainter(
    Color color,
  ) : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final double indicatorOffset = offset.dx + cfg.size!.width / 2 - 10;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(indicatorOffset, 1, 20, 3),
        const Radius.circular(20),
      ),
      _paint,
    );
  }
}
