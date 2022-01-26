import 'dart:math' as math;
import 'package:flutter/material.dart';

/// A widget representing a rotating expand/collapse button. The icon rotates
/// 90 degrees when pressed, then reverts the animation on a second press.
/// The underlying icon is [Icons.expand_more].

class DragHeadToggler extends StatefulWidget {
  const DragHeadToggler({
    Key? key,
    this.isExpanded = false,
    this.size = 20.0,
    required this.onPressed,
    this.padding = const EdgeInsets.all(2),
    this.color,
    this.disabledColor,
    this.expandedColor,
  }) : super(key: key);

  final bool isExpanded;

  /// This property must not be null. It defaults to 20.0.
  final double size;

  /// The callback triggered when the icon is pressed and the state changes
  /// between expanded and collapsed. The value passed to the current state.
  ///
  /// If this is set to null, the button will be disabled.
  final ValueChanged<bool>? onPressed;

  /// The padding around the icon. The entire padded icon will react to input
  /// gestures.
  ///
  /// This property must not be null. It defaults to 8.0 padding on all sides.
  final EdgeInsetsGeometry padding;

  /// The color of the icon.
  ///
  /// Defaults to [Colors.black54] when the theme's
  /// [ThemeData.brightness] is [Brightness.light] and to
  /// [Colors.white60] when it is [Brightness.dark]. This adheres to the
  /// Material Design specifications for [icons](https://material.io/design/iconography/system-icons.html#color)
  /// and for [dark theme](https://material.io/design/color/dark-theme.html#ui-application)
  final Color? color;

  /// The color of the icon when it is disabled,
  /// i.e. if [onPressed] is null.
  ///
  /// Defaults to [Colors.black38] when the theme's
  /// [ThemeData.brightness] is [Brightness.light] and to
  /// [Colors.white38] when it is [Brightness.dark]. This adheres to the
  /// Material Design specifications for [icons](https://material.io/design/iconography/system-icons.html#color)
  /// and for [dark theme](https://material.io/design/color/dark-theme.html#ui-application)
  final Color? disabledColor;

  /// The color of the icon when the icon is expanded.
  ///
  /// Defaults to [Colors.black54] when the theme's
  /// [ThemeData.brightness] is [Brightness.light] and to
  /// [Colors.white] when it is [Brightness.dark]. This adheres to the
  /// Material Design specifications for [icons](https://material.io/design/iconography/system-icons.html#color)
  /// and for [dark theme](https://material.io/design/color/dark-theme.html#ui-application)
  final Color? expandedColor;

  @override
  State<DragHeadToggler> createState() => _DragHeadTogglerState();
}

class _DragHeadTogglerState extends State<DragHeadToggler>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconTurns;

  static final Animatable<double> _iconTurnTween =
      Tween<double>(begin: -0.25, end: 0)
          .chain(CurveTween(curve: Curves.fastOutSlowIn));

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _iconTurns = _controller.drive(_iconTurnTween);
    // If the widget is initially expanded, rotate the icon without animating it.
    if (widget.isExpanded) {
      _controller.value = math.pi;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(DragHeadToggler oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      if (widget.isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  void _handlePressed() {
    print("Pressing on layer toggler head");
    widget.onPressed?.call(widget.isExpanded);
  }

  /// Default icon colors and opacities for when [Theme.brightness] is set to
  /// [Brightness.light] are based on the
  /// [Material Design system icon specifications](https://material.io/design/iconography/system-icons.html#color).
  /// Icon colors and opacities for [Brightness.dark] are based on the
  /// [Material Design dark theme specifications](https://material.io/design/color/dark-theme.html#ui-application)
  Color get _iconColor {
    if (widget.isExpanded && widget.expandedColor != null) {
      return widget.expandedColor!;
    }

    if (widget.color != null) {
      return widget.color!;
    }

    switch (Theme.of(context).brightness) {
      case Brightness.light:
        return Colors.black54;
      case Brightness.dark:
        return Colors.white60;
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMaterialLocalizations(context));
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final String onTapHint = widget.isExpanded
        ? localizations.expandedIconTapHint
        : localizations.collapsedIconTapHint;

    return Semantics(
      onTapHint: widget.onPressed == null ? null : onTapHint,
      child: Container(
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: widget.padding,
            child: InkWell(
              onTap: widget.onPressed == null ? null : _handlePressed,
              child: RotationTransition(
                turns: _iconTurns,
                child: const Icon(Icons.expand_more),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
