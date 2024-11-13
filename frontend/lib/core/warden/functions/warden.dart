import '../../../utils/api_callback_listener.dart';
import '../models/pass_model.dart';
import '../models/student_model.dart';
import 'node_hostel/node_warden.dart';

class WardenApi {
  static Future<StudentModel?> getStudentDetails({
    required String uid,
    required String token,
    ApiCallbackListener? listener,
  }) async {
    return NodeWarden.getStudentDetails(
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
    return NodeWarden.generatePass(
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
    return NodeWarden.editPass(
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
    return NodeWarden.getPassDetails(
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
    return NodeWarden.deletePass(
      uid,
      token: token,
      listener: listener,
    );
  }

  static Future<List<PassModel>> getPassList(String token,
      {ApiCallbackListener? listener}) async {
    return NodeWarden.getPassList(
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
    return NodeWarden.getClosedPasses(
      token,
      startDate: startDate,
      endDate: endDate,
      startIndex: startIndex,
      limit: limit,
      listener: listener,
    );
  }
}
