import 'package:flutter/material.dart';

class PassDetailsElement extends StatelessWidget {
  const PassDetailsElement({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$title : ",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
