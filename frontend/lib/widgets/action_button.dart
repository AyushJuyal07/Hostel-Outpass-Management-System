import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.parentWidth,
    this.backgroundColor,
    this.widthRatio = 0.6,
    this.padding = const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
    this.radius = 8,
    this.textStyle,
  });
  final Function() onPressed;
  final String title;
  final double widthRatio;
  final Color? backgroundColor;
  final EdgeInsets padding;
  final double radius;
  final double? parentWidth;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: Size(
            (parentWidth ?? MediaQuery.of(context).size.width) * widthRatio,
            25),
        padding: padding,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      ),
      child: Text(
        title,
        style: textStyle?.copyWith(color: Colors.white) ??
            const TextStyle(
              fontSize: 25,
            ),
      ),
    );
  }
}
