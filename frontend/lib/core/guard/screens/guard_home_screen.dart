import 'package:cu_hostel/core/auth/screens/login_screen.dart';
import 'package:cu_hostel/core/guard/functions/guard.dart';
import 'package:cu_hostel/core/guard/screens/guard_pass_screen.dart';
import 'package:cu_hostel/core/warden/models/pass_model.dart';
import 'package:cu_hostel/routes/route_generator.dart';
import 'package:cu_hostel/utils/api_callback_listener.dart';
import 'package:cu_hostel/utils/loading_dialog.dart';
import 'package:cu_hostel/utils/validity_methods.dart';
import 'package:cu_hostel/widgets/layout_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../utils/method_widgets.dart';
import '../../../widgets/action_button.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/guard_provider.dart';
import '../widgets/no_pass_dialog.dart';

class GuardHomeScreen extends StatefulWidget {
  static const id = "GuardHomeScreenId";
  const GuardHomeScreen({super.key});

  @override
  State<GuardHomeScreen> createState() => _GuardHomeScreenState();
}

class _GuardHomeScreenState extends State<GuardHomeScreen> {
  TextEditingController _uidController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();
  // @override
  // void initState() {
  //   super.initState();
  //   if (!context.read<AuthProvider>().isLoggedIn) {
  //     Navigator.pushNamedAndRemoveUntil(
  //         context, LogInScreen.id, (route) => false);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Guard Screen"),
        actions: [buildSignOutButton(context)],
      ),
      body: Form(
        key: _key,
        child: LayoutManager(
            mobileChild: (context, constraints) => Column(
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      "Pass Verification",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 40),

                    TypeAheadFormField(
                      hideOnEmpty: true,
                      validator: defaultValidator,
                      textFieldConfiguration: TextFieldConfiguration(
                          keyboardType: TextInputType.text,
                          controller: _uidController,
                          decoration:
                              const InputDecoration(labelText: "Student Uid")),
                      suggestionsCallback: (value) async {
                        return context
                            .read<GuardProvider>()
                            .ids
                            .where((element) => element.contains(value));
                      },
                      itemBuilder: (context, value) => Text(value),
                      onSuggestionSelected: (value) {
                        _uidController.text = value;
                      },
                    ),

                    // TextFormField(
                    //   validator: validateUid,
                    //   controller: _uidController,
                    //   decoration: const InputDecoration(
                    //     labelText: "Student Uid",
                    //   ),
                    // ),
                    const SizedBox(height: 20),
                    ActionButton(
                      parentWidth: constraints.maxWidth,
                      onPressed: () {
                        if (!(_key.currentState?.validate() ?? false)) return;

                        context
                            .read<GuardProvider>()
                            .addUid(_uidController.text);

                        context.goNamed(
                          RouteGenerator.guardPassVerify,
                          pathParameters: {"uidValue": _uidController.text},
                        );
                        _uidController.clear();
                      },
                      title: 'Submit',
                    ),
                  ],
                )),
      ),
    );
  }

  void showNoOutPassDialog() {
    showDialog(
      context: context,
      builder: (context) => const NoPassDialog(),
    );
  }
}
