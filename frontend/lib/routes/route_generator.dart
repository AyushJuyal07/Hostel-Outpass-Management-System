import 'package:cu_hostel/core/auth/models/officer_model.dart';
import 'package:cu_hostel/core/auth/providers/auth_provider.dart';
import 'package:cu_hostel/core/auth/screens/login_screen.dart';
import 'package:cu_hostel/core/guard/screens/guard_home_screen.dart';
import 'package:cu_hostel/core/guard/screens/guard_pass_screen.dart';
import 'package:cu_hostel/core/warden/models/pass_model.dart';
import 'package:cu_hostel/core/warden/models/student_model.dart';
import 'package:cu_hostel/core/warden/screens/warden_old_pass_screen.dart';
import 'package:cu_hostel/core/warden/screens/warden_pass_generate_screen.dart';
import 'package:cu_hostel/core/warden/screens/warden_pass_info_screen.dart';
import 'package:cu_hostel/core/warden/screens/warden_pass_list_screen.dart';
import 'package:cu_hostel/core/warden/screens/warden_uid_screen.dart';
import 'package:cu_hostel/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../core/warden/screens/warden_home_screen.dart';

class RouteGenerator {
  static const login = "/login";
  static const wardenHome = "/warden";
  static const wardenUid = "uid";
  static const wardenPassGeneration = "pass_gen";
  static const wardenPassEdit = "pass_edit";
  static const wardenPassInfo = "pass_info";
  static const wardenPassList = "all_pass_list";
  static const wardenClosedPassList = "closed_pass_list";

  static const guardHome = "/guard";
  static const guardPassVerify = "verify";

  static final GoRouter router = GoRouter(
    // initialLocation: wardenPassList,
    initialLocation: login,
    redirect: (context, state) {
      OfficerModel? officer = context.read<AuthProvider>().officer;
      print(officer);
      if (officer == null) return login;

      if (state.location.startsWith(wardenHome) &&
          officer.role != OfficerRole.warden) return login;

      if (state.location.startsWith(guardHome) &&
          officer.role != OfficerRole.guard) return login;

      return null;
    },
    routes: [
      // auth
      GoRoute(
        path: login,
        name: login,
        pageBuilder: (context, state) =>
            const MaterialPage(child: LogInScreen()),
      ),
      // warden
      GoRoute(
        path: wardenHome,
        name: wardenHome,
        pageBuilder: (context, state) =>
            const MaterialPage(child: WardenHomeScreen()),
        routes: [
          GoRoute(
            path: wardenPassList,
            name: wardenPassList,
            pageBuilder: (context, state) =>
                const MaterialPage(child: WardenPassListScreen()),
          ),
          GoRoute(
            path: wardenClosedPassList,
            name: wardenClosedPassList,
            pageBuilder: (context, state) =>
                const MaterialPage(child: WardenOldPassScreen()),
          ),
          GoRoute(
            path: "$wardenUid/:title",
            name: wardenUid,
            pageBuilder: (context, state) => MaterialPage(
              child: WardenUidScreen(
                title: state.pathParameters['title']!,
                onSubmit: state.extra as Function(String)?,
              ),
            ),
            routes: [
              GoRoute(
                path: "$wardenPassGeneration/:uidValue",
                name: wardenPassGeneration,
                pageBuilder: (context, state) => MaterialPage(
                  child: WardenPassGenerateScreen(
                    uid: state.pathParameters['uidValue']!,
                    isAddNew: true,
                  ),
                ),
              ),
              GoRoute(
                  path: "$wardenPassInfo/:uidValue",
                  name: wardenPassInfo,
                  pageBuilder: (context, state) => MaterialPage(
                        child: WardenPassInfoScreen(
                          uid: state.pathParameters['uidValue']!,
                        ),
                      ),
                  routes: [
                    GoRoute(
                      path: wardenPassEdit,
                      name: wardenPassEdit,
                      pageBuilder: (context, state) => MaterialPage(
                        child: WardenPassGenerateScreen(
                          uid: state.pathParameters['uidValue']!,
                          isAddNew: false,
                          pass: state.extra != null
                              ? state.extra as PassModel?
                              : null,
                        ),
                      ),
                    ),
                  ]),
            ],
          ),
        ],
      ),

      // guard
      GoRoute(
        path: guardHome,
        name: guardHome,
        pageBuilder: (context, state) =>
            const MaterialPage(child: GuardHomeScreen()),
        routes: [
          GoRoute(
            path: "$guardPassVerify/:uidValue",
            name: guardPassVerify,
            pageBuilder: (context, state) => MaterialPage(
                child: GuardPassScreen(
              uid: state.pathParameters['uidValue']!,
              // pass: state.extra as PassModel?,
            )),
          ),
        ],
      ),
    ],
  );

  static Route<dynamic> _buildError({String? message}) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
          appBar: AppBar(
            title: const Text("Error Screen"),
          ),
          body: Center(
            child: Text("${message ?? 'Unexpected Error'}\nTry Again..."),
          )),
    );
  }
}
