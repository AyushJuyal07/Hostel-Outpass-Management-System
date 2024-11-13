part of 'node_guard.dart';

Future<void> _verifyPass(
  String uid, {
  required String token,
  ApiCallbackListener? listener,
}) async {
  String url = "$kBaseUrl/guard/verifyPass";
  try {
    http.Response response = await http.post(
      Uri.parse(url),
      body: jsonEncode({"uid": uid.toUpperCase()}),
      headers: {
        "Content-Type": 'application/json',
        'Authorization': "Bearer $token",
      },
    );
    print(response.body);
    listener?.call(response.statusCode, responseBody: response.body);
  } catch (e) {
    var err = "Error: $e";
    print(err);
  }
}
