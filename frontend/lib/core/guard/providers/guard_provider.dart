import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class GuardProvider extends ChangeNotifier {
  final List<String> _ids = ["21bcg1018"];
  List<String> get ids => _ids;

  void addUid(String value) {
    if (_ids.contains(value)) {
      _ids.remove(value);
    } else if (_ids.length > kTextFieldSuggestionLimit) {
      _ids.removeLast();
    }
    _ids.insert(0, value);
    notifyListeners();
  }
}
