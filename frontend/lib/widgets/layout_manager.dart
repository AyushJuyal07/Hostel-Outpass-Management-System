import 'package:flutter/material.dart';

import '../utils/constants.dart';

class LayoutManager extends StatelessWidget {
  const LayoutManager({
    super.key,
    required this.mobileChild,
    this.webChild,
    this.padding = kPagePadding,
  });
  final Widget Function(BuildContext context, BoxConstraints constraints)
      mobileChild;
  final Widget Function(BuildContext context, BoxConstraints constraints)?
      webChild;
  // final Widget? webChild;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth <= kWebMaxWidth) {
              return mobileChild(context, constraints);
            }
            return webChild != null
                ? webChild!(context, constraints)
                : Container(
                    constraints: const BoxConstraints(maxWidth: kWebMaxWidth),
                    child: mobileChild(
                        context, constraints.copyWith(maxWidth: kWebMaxWidth)),
                  );
          }),
        ),
      ),
    );
  }
}
