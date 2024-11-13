import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../utils/api_callback_listener.dart';
import '../../../../utils/constants.dart';
import '../../models/officer_model.dart';

part 'login.dart';

class NodeAuth {
  static Future<OfficerModel?> loginWithEidPass({
    required String eid,
    required String pass,
    ApiCallbackListener? listener,
  }) async {
    return _loginWithEidPass(
      eid: eid,
      pass: pass,
      listener: listener,
    );
  }
}
