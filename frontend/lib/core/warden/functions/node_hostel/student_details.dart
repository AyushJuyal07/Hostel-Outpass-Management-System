part of 'node_warden.dart';

Future<StudentModel?> _getStudentDetails({
  required String uid,
  required String token,
  ApiCallbackListener? listener,
}) async {
  listener ??= const ApiCallbackListener();
  String url = "$kBaseUrl/hostel/getStudentDetails/";
  try {
    debugPrint('token $token');
    var response = await http.post(
      Uri.parse(url),
      body: jsonEncode({"uid": uid.toUpperCase()}),
      headers: {
        "Content-Type": 'application/json',
        'Accept': "application/json",
        'Authorization': "Bearer $token",
      },
    );
    if (response.statusCode >= 400) {
      listener.call(response.statusCode, responseBody: response.body);
      return null;
    }
    listener.call(response.statusCode);
    return StudentModel.fromJson(jsonDecode(response.body));
  } catch (e) {
    print("Error in getting student details $e");
    listener.call(999, error: e.toString());
    return null;
  }
}
