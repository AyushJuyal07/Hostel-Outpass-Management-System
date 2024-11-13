import 'package:cu_hostel/utils/api_callback_listener.dart';

import 'node_auth/node_auth.dart';
import '../models/officer_model.dart';

class AuthApi {
  static Future<OfficerModel?> loginWithEidPass(
      {required String eid,
      required String pass,
      ApiCallbackListener? listener}) async {
    return NodeAuth.loginWithEidPass(
      eid: eid,
      pass: pass,
      listener: listener,
    );
  }
}
