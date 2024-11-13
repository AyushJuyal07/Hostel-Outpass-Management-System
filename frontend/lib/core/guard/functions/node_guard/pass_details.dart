part of 'node_guard.dart';

Future<PassModel?> _getPassDetails(
  String uid, {
  required String token,
  ApiCallbackListener? listener,
}) async {
  PassModel? pass;
  String url = "$kBaseUrl/guard/getGeneratedPass";
  try {
    http.Response response = await http.post(
      Uri.parse(url),
      body: jsonEncode({"uid": uid.toUpperCase()}),
      headers: {
        "Content-Type": 'application/json',
        'Accept': "application/json",
        'Authorization': "Bearer $token",
      },
    );
    print(response.body);
    if (response.statusCode < 400) {
      pass = PassModel.fromJson(jsonDecode(response.body));
    }
    listener?.call(response.statusCode, responseBody: response.body);
  } catch (e) {
    var err = "Error: $e";
    print(err);
  }
  return pass;
}
