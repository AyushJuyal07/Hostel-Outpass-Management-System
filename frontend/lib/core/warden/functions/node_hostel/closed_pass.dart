part of 'node_warden.dart';

Future<List<PassModel>> _getClosedPasses(
  String token, {
  required DateTime startDate,
  required DateTime endDate,
  int startIndex = 0,
  int limit = 50,
  ApiCallbackListener? listener,
}) async {
  List<PassModel> res = [];
  String url = "$kBaseUrl/hostel/getAllPasses";
  // String token =
  //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NDkwNDMwODNlNTQzMjM3ZDFiZDA4NTAiLCJlaWQiOiIxMjM0IiwibmFtZSI6IkpvaG4gRG9lIiwicm9sZSI6IndhcmRlbiIsImhvc3RlbE5hbWUiOiJHb3ZpbmQtQiIsImlhdCI6MTY5MDY5MzI1OCwiZXhwIjoxNjkwNjk1MDU4fQ.j2k9Kis3naXvG3A50GmzQQVwJqbWdfWDro8sZzHeGLM";

  Map<String, dynamic> body = {
    'from': startDate.toIso8601String(),
    'to': endDate.toIso8601String(),
    "start": startIndex,
    "size": limit,
  };
  try {
    print("body $body");
    http.Response response = await http.post(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: {
        "Content-Type": 'application/json',
        'Accept': "application/json",
        'Authorization': "Bearer $token",
      },
    );
    print(response.statusCode);
    listener?.call(response.statusCode, responseBody: response.body);
    if (response.statusCode < 400) {
      var json = jsonDecode(response.body);
      print(response.body);
      for (var v in json['slicedPasses'] as List) {
        PassModel pass = PassModel.fromJson(v);
        res.add(pass);
      }
    }
  } catch (e) {
    listener?.call(999, error: e.toString());
    print("Error pass list: $e");
  }
  return res;
}
