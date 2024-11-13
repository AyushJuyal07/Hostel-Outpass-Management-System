part of 'node_auth.dart';

Future<OfficerModel?> _loginWithEidPass({
  required String eid,
  required String pass,
  // Function()? onComplete,
  // Function(String error)? onError,
  ApiCallbackListener? listener,
}) async {
  String url = "$kBaseUrl/auth/login/";
  final body = jsonEncode({"eid": eid, "password": pass});
  print("url $url");
  OfficerModel? off;
  try {
    http.Response res = await http.post(
      Uri.parse(url),
      body: body,
      headers: <String, String>{'Content-Type': 'application/json'},
    );
    // print(res.statusCode);
    print(res.body);
    if (res.statusCode < 400) {
      off = OfficerModel.fromJson(jsonDecode(res.body));
    }
    listener?.call(res.statusCode, responseBody: res.body);
  } catch (e) {
    print(e);
    listener?.call(999, error: e.toString());
  }
  return off;
}
