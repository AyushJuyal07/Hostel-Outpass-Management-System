import 'dart:convert';

import 'package:cu_hostel/core/auth/providers/auth_provider.dart';
import 'package:cu_hostel/core/auth/screens/login_screen.dart';
import 'package:cu_hostel/core/warden/functions/warden.dart';
import 'package:cu_hostel/core/warden/functions/node_hostel/node_warden.dart';
import 'package:cu_hostel/core/warden/models/hostel_model.dart';
import 'package:cu_hostel/core/warden/models/pass_model.dart';
import 'package:cu_hostel/core/warden/models/student_model.dart';
import 'package:cu_hostel/core/warden/providers/warden_provider.dart';
import 'package:cu_hostel/core/warden/screens/warden_pass_generate_screen.dart';
import 'package:cu_hostel/core/warden/screens/warden_uid_screen.dart';
import 'package:cu_hostel/routes/route_generator.dart';
import 'package:cu_hostel/utils/utility.dart';
import 'package:cu_hostel/utils/validity_methods.dart';
import 'package:cu_hostel/widgets/layout_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../utils/method_widgets.dart';
import '../../../widgets/action_button.dart';

class WardenHomeScreen extends StatefulWidget {
  static const id = "WardenHomeScreenId";
  const WardenHomeScreen({super.key});

  @override
  State<WardenHomeScreen> createState() => _WardenHomeScreenState();
}

class _WardenHomeScreenState extends State<WardenHomeScreen> {
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Warden Screen"),
        actions: [buildSignOutButton(context)],
      ),
      body: Form(
        key: _key,
        child: LayoutManager(
          mobileChild: (context, constraints) => Column(
            children: [
              const SizedBox(height: 40),
              ActionButton(
                parentWidth: constraints.maxWidth,
                onPressed: () async {
                  context.goNamed(
                    RouteGenerator.wardenUid,
                    pathParameters: {"title": "Pass Generation"},
                    extra: (uid) {
                      context.pushNamed(
                        RouteGenerator.wardenPassGeneration,
                        pathParameters: {
                          "uidValue": uid,
                          "title": "Pass Generation",
                        },
                      );
                      print("we got a call");
                    },
                  );
                },
                title: 'Generate Pass',
              ),
              const SizedBox(height: 10),
              ActionButton(
                parentWidth: constraints.maxWidth,
                onPressed: () async {
                  context.goNamed(
                    RouteGenerator.wardenUid,
                    pathParameters: {"title": "Pass Details"},
                    extra: (uid) {
                      context.pushNamed(
                        RouteGenerator.wardenPassInfo,
                        pathParameters: {
                          "uidValue": uid,
                          "title": "Pass Details",
                        },
                      );
                      print("we got a call");
                    },
                  );
                },
                title: 'Pass Details',
              ),
              const SizedBox(height: 10),
              ActionButton(
                title: "All Pass Details",
                parentWidth: constraints.maxWidth,
                onPressed: () {
                  context.goNamed(RouteGenerator.wardenPassList);
                },
              ),
              const SizedBox(height: 10),
              ActionButton(
                title: "Closed Pass Details",
                parentWidth: constraints.maxWidth,
                onPressed: () {
                  context.goNamed(RouteGenerator.wardenClosedPassList);

                  // WardenApi.getPassList(
                  //     context.read<AuthProvider>().accessToken);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void showNoOutPassDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (context) => const NoPassDialog(),
  //   );
  // }
}
