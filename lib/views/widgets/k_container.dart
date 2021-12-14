import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Widget Interface class that allow users to pass properties to render object.
/// Users will use these class's properties to either create
/// or update the render object.
///
/// [RenderObjectWidget] has three sub classes such as
/// [LeafRenderObjectWidget] you want to use this when your widget takes no
/// children such as [SizedBox]
/// [SingleChildRenderObjectWidget] you want to use this when your widget takes
/// single child such as [Container]
/// [MultiChildRenderObjectWidget] you want to use this when your widget takes
/// multiple children such as [RichText] or [Column]
class KContainer extends LeafRenderObjectWidget {
  /// Initializing the constructor
  KContainer({
    Key key,
    this.width,
    this.height,
    this.color = Colors.transparent,
  })  : assert(height != null, 'Height must not be null'),
        assert(width != null, 'Width must not be null'),
        super(key: key);

  final double width;
  final double height;
  final Color color;

  /// Framework [Element] will call [createRenderObject] when it wants to create
  /// the render object [RenderKContainer] associated with this widget.
  @override
  RenderObject createRenderObject(BuildContext context) {
    /// Creating a new Instance of RenderKContainer
    return RenderKContainer(
      width: width,
      height: height,
      color: color,
    );
  }

  /// When a widget property changes, the system will call [updateRenderObject],
  /// which will simply update the public properties of the render object
  /// without recreating the whole object
  @override
  void updateRenderObject(BuildContext context, RenderKContainer renderObject) {
    /// Updating an existing instance of RenderKContainer
    renderObject
      ..width = width
      ..height = height
      ..color = color;
  }

  /// Provides information about the class properties during debugging.
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    /// Providing debug information
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('width', width));
    properties.add(DoubleProperty('height', height));
    properties.add(ColorProperty('color', color));
  }
}

class RenderKContainer extends RenderBox {
  RenderKContainer({
    @required double width,
    @required double height,
    @required Color color,
  })  : _width = width,
        _height = height,
        _color = color;

  double _width;
  double _height;
  Color _color;

  double get width => _width;

  double get height => _height;

  Color get color => _color;

  set width(double value) {
    if (_width == value) return;
    _width = value;
    markNeedsLayout();
  }

  set height(double value) {
    if (_height == value) return;
    _height = value;
    markNeedsLayout();
  }

  set color(Color value) {
    if (_color == value) return;
    _color = value;
    markNeedsPaint();
  }

  @override
  void performLayout() {
    size = computeDryLayout(constraints);
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final desiredWidth = width;
    final desiredHeight = height;
    final desiredSize = Size(desiredWidth, desiredHeight);
    return constraints.constrain(desiredSize);
  }

  // static const _minDesiredWidth = 0.0;
  // static const _minDesiredHeight = 0.0;
  //
  // @override
  // double computeMinIntrinsicWidth(double height) => _minDesiredWidth;
  //
  // @override
  // double computeMaxIntrinsicWidth(double height) => _minDesiredWidth;
  //
  // @override
  // double computeMinIntrinsicHeight(double width) => _minDesiredHeight;
  //
  // @override
  // double computeMaxIntrinsicHeight(double width) => _minDesiredHeight;

  @override
  void paint(PaintingContext context, Offset offset) {
    if (size > Size.zero) {
      context.canvas.drawRect(offset & size, Paint()..color = color);
    }
  }
}
