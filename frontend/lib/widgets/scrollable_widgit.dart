import 'package:flutter/material.dart';

class ScrollableWidget extends StatelessWidget {
  const ScrollableWidget({
    super.key,
    required this.constraints,
    this.child,
  });
  final BoxConstraints constraints;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: constraints.maxHeight),
        child: IntrinsicHeight(
          child: child,
        ),
      ),
    );
  }
}
