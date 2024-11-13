part of 'node_warden.dart';

Future<PassModel?> _deletePass(
  String uid, {
  required String token,
  ApiCallbackListener? listener,
}) async {
  String url = "$kBaseUrl/hostel/deletePass";
  try {
    http.Response response = await http.delete(
      Uri.parse(url),
      body: jsonEncode({"uid": uid.toUpperCase()}),
      headers: {
        "Content-Type": 'application/json',
        'Accept': "application/json",
        'Authorization': "Bearer $token",
      },
    );
    print(response.body);
    // if (response.statusCode < 400) {
    //   // pass = PassModel.fromJson(jsonDecode(response.body));
    // }
    listener?.call(response.statusCode, responseBody: response.body);
  } catch (e) {
    var err = "Error: $e";
    print(err);
  }
}
