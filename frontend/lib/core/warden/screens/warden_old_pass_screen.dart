import 'package:cu_hostel/core/auth/providers/auth_provider.dart';
import 'package:cu_hostel/core/warden/models/pass_model.dart';
import 'package:cu_hostel/routes/route_generator.dart';
import 'package:cu_hostel/utils/constants.dart';
import 'package:cu_hostel/utils/utility.dart';
import 'package:cu_hostel/widgets/layout_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../utils/api_callback_listener.dart';
import '../../../utils/loading_dialog.dart';
import '../functions/warden.dart';

class WardenOldPassScreen extends StatefulWidget {
  const WardenOldPassScreen({super.key});

  @override
  State<WardenOldPassScreen> createState() => _WardenOldPassScreenState();
}

class _WardenOldPassScreenState extends State<WardenOldPassScreen> {
  List<PassModel> passData = [];
  bool isDialogOn = false;
  List<DataRow> rows = [];
  late DateTimeRange dateRange;

  @override
  void initState() {
    super.initState();
    var cur = DateTime.now();
    var start = DateTime(cur.year, cur.month, cur.day);
    dateRange = DateTimeRange(
        start: start, end: start.add(const Duration(seconds: 86399)));
    updateTableUi();
  }

  void loadData(String token) async {
    await Future.delayed(const Duration(microseconds: 10));
    Future.sync(() => showLoadingDialog(context, title: "Loading pass list"));
    passData = await WardenApi.getClosedPasses(
      token,
      listener: ApiCallbackListener(
        onComplete: () {
          context.pop();
        },
      ),
      endDate: dateRange.end,
      startDate: dateRange.start,
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
          child: Column(
            children: [
              buildDateFilter(constraints.maxWidth),
              Expanded(
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
              ),
            ],
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

  Widget buildDateFilter(double width) {
    return Card(
      elevation: 8,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Filter Date",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey,
                ),
              ),
              GestureDetector(
                onTap: showDateRangePickerDialog,
                child: Column(
                  children: [
                    const Text(
                      "Start",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      formatDateTimeDatePart(dateRange.start),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.red[400] ?? Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: showDateRangePickerDialog,
                child: Column(
                  children: [
                    const Text(
                      "End",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      formatDateTimeDatePart(dateRange.end),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.red[400] ?? Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () =>
                    loadData(context.read<AuthProvider>().accessToken),
                child: const Text("Fetch Data"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDateRangePickerDialog() async {
    var res = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: ThemeData(
          primarySwatch: Colors.red,
        ),
        child: child ?? const Text(''),
      ),
    );
    if (res == null) return;
    setState(() {
      dateRange = res;
    });
  }
}
