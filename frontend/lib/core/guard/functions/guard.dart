import 'package:cu_hostel/core/guard/functions/node_guard/node_guard.dart';

import '../../../utils/api_callback_listener.dart';
import '../../warden/models/pass_model.dart';

class GuardApi {
  static Future<PassModel?> getPassDetails(
    String uid, {
    required String token,
    ApiCallbackListener? listener,
  }) async {
    return NodeGuard.getPassDetails(
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
    return NodeGuard.verifyPass(
      uid,
      token: token,
      listener: listener,
    );
  }
}
