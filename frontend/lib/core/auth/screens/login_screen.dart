import 'package:cu_hostel/core/auth/functions/node_auth/node_auth.dart';
import 'package:cu_hostel/core/auth/models/officer_model.dart';
import 'package:cu_hostel/core/auth/providers/auth_provider.dart';
import 'package:cu_hostel/routes/route_generator.dart';
import 'package:cu_hostel/utils/api_callback_listener.dart';
import 'package:cu_hostel/utils/asset_paths.dart';
import 'package:cu_hostel/utils/enums.dart';
import 'package:cu_hostel/utils/loading_dialog.dart';
import 'package:cu_hostel/utils/validity_methods.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';
import '../../guard/screens/guard_home_screen.dart';
import '../../warden/screens/warden_home_screen.dart';
import '../functions/auth.dart';
import '../widgets/password_field.dart';

class LogInScreen extends StatefulWidget {
  static const id = "LogInScreenId";
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController _eidController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(80), // Set preferred height here
      //   child: AppBar(
      //     leading: Image.asset(
      //       apLogoPath,
      //       height: 80,
      //     ),
      //   ),
      // ),
      body: Form(
        key: _key,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: kPagePadding,
                width: double.maxFinite,
                color: Theme.of(context).colorScheme.primary,
                child: Align(
                  alignment:
                      MediaQuery.of(context).size.width <= kLoginWebWidthLimit
                          ? Alignment.center
                          : Alignment.centerLeft,
                  child: Image.asset(
                    apLogoPath,
                    height: 80,
                  ),
                ),
              ),
              Container(
                padding: kPagePadding,
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                constraints:
                    const BoxConstraints(maxWidth: kLoginWebWidthLimit),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.primary.withAlpha(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 25),
                    Text(
                      "Log In Screen",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      validator: defaultValidator,
                      controller: _eidController,
                      decoration: const InputDecoration(
                        labelText: "EId",
                        hintText: "e.12353",
                        // errorText: "error",
                      ),
                    ),
                    const SizedBox(height: 15),
                    PasswordField(
                      validator: defaultValidator,
                      // validator: validatePassword,
                      controller: _passwordController,
                      labelText: "Password",
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: loginAction,
                      child: const Text("Log In"),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              Expanded(
                child: ColoredBox(
                  color: Theme.of(context).colorScheme.primary,
                  child: const SizedBox(
                    width: double.maxFinite,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loginAction() async {
    if (!(_key.currentState?.validate() ?? false)) return;
    showLoadingDialog(context, title: "Logging User");
    OfficerModel? model = await AuthApi.loginWithEidPass(
      eid: _eidController.text,
      pass: _passwordController.text,
      listener: ApiCallbackListener(onComplete: () {
        Navigator.pop(context);
      }),
    );
    if (model == null) return;
    Future.sync(() {
      context.read<AuthProvider>().setOfficer(model);
      print("role ${model.role}");
      if (model.role == OfficerRole.warden) {
        // Navigator.pushNamedAndRemoveUntil(
        //     context, WardenHomeScreen.id, (route) => false);
        context.goNamed(RouteGenerator.wardenHome);
      } else {
        context.goNamed(RouteGenerator.guardHome);
        // Navigator.pushReplacementNamed(context, GuardHomeScreen.id);
      }
    });
  }
}
