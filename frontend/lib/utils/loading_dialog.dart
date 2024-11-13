import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void showLoadingDialog(
  BuildContext context, {
  required String title,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: SizedBox(
          height: 70,
          child: SpinKitFadingCube(
            size: 50,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      );
    },
  );
}
