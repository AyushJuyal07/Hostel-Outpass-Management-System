import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cu_hostel/core/auth/models/officer_model.dart';
import 'package:cu_hostel/core/auth/providers/auth_provider.dart';
import 'package:cu_hostel/core/guard/widgets/pass_details_element.dart';
import 'package:cu_hostel/core/warden/functions/node_hostel/node_warden.dart';
import 'package:cu_hostel/core/warden/functions/warden.dart';
import 'package:cu_hostel/core/warden/models/inner_officer.dart';
import 'package:cu_hostel/core/warden/models/pass_model.dart';
import 'package:cu_hostel/core/warden/models/student_model.dart';
import 'package:cu_hostel/core/warden/providers/warden_provider.dart';
import 'package:cu_hostel/core/warden/screens/warden_home_screen.dart';
import 'package:cu_hostel/core/warden/widgets/suggestion_text_field.dart';
import 'package:cu_hostel/routes/route_generator.dart';
import 'package:cu_hostel/utils/api_callback_listener.dart';
import 'package:cu_hostel/utils/loading_dialog.dart';
import 'package:cu_hostel/utils/validity_methods.dart';
import 'package:cu_hostel/widgets/action_button.dart';
import 'package:cu_hostel/widgets/layout_manager.dart';
import 'package:cu_hostel/widgets/scrollable_widgit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';
import '../../../utils/utility.dart';

class WardenPassGenerateScreen extends StatefulWidget {
  static const id = "WardenPassGenerateScreenId";
  const WardenPassGenerateScreen({
    super.key,
    required this.uid,
    this.isAddNew = true,
    this.pass,
  });
  final String uid;
  final bool isAddNew;
  final PassModel? pass;

  @override
  State<WardenPassGenerateScreen> createState() =>
      _WardenPassGenerateScreenState();
}

class _WardenPassGenerateScreenState extends State<WardenPassGenerateScreen> {
  TextEditingController _purposeController = TextEditingController();
  TextEditingController _placeController = TextEditingController();
  DateTime inTime = DateTime.now();
  DateTime outTime = DateTime.now();
  List<bool> passType = [true, false];
  PassModel? pass;
  final GlobalKey<FormState> _key = GlobalKey();

  StudentModel? student;
  @override
  void initState() {
    super.initState();
    loadData(context.read<AuthProvider>().accessToken);
    // print(widget.uid);
  }

  void loadData(String token) async {
    if (!widget.isAddNew && widget.pass != null) {
      pass = widget.pass;
      updateValues();
      return;
    }
    await Future.delayed(const Duration(microseconds: 10));
    if (widget.isAddNew) {
      loadStudentData(token);
    } else {
      loadPassData(token);
    }
  }

  void updateValues() {
    student = StudentModel.fromPass(pass!);
    _placeController.text = pass!.place;
    _purposeController.text = pass!.purpose;
    inTime = pass!.inTime;
    outTime = pass!.outTime;
  }

  void loadPassData(String token) async {
    Future.sync(
        () => showLoadingDialog(context, title: "Loading Pass Details"));
    pass = await WardenApi.getPassDetails(
      widget.uid,
      token: token,
      listener: ApiCallbackListener(
        onComplete: () {
          context.pop();
        },
      ),
    );
    if (pass == null) {
      Future.sync(() => context.pop());
    } else {
      updateValues();
      setState(() {});
    }
  }

  void loadStudentData(String token) async {
    Future.sync(
        () => showLoadingDialog(context, title: "Loading Student Details"));
    student = await WardenApi.getStudentDetails(
      uid: widget.uid,
      token: token,
      listener: ApiCallbackListener(
        onComplete: () {
          context.pop();
        },
      ),
    );
    setState(() {});
    print(student);
    if (student == null) {
      Future.sync(() => context.pop());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isAddNew ? "Pass Generation" : "Edit Pass"),
      ),
      body: Form(
        key: _key,
        child: Consumer<WardenProvider>(builder: (context, provider, child) {
          return student == null
              ? const SizedBox()
              : LayoutManager(
                  mobileChild: (context, constraints) => ScrollableWidget(
                    constraints: constraints,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: kPagePadding,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withAlpha(35),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              PassDetailsElement(
                                  title: "Name", value: student!.name),
                              PassDetailsElement(
                                  title: "Uid", value: student!.uid),
                              PassDetailsElement(
                                  title: "Mobile No.",
                                  value: student!.mobileNo),
                              PassDetailsElement(
                                  title: "Guardian No.",
                                  value: student!.guardianNo),
                              PassDetailsElement(
                                  title: "Hostel",
                                  value: student!.hostelDetails.hostelName),
                              PassDetailsElement(
                                  title: "Room No.",
                                  value:
                                      student!.hostelDetails.roomNo.toString()),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        ToggleButtons(
                          selectedColor: Colors.white,
                          fillColor: Theme.of(context).colorScheme.primary,
                          color: Colors.grey,
                          isSelected: passType,
                          splashColor: Colors.white,
                          renderBorder: false,
                          borderRadius: BorderRadius.circular(20),
                          children: const [
                            Padding(
                              padding: kPagePadding,
                              child: Text(
                                "Day Pass",
                                // style: kSemiBoldTextStyle,
                              ),
                            ),
                            Padding(
                              padding: kPagePadding,
                              child: Text(
                                "Night Pass",
                                // style: kSemiBoldTextStyle,
                              ),
                            ),
                          ],
                          onPressed: (index) {
                            setState(() {
                              for (int i = 0; i < passType.length; i++) {
                                passType[i] = false;
                              }
                              passType[index] = true;
                            });
                          },
                        ),

                        const SizedBox(height: 10),
                        // TextFormField(
                        //   validator: defaultValidator,
                        //   controller: _purposeController,
                        //   keyboardType: TextInputType.text,
                        //   decoration: const InputDecoration(labelText: "Purpose"),
                        // ),

                        TypeAheadFormField(
                          hideOnEmpty: true,
                          validator: defaultValidator,
                          textFieldConfiguration: TextFieldConfiguration(
                              keyboardType: TextInputType.text,
                              controller: _purposeController,
                              decoration:
                                  const InputDecoration(labelText: "Purpose")),
                          suggestionsCallback: (value) async {
                            return provider.purposes
                                .where((element) => element.contains(value));
                          },
                          itemBuilder: (context, value) => Text(value),
                          onSuggestionSelected: (value) {
                            _purposeController.text = value;
                          },
                        ),
                        const SizedBox(height: 15),
                        TypeAheadFormField(
                          hideOnEmpty: true,
                          validator: defaultValidator,
                          textFieldConfiguration: TextFieldConfiguration(
                            controller: _placeController,
                            keyboardType: TextInputType.text,
                            decoration:
                                const InputDecoration(labelText: "Place"),
                          ),
                          suggestionsCallback: (value) async {
                            return provider.places
                                .where((element) => element.contains(value));
                          },
                          itemBuilder: (context, value) => Text(value),
                          onSuggestionSelected: (value) {
                            _placeController.text = value;
                          },
                        ),
                        const SizedBox(height: 15),

                        Row(
                          children: [
                            Text(
                              "Out-Time: ",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(width: 10),
                            ActionButton(
                              parentWidth: constraints.maxWidth,
                              widthRatio: 0.35,
                              textStyle: Theme.of(context).textTheme.bodyMedium,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              title: formatDateTimeDatePart(outTime),
                              onPressed: showChangeOutTimeDatePartDialog,
                            ),
                            const SizedBox(width: 10),
                            ActionButton(
                              textStyle: Theme.of(context).textTheme.bodyMedium,
                              parentWidth: constraints.maxWidth,
                              widthRatio: 0.20,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              title: formatDateTimeTimePart(outTime),
                              onPressed: showChangeOutTimeDialogTimePart,
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Text(
                              "In Time",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(width: 10),
                            ActionButton(
                              parentWidth: constraints.maxWidth,
                              widthRatio: 0.35,
                              textStyle: Theme.of(context).textTheme.bodyMedium,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              title: formatDateTimeDatePart(inTime),
                              onPressed: showChangeInTimeDatePartDialog,
                            ),
                            const SizedBox(width: 10),
                            ActionButton(
                              parentWidth: constraints.maxWidth,
                              widthRatio: 0.20,
                              textStyle: Theme.of(context).textTheme.bodyMedium,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              title: formatDateTimeTimePart(inTime),
                              onPressed: showChangeInTimeDialogTimePart,
                            ),
                          ],
                        ),
                        // ActionButton(
                        //   widthRatio: 0.85,
                        //   padding: const EdgeInsets.symmetric(vertical: 20),
                        //   parentWidth: constraints.maxWidth,
                        //   title: "Out-Time ${dateTime2IsoString(outTime)}",
                        //   onPressed: showChangeOutTimeDialog,
                        // ),
                        const SizedBox(height: 15),
                        const Spacer(),
                        ActionButton(
                          title:
                              widget.isAddNew ? "Generate Pass" : "Edit Pass",
                          parentWidth: constraints.maxWidth,
                          onPressed: widget.isAddNew ? generatePass : editPass,
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                );
        }),
      ),
    );
  }

  Future<void> showChangeInTimeDialogTimePart() async {
    TimeOfDay cur = TimeOfDay.fromDateTime(inTime);
    var res = await showTimePicker(context: context, initialTime: cur);
    if (res == null) return;
    setState(() {
      inTime =
          DateTime(inTime.year, inTime.month, inTime.day, res.hour, res.minute);
    });
  }

  Future<void> showChangeOutTimeDialogTimePart() async {
    TimeOfDay cur = TimeOfDay.fromDateTime(inTime);
    var res = await showTimePicker(context: context, initialTime: cur);
    if (res == null) return;
    setState(() {
      outTime = DateTime(
          outTime.year, outTime.month, outTime.day, res.hour, res.minute);
    });
  }

  Future<void> showChangeInTimeDatePartDialog() async {
    var res = await showDatePicker(
      context: context,
      initialDate: inTime,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 7)),
    );

    if (res == null || res == inTime) return;
    setState(() {
      inTime = DateTime(res.year, res.month, res.day, inTime.hour,
          inTime.minute, inTime.second);
      if (outTime.millisecondsSinceEpoch < inTime.millisecondsSinceEpoch) {
        print("we got a call");
        outTime = inTime.add(const Duration(hours: 1));
      } else {
        print("you are not allowed");
      }
    });
  }

  Future<void> showChangeOutTimeDatePartDialog() async {
    var res = await showDatePicker(
      context: context,
      initialDate: outTime,
      firstDate: inTime,
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );

    if (res == null || res == inTime) return;
    setState(() {
      outTime = DateTime(res.year, res.month, res.day, outTime.hour, res.minute,
          outTime.second);
    });
  }

  void editPass() {
    if (!(_key.currentState?.validate() ?? false)) return;
    var off = context.read<AuthProvider>().officer;
    if (off == null) return;

    // because we have to add suggestion even there is error on creating pass
    // adding purpose and place data on provider to show as suggestion
    context.read<WardenProvider>().addPurpose(_purposeController.text);
    context.read<WardenProvider>().addPlace(_placeController.text);

    PassModel pm = createPassModel(off);

    // if (pass == pm) {
    //   showMyToast("No Pass value changed", isError: true);
    //   return;
    // }

    showLoadingDialog(context, title: "Editing Pass");
    ApiCallbackListener listener = ApiCallbackListener(onSuccess: () {
      // showMyToast("Pass Generated");
      Navigator.pop(context);

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Center(child: Text("Pass Edited")),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  context.goNamed(RouteGenerator.wardenHome);
                },
                child: const Text("Ok"),
              ),
            ),
          ],
        ),
      );
    }, onError: (err) {
      // Todo: error
      Navigator.pop(context);

      print("error $err");
    });

    // editing pass
    NodeWarden.editPass(
      pass: pm,
      token: context.read<AuthProvider>().accessToken,
      listener: listener,
    );
  }

  void generatePass() {
    // print("calling to generate pass");
    if (!(_key.currentState?.validate() ?? false)) return;
    var off = context.read<AuthProvider>().officer;
    if (off == null) return;
    // because we have to add suggestion even there is error on creating pass
    // adding purpose and place data on provider to show as suggestion
    context.read<WardenProvider>().addPurpose(_purposeController.text);
    context.read<WardenProvider>().addPlace(_placeController.text);

    print("generating pass");
    PassModel pm = createPassModel(off);
    showLoadingDialog(context, title: "Generating Pass");
    ApiCallbackListener listener = ApiCallbackListener(onSuccess: () {
      // showMyToast("Pass Generated");
      Navigator.pop(context);

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Center(child: Text("Pass Generated")),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  context.goNamed(RouteGenerator.wardenHome);
                },
                child: const Text("Ok"),
              ),
            ),
          ],
        ),
      );
    }, onError: (err) {
      // Todo: error
      Navigator.pop(context);

      print("error $err");
    });

    // generating pass
    NodeWarden.generatePass(
      pass: pm,
      token: context.read<AuthProvider>().accessToken,
      listener: listener,
    );
  }

  PassModel createPassModel(OfficerModel off) {
    return PassModel.fromStudentDetails(
      student!,
      purpose: _purposeController.text,
      place: _placeController.text,
      outTime: outTime,
      inTime: inTime,
      warden: InnerOfficerModel(id: off.id, name: off.name),
      isDayPass: passType[0],
    );
  }
}
