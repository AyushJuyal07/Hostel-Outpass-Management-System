import 'package:cu_hostel/core/guard/screens/guard_home_screen.dart';
import 'package:cu_hostel/routes/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PassVerificationDialog extends StatelessWidget {
  const PassVerificationDialog({
    super.key,
    required this.isVerified,
    this.error,
  });
  final bool isVerified;
  final String? error;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: isVerified
          ? const Icon(
              Icons.done,
              size: 35,
            )
          : const Icon(
              Icons.warning,
              size: 35,
            ),
      iconColor: isVerified ? Colors.green : Colors.red,
      title: Text(isVerified ? "Pass Verified!" : "Error Occurred"),
      content: error != null ? Text(error!) : null,
      actions: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              if (isVerified) {
                context.go(RouteGenerator.guardHome);
                return;
              } else {
                Navigator.pop(context);
              }

              // Todo: Logic to try again
            },
            child: Text(isVerified ? "Ok" : "Try Again"),
          ),
        ),
      ],
    );
  }
}
