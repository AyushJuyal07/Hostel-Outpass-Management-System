import 'dart:convert';

import 'package:cu_hostel/core/auth/models/officer_model.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  OfficerModel? _officer;
  OfficerModel? get officer => _officer;
  String get accessToken => _officer?.token ?? "";

  bool get isLoggedIn => _officer != null;

  void init() {
    var t = """{

          "user":{"_id":"649043083e543237d1bd0850","eid":"1234","name":"John Doe","role":"warden"},"accessToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NDkwNDMwODNlNTQzMjM3ZDFiZDA4NTAiLCJlaWQiOiIxMjM0IiwibmFtZSI6IkpvaG4gRG9lIiwicm9sZSI6IndhcmRlbiIsImhvc3RlbE5hbWUiOiJHb3ZpbmQtQiIsImlhdCI6MTY4ODgyNTk4MSwiZXhwIjoxNjg4ODI3NzgxfQMksft-rdw4_inF1TTklM2dRCEwWROerSHxJSs0CY95o"}""";
    // _officer = OfficerModel.fromJson(jsonDecode(t));
  }

  void setOfficer(OfficerModel officer) {
    _officer = officer;
    notifyListeners();
  }

  void signOut() {
    _officer = null;
    notifyListeners();
  }
}
