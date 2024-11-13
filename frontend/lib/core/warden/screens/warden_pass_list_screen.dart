import 'package:cu_hostel/core/auth/providers/auth_provider.dart';
import 'package:cu_hostel/core/warden/functions/warden.dart';
import 'package:cu_hostel/core/warden/models/pass_model.dart';
import 'package:cu_hostel/routes/route_generator.dart';
import 'package:cu_hostel/utils/api_callback_listener.dart';
import 'package:cu_hostel/utils/constants.dart';
import 'package:cu_hostel/utils/loading_dialog.dart';
import 'package:cu_hostel/utils/utility.dart';
import 'package:cu_hostel/widgets/layout_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class WardenPassListScreen extends StatefulWidget {
  const WardenPassListScreen({super.key});

  @override
  State<WardenPassListScreen> createState() => _WardenPassListScreenState();
}

class _WardenPassListScreenState extends State<WardenPassListScreen> {
  List<PassModel> passData = [];
  bool isDialogOn = false;
  List<DataRow> rows = [];

  @override
  void initState() {
    super.initState();
    // updateTableUi();
    loadData(context.read<AuthProvider>().accessToken);
  }

  void loadData(String token) async {
    await Future.delayed(const Duration(microseconds: 10));
    Future.sync(() => showLoadingDialog(context, title: "Loading pass list"));
    passData = await WardenApi.getPassList(
      token,
      listener: ApiCallbackListener(
        onComplete: () {
          context.pop();
        },
      ),
    );
    updateTableUi();
  }

  void updateTableUi() {
    rows = passData.map(
      (pass) {
        var inDiff = DateTime.now().difference(pass.inTime);
        var outDiff = pass.outTime.difference(DateTime.now());
        return DataRow(
          onLongPress: () {
            context.goNamed(RouteGenerator.wardenPassInfo, pathParameters: {
              "title": "Pass Info",
              "uidValue": pass.uid,
            });
          },
          cells: [
            DataCell(Text(pass.uid)),
            DataCell(Text(pass.name)),
            DataCell(Text(pass.isDayPass ? "Day" : "Night")),
            DataCell(Text(passStatus2PrintableString(pass.status))),
            DataCell(Text(pass.hostelDetails.roomNo.toString())),
            DataCell(Text(pass.place)),
            DataCell((outDiff.abs() < const Duration(days: 1))
                ? Text(formatDateTimeTimePart(pass.outTime))
                : Text(formatDateTimeDatePart(pass.outTime))),
            DataCell((inDiff.abs() < const Duration(days: 1))
                ? Text(formatDateTimeTimePart(pass.inTime))
                : Text(formatDateTimeDatePart(pass.inTime))),
          ],
        );
      },
    ).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // updateTableUi(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Pass"),
      ),
      body: LayoutManager(mobileChild: (context, constraints) {
        if (constraints.maxWidth < kWebMaxWidth && !isDialogOn) {
          isDialogOn = true;
          showNoTableDialog();
        }
        return const SizedBox();
      }, webChild: (context, constraints) {
        if (isDialogOn) {
          context.pop();
          isDialogOn = false;
        }
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              columns: const [
                DataColumn(label: Text("Uid")),
                DataColumn(label: Text("Name")),
                DataColumn(label: Text("Pass Type")),
                DataColumn(label: Text("Pass Status")),
                DataColumn(label: Text("Room No.")),
                DataColumn(label: Text("Place")),
                DataColumn(label: Text("Out Time")),
                DataColumn(label: Text("In Time")),
              ],
              rows: rows,
            ),
          ),
        );
      }),
    );
  }

  void showNoTableDialog() async {
    await Future.delayed(const Duration(microseconds: 10));
    Future.sync(
      () => showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Screen Width Error"),
          content: const Text("Only works on PC Full Screen."),
          actions: [
            TextButton(
              onPressed: () {
                context.go(RouteGenerator.wardenHome);
              },
              child: const Text("Go Back"),
            ),
          ],
        ),
      ),
    );
  }
}
