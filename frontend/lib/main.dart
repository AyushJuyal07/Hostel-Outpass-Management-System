import 'dart:convert';

import 'package:cu_hostel/core/auth/providers/auth_provider.dart';
import 'package:cu_hostel/core/auth/screens/login_screen.dart';
import 'package:cu_hostel/core/guard/providers/guard_provider.dart';
import 'package:cu_hostel/core/warden/models/student_model.dart';
import 'package:cu_hostel/core/warden/providers/warden_provider.dart';
import 'package:cu_hostel/core/warden/screens/warden_home_screen.dart';
import 'package:cu_hostel/core/warden/screens/warden_pass_generate_screen.dart';
import 'package:cu_hostel/routes/route_generator.dart';
import 'package:cu_hostel/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthProvider()),
      ChangeNotifierProvider(create: (context) => WardenProvider()),
      ChangeNotifierProvider(create: (context) => GuardProvider()),
    ],
    child: const CuHostelApp(),
  ));
}

class CuHostelApp extends StatelessWidget {
  const CuHostelApp({super.key});

  @override
  Widget build(BuildContext context) {
    // var t =
    //     '{"name": "Naimish Mishra","uid": "21BCG1018","mobileNo": "5689231245", "guardianNo": "1245785623","hostelDetails":{"hostelName": "Govind-B",  "roomNo": 301} }';
    // StudentModel std = StudentModel.fromJson(jsonDecode(t));
    context.read<AuthProvider>().init();
    return OKToast(
      child: MaterialApp.router(
        theme: lightThemeData,
        // onGenerateRoute: RouteGenerator.generateRoute,
        // initialRoute: LogInScreen.id,
        routerDelegate: RouteGenerator.router.routerDelegate,
        routeInformationParser: RouteGenerator.router.routeInformationParser,
        routeInformationProvider:
            RouteGenerator.router.routeInformationProvider,
        debugShowCheckedModeBanner: false,
        // home: WardenPassGenerateScreen(student: std),
      ),
    );
  }
}
