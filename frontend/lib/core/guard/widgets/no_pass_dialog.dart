import 'package:flutter/material.dart';

class NoPassDialog extends StatelessWidget {
  const NoPassDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(
        Icons.warning,
        size: 35,
      ),
      iconColor: Colors.red,
      title: const Text("No Out-Pass Found!"),
      actions: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Ok"),
          ),
        ),
      ],
    );
  }
}
