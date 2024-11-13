import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../../utils/api_callback_listener.dart';
import '../../../../utils/constants.dart';
import 'package:http/http.dart' as http;

import '../../models/pass_model.dart';
import '../../models/student_model.dart';

part 'student_details.dart';
part 'pass_generation.dart';
part 'pass_edit.dart';
part 'pass_details.dart';
part 'pass_delete.dart';
part 'pass_list.dart';
part 'closed_pass.dart';

class NodeWarden {
  static Future<StudentModel?> getStudentDetails({
    required String uid,
    required String token,
    ApiCallbackListener? listener,
  }) async {
    return _getStudentDetails(
      uid: uid,
      token: token,
      listener: listener,
    );
  }

  static Future<bool> generatePass({
    required PassModel pass,
    required String token,
    ApiCallbackListener? listener,
  }) async {
    return _generatePass(
      pass: pass,
      token: token,
      listener: listener,
    );
  }

  static Future<bool> editPass({
    required PassModel pass,
    required String token,
    ApiCallbackListener? listener,
  }) async {
    return _editPass(
      pass: pass,
      token: token,
      listener: listener,
    );
  }

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

  static Future<PassModel?> deletePass(
    String uid, {
    required String token,
    ApiCallbackListener? listener,
  }) async {
    return _deletePass(
      uid,
      token: token,
      listener: listener,
    );
  }

  static Future<List<PassModel>> getPassList(String token,
      {ApiCallbackListener? listener}) async {
    return _getPassList(
      token,
      listener: listener,
    );
  }

  static Future<List<PassModel>> getClosedPasses(
    String token, {
    required DateTime startDate,
    required DateTime endDate,
    int startIndex = 0,
    int limit = 50,
    ApiCallbackListener? listener,
  }) async {
    return _getClosedPasses(
      token,
      startDate: startDate,
      endDate: endDate,
      startIndex: startIndex,
      limit: limit,
      listener: listener,
    );
  }
}
