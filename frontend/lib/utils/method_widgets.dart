import 'package:cu_hostel/routes/route_generator.dart';
import 'package:cu_hostel/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/auth/screens/login_screen.dart';

Widget buildSignOutButton(BuildContext context) {
  return IconButton(
      onPressed: () {
        showMyToast("Logged Out");
        context.goNamed(RouteGenerator.login);
        // Navigator.popUntil(context, (r) => false);
        // Navigator.pushNamed(context, LogInScreen.id);
        // Navigator.popUntil(context, ModalRoute.withName(LogInScreen.id));
      },
      icon: const Icon(Icons.logout));
}
