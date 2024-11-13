import 'package:cu_hostel/core/auth/providers/auth_provider.dart';
import 'package:cu_hostel/core/guard/functions/guard.dart';
import 'package:cu_hostel/core/guard/widgets/pass_details_element.dart';
import 'package:cu_hostel/core/guard/widgets/pass_verification_dialog.dart';
import 'package:cu_hostel/core/warden/models/pass_model.dart';
import 'package:cu_hostel/routes/route_generator.dart';
import 'package:cu_hostel/utils/api_callback_listener.dart';
import 'package:cu_hostel/utils/constants.dart';
import 'package:cu_hostel/utils/enums.dart';
import 'package:cu_hostel/utils/loading_dialog.dart';
import 'package:cu_hostel/utils/utility.dart';
import 'package:cu_hostel/widgets/action_button.dart';
import 'package:cu_hostel/widgets/layout_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class GuardPassScreen extends StatefulWidget {
  static const id = "GuardPassScreenId";
  const GuardPassScreen({
    super.key,
    required this.uid,
    this.pass,
  });
  final String uid;
  final PassModel? pass;

  @override
  State<GuardPassScreen> createState() => _GuardPassScreenState();
}

class _GuardPassScreenState extends State<GuardPassScreen> {
  PassModel? pass;
  @override
  void initState() {
    super.initState();
    loadPass(context.read<AuthProvider>().accessToken);
  }

  void loadPass(String token) async {
    if (widget.pass != null) {
      pass = pass!;
      return;
    }
    await Future.delayed(const Duration(microseconds: 10));
    Future.sync(
        () => showLoadingDialog(context, title: "Loading Pass Details"));
    pass = await GuardApi.getPassDetails(
      widget.uid,
      token: token,
      listener: ApiCallbackListener(
        onComplete: () {
          context.pop();
        },
      ),
    );
    setState(() {});
    print(pass);
    if (pass == null) {
      Future.sync(() => context.go(RouteGenerator.guardHome));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pass Details"),
      ),
      body: pass == null
          ? const SizedBox()
          : LayoutManager(
              mobileChild: (context, constraints) => Container(
                padding: kPagePadding,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withAlpha(35),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      pass!.isDayPass
                          ? "Day Pass Details"
                          : "Night Pass Details",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 25, width: double.maxFinite),
                    PassDetailsElement(title: "Uid", value: pass!.uid),
                    PassDetailsElement(title: "Name", value: pass!.name),
                    PassDetailsElement(
                        title: "Guardian No.",
                        value: pass!.guardianNo ?? "<UNKNOWN>"),
                    PassDetailsElement(title: "Purpose", value: pass!.purpose),
                    PassDetailsElement(title: "Place", value: pass!.place),
                    PassDetailsElement(
                        title: "Pass Type",
                        value: pass!.isDayPass ? "Day Pass" : "Night Pass"),
                    PassDetailsElement(
                        title: "IN Time",
                        value:
                            "${formatDateTimeDatePart(pass!.inTime)} ${formatDateTimeTimePart(pass!.inTime)}"),
                    PassDetailsElement(
                        title: "Out Time",
                        value:
                            "${formatDateTimeDatePart(pass!.outTime)} ${formatDateTimeTimePart(pass!.outTime)}"),
                    PassDetailsElement(
                        title: "Status",
                        value: pass!.status == PassStatus.generated
                            ? "Going Out"
                            : "Returning Back"),
                    const SizedBox(height: 15),
                    ActionButton(
                      title: "Verify",
                      onPressed: () async {
                        showLoadingDialog(context, title: "Verifying pass");
                        await GuardApi.verifyPass(
                          pass!.uid,
                          token: context.read<AuthProvider>().accessToken,
                          listener: ApiCallbackListener(
                            onComplete: () {
                              context.pop();
                            },
                            onError: (err) {
                              showPassVerificationDialog(
                                context,
                                isVerified: false,
                                error: err,
                              );
                            },
                            onSuccess: () {
                              showPassVerificationDialog(
                                context,
                              );
                            },
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
    );
  }

  void showPassVerificationDialog(BuildContext context,
      {bool isVerified = true, String? error}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PassVerificationDialog(
        isVerified: isVerified,
        error: error,
      ),
    );
  }
}
