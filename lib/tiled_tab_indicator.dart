library tiled_tab_indicator;

import 'package:flutter/widgets.dart';

/// The styling of the indicator
enum TiledIndicatorStyle {
  /// Square Rects
  normal,

  /// Outer edges of the indicator are round
  round,
}

/// A TabIndicator that can have multiple colored tiles.
/// Used with [TabBar.indicator] to draw a rectangles in a line below the
/// selected tab.
@immutable
class TiledTabIndicator extends Decoration {
  /// Height of the [TiledTabIndicator]
  final double indicatorHeight;

  /// Colors to use for the tiles,
  /// colors appear in order, index 0 = first color...
  final List<Color> colors;

  /// Style of the indicator
  /// see [TiledIndicatorStyle] for the options
  final TiledIndicatorStyle style;

  /// Creates an underline style tab indicator with colored tiles.
  ///
  /// There are no colors by default, so if you pass an empty
  /// list, the indicator will not be shown
  ///
  /// By default, the style is [TiledIndicatorStyle.normal]
  const TiledTabIndicator(
      {@required this.indicatorHeight, @required this.colors, this.style})
      : assert(indicatorHeight != null),
        assert(colors != null);

  @override
  _TiledIndicatorPainter createBoxPainter([VoidCallback onChanged]) {
    return new _TiledIndicatorPainter(this, onChanged);
  }
}

class _TiledIndicatorPainter extends BoxPainter {
  final TiledTabIndicator decoration;

  _TiledIndicatorPainter(this.decoration, VoidCallback onChanged)
      : assert(decoration != null),
        super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);

    /// internal offset, so the rects don't stack on top of each other
    final off = configuration.size.width / decoration.colors.length;
    // possible rounding for the corners
    final rounding = Radius.circular(decoration.indicatorHeight / 2.0);
    for (int i = 0; i < decoration.colors.length; i++) {
      final Color color = decoration.colors[i];
      final Paint paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;
      Rect rect = Offset(offset.dx + off * i,
              configuration.size.height - decoration.indicatorHeight) &
          Size(configuration.size.width / decoration.colors.length,
              decoration.indicatorHeight);
      // styling
      switch (decoration.style ?? TiledIndicatorStyle.normal) {
        case TiledIndicatorStyle.normal:
          canvas.drawRect(rect, paint);
          break;
        case TiledIndicatorStyle.round:
          // only round the outer corners
          if (decoration.colors.length == 1) {
            // length of 1 needs both left and right corners rounded
            canvas.drawRRect(
                RRect.fromRectAndCorners(
                  rect,
                  topLeft: rounding,
                  bottomLeft: rounding,
                  topRight: rounding,
                  bottomRight: rounding,
                ),
                paint);
          } else if (i == 0) {
            // if length > 1, index 0 should only round left corners
            canvas.drawRRect(
                RRect.fromRectAndCorners(
                  rect,
                  topLeft: rounding,
                  bottomLeft: rounding,
                ),
                paint);
          } else if (i == decoration.colors.length - 1) {
            // if length > 1, last index should only round right corners
            canvas.drawRRect(
                RRect.fromRectAndCorners(
                  rect,
                  topRight: rounding,
                  bottomRight: rounding,
                ),
                paint);
          } else {
            // if length > 1, indexes in the middle should not round corners
            canvas.drawRect(rect, paint);
          }

          break;
      }
    }
  }
}
