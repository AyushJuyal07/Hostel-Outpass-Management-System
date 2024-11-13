part of 'node_warden.dart';

Future<List<PassModel>> _getPassList(String token,
    {ApiCallbackListener? listener}) async {
  List<PassModel> res = [];
  String url = "$kBaseUrl/hostel/getPassList";
  // String token =
  //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NDkwNDMwODNlNTQzMjM3ZDFiZDA4NTAiLCJlaWQiOiIxMjM0IiwibmFtZSI6IkpvaG4gRG9lIiwicm9sZSI6IndhcmRlbiIsImhvc3RlbE5hbWUiOiJHb3ZpbmQtQiIsImlhdCI6MTY5MDY5MDM2NSwiZXhwIjoxNjkwNjkyMTY1fQ.8f9_lCFYv-KjHn_HgBb3YeQ2Zp8xxbTdxF5Gy6RciGg";
  try {
    http.Response response = await http.get(
      Uri.parse(url),
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
      for (var v in json as List) {
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
