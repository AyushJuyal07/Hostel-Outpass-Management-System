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
import 'package:cu_hostel/routes/route_generator.dart';
import 'package:cu_hostel/utils/utility.dart';
import 'package:cu_hostel/utils/validity_methods.dart';
import 'package:cu_hostel/widgets/layout_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../utils/method_widgets.dart';
import '../../../widgets/action_button.dart';

class WardenUidScreen extends StatefulWidget {
  static const id = "WardenUidScreenId";
  const WardenUidScreen({
    super.key,
    required this.title,
    this.onSubmit,
  });
  final String title;
  final Function(String uid)? onSubmit;

  @override
  State<WardenUidScreen> createState() => _WardenUidScreenState();
}

class _WardenUidScreenState extends State<WardenUidScreen> {
  TextEditingController _uidController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Uid Submission"),
      ),
      body: Form(
        key: _key,
        child: LayoutManager(
            mobileChild: (context, constraints) => Column(
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      widget.title,
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
                            .read<WardenProvider>()
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
                      onPressed: () async {
                        if (!(_key.currentState?.validate() ?? false)) return;

                        context
                            .read<WardenProvider>()
                            .addUid(_uidController.text);
                        debugPrint("submit button pressed");
                        if (widget.onSubmit != null) {
                          widget.onSubmit!(_uidController.text);
                        }
                        _uidController.clear();
                      },
                      title: 'Submit',
                    ),
                  ],
                )),
      ),
    );
  }
}
