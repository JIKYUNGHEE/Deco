import 'package:flutter/cupertino.dart';

class DecoPressScale extends StatefulWidget {
  final Widget child;
  final bool enabled;

  final double pressedScale;

  final Duration duration;
  final Curve curve;

  const DecoPressScale({
    super.key,
    required this.child,
    required this.enabled,
    this.pressedScale = 1.02,
    this.duration = const Duration(milliseconds: 90),
    this.curve = Curves.easeOut,
  });

  @override
  State<DecoPressScale> createState() => _DecoPressScaleState();
}

class _DecoPressScaleState extends State<DecoPressScale> {
  bool _pressed = false;

  void _setPressed(bool v) {
    if (!widget.enabled) return;
    if (_pressed == v) return;
    setState(() => _pressed = v);
  }
  @override
  Widget build(BuildContext context) {
    final scale = (!widget.enabled)
        ? 1.0
        : (_pressed ? widget.pressedScale : 1.0);

    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) => _setPressed(true),
      onPointerUp: (_) => _setPressed(false),
      onPointerCancel: (_) => _setPressed(false),
      child: AnimatedScale(
        scale: scale,
        duration: widget.duration,
        curve: widget.curve,
        child: widget.child,
      ),
    );
  }
}