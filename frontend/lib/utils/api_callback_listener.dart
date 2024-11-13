// void apiCompletionHandler({
//   required int statusCode,
//   String? error,
//   Function(String error)? onError,
//   Function()? onSuccess,
// }) {}

import 'dart:convert';

import 'package:cu_hostel/utils/utility.dart';

class ApiCallbackListener {
  const ApiCallbackListener({
    // required this.statusCode,
    // this.error,
    this.onSuccess,
    this.onError,
    this.onComplete,
  });

  // final int statusCode;
  // final String? error;
  final Function()? onSuccess;
  final Function(String error)? onError;

  /// this will be called first irrespective to error
  final Function()? onComplete;

  void call(
    int statusCode, {
    String? error,
    String? responseBody,
  }) {
    if (onComplete != null) onComplete!();
    if (error != null) {
      if (onError != null) onError!(error);
      showMyToast("Error: $error", isError: true);
    } else if (statusCode < 400) {
      print("Success");
      if (onSuccess != null) onSuccess!();
    } else if (statusCode >= 400) {
      print("Error $statusCode| $responseBody");
      var err = responseBody != null
          ? jsonDecode(responseBody)['message']
          : error ?? "Unknown Error";

      showMyToast("Error: $err", isError: true);
      if (onError != null) {
        onError!(err);
      }
    } else {
      var err = error ?? "Unexpected Error";
      showMyToast(err, isError: true);
      if (onError != null) onError!(err);
    }
  }
}
