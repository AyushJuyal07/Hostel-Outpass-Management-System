import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';

import 'enums.dart';

OfficerRole parseRoleFromString(String role) {
  if (role.toLowerCase() == "warden") {
    return OfficerRole.warden;
  }
  return OfficerRole.guard;
}

String officerRole2String(OfficerRole role) {
  if (role == OfficerRole.warden) {
    return "Warden";
  }
  return "Guard";
}

PassStatus parsePassStatusFromString(String status) {
  status = status.toLowerCase();
  switch (status) {
    case 'n':
      return PassStatus.generated;
    case 'o':
      return PassStatus.opened;
    case 'c':
      return PassStatus.closed;

    default:
      return PassStatus.generated;
  }
}

String passStatus2String(PassStatus status) {
  return switch (status) {
    PassStatus.generated => 'n',
    PassStatus.opened => 'o',
    PassStatus.closed => 'c'
  };
}

String passStatus2PrintableString(PassStatus status) {
  return switch (status) {
    PassStatus.generated => 'Generated',
    PassStatus.opened => 'Open',
    PassStatus.closed => 'Closed'
  };
}

// String dateTime2IsoString(DateTime dateTime) {
//   return DateFormat('yyyy-MM-ddThh:mm').format(dateTime);
// }

String formatDateTimeDatePart(DateTime time) {
  return DateFormat('yyyy-MM-dd').format(time);
}

String formatDateTimeTimePart(DateTime time) {
  return DateFormat('hh:mm a').format(time);
}

void showMyToast(
  String message, {
  bool isError = false,
  Duration duration = const Duration(seconds: 2),
}) {
  showToast(
    message,
    position: ToastPosition.bottom,
    textStyle: const TextStyle(
      fontSize: 18,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    ),
    backgroundColor: isError ? Colors.red[500] : Colors.black,
    textAlign: TextAlign.center,
    textMaxLines: 3,
    textOverflow: TextOverflow.ellipsis,
    duration: duration,
  );
}
