import 'package:flutter/material.dart';
import 'rotation_transition_custom.dart';

class WidgetRotator extends StatefulWidget {
  final int startDelayMSec;
  final int durationMSec;
  final Widget child;
  final bool reversed;

  const WidgetRotator({Key? key, required this.startDelayMSec, required this.durationMSec, this.reversed = false, required this.child}) : super(key: key);

  @override
  State<WidgetRotator> createState() => _WidgetRotatorState();
}

class _WidgetRotatorState extends State<WidgetRotator> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
      duration: Duration(milliseconds: widget.durationMSec),
      vsync: this);

  late final rotateAnimation =  CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.0, 0.5, curve: Curves.easeInOutBack),
  );

  late Future _futureStart;
  @override
  void initState() {
    super.initState();
    _futureStart = Future.delayed(Duration(milliseconds: widget.startDelayMSec), () {
      _controller.repeat();
    });
  }

  @override
  void didUpdateWidget(covariant WidgetRotator oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.duration = Duration(milliseconds: widget.durationMSec );
  }

  @override
  void dispose() {
    _futureStart.ignore();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      return RotationTransitionCustom(
        reversed: widget.reversed,
        turns: rotateAnimation,
        child: widget.child,
    );
  }
}