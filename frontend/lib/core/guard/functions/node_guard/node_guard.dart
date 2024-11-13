import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../../../../utils/api_callback_listener.dart';
import '../../../../utils/constants.dart';
import '../../../warden/models/pass_model.dart';

part 'pass_details.dart';
part 'pass_verify.dart';

class NodeGuard {
  static Future<PassModel?> getPassDetails(
    String uid, {
    required String token,
    ApiCallbackListener? listener,
  }) async {
    return _getPassDetails(
      uid,
      token: token,
      listener: listener,
    );
  }

  static Future<void> verifyPass(
    String uid, {
    required String token,
    ApiCallbackListener? listener,
  }) async {
    return _verifyPass(
      uid,
      token: token,
      listener: listener,
    );
  }
}
