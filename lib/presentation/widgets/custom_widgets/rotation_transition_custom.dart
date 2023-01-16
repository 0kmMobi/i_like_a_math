import 'dart:math' as math;
import 'package:flutter/material.dart';

class RotationTransitionCustom extends RotationTransition {
  final bool reversed;
  const RotationTransitionCustom({super.key, required super.turns, required super.child, this.reversed = false});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: (reversed? -2.0:2.0) * turns.value * math.pi,
      alignment: alignment,
      filterQuality: filterQuality,
      child: child,
    );
  }

}