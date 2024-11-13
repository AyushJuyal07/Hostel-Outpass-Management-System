part of 'node_warden.dart';

Future<bool> _editPass({
  required PassModel pass,
  required String token,
  ApiCallbackListener? listener,
}) async {
  listener ??= const ApiCallbackListener();
  String url = "$kBaseUrl/hostel/editPass/";
  try {
    var response = await http.put(
      Uri.parse(url),
      body: jsonEncode(pass.toJson()),
      headers: {
        "Content-Type": 'application/json',
        'Accept': "application/json",
        'Authorization': "Bearer $token",
      },
    );
    debugPrint('status: ${response.statusCode}');
    if (response.statusCode >= 400) {
      listener.call(response.statusCode, responseBody: response.body);
      return false;
    }
    listener.call(response.statusCode);
    return true;
  } catch (e) {
    print("Error in Generating pass $e");
    listener.call(999, error: e.toString());
    return false;
  }
}
