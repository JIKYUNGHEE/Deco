import 'dart:math' as math;
import 'package:flutter/material.dart';

class WobbleIconTile extends StatefulWidget {
  final Widget child; // 아이콘 박스(그라데이션+그림자 포함)
  final VoidCallback? onTap;

  /// 회전 각도(도 단위)
  final double degrees;

  /// 애니메이션 시간
  final Duration duration;

  /// 살짝 스케일(선택)
  final double pressedScale;

  const WobbleIconTile({
    super.key,
    required this.child,
    this.onTap,
    this.degrees = 7,
    this.duration = const Duration(milliseconds: 140),
    this.pressedScale = 0.98,
  });

  @override
  State<WobbleIconTile> createState() => _WobbleIconTileState();
}

class _WobbleIconTileState extends State<WobbleIconTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: widget.duration,
    reverseDuration: widget.duration,
  );

  late Animation<double> _rot;   // 라디안
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _rot = Tween<double>(begin: 0, end: widget.degrees * math.pi / 180).animate(
      CurvedAnimation(parent: _c, curve: Curves.easeOut, reverseCurve: Curves.easeOut),
    );
    _scale = Tween<double>(begin: 1.0, end: widget.pressedScale).animate(
      CurvedAnimation(parent: _c, curve: Curves.easeOut, reverseCurve: Curves.easeOut),
    );
  }

  @override
  void didUpdateWidget(covariant WobbleIconTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.degrees != widget.degrees) {
      _rot = Tween<double>(begin: 0, end: widget.degrees * math.pi / 180).animate(
        CurvedAnimation(parent: _c, curve: Curves.easeOut, reverseCurve: Curves.easeOut),
      );
    }
    if (oldWidget.pressedScale != widget.pressedScale) {
      _scale = Tween<double>(begin: 1.0, end: widget.pressedScale).animate(
        CurvedAnimation(parent: _c, curve: Curves.easeOut, reverseCurve: Curves.easeOut),
      );
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  void _down(TapDownDetails _) => _c.forward();
  void _cancel() => _c.reverse();

  Future<void> _up(TapUpDetails _) async {
    await _c.reverse();
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: _down,
      onTapCancel: _cancel,
      onTapUp: _up,
      child: AnimatedBuilder(
        animation: _c,
        builder: (_, child) {
          return Transform.rotate(
            angle: _rot.value,
            alignment: Alignment.center,
            child: Transform.scale(
              scale: _scale.value,
              child: child,
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}
