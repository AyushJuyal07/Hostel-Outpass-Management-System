import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class WardenProvider extends ChangeNotifier {
  final List<String> _purposes = [];
  List<String> get purposes => _purposes;

  final List<String> _places = [];
  List<String> get places => _places;

  final List<String> _ids = ["21bcg1018"];
  List<String> get ids => _ids;

  void addPurpose(String value) {
    if (_purposes.contains(value)) {
      _purposes.remove(value);
    } else if (_purposes.length > kTextFieldSuggestionLimit) {
      _purposes.removeLast();
    }
    _purposes.insert(0, value);
    notifyListeners();
  }

  void addPlace(String value) {
    if (_places.contains(value)) {
      _places.remove(value);
    } else if (_places.length > kTextFieldSuggestionLimit) {
      _places.removeLast();
    }
    _places.insert(0, value);
    notifyListeners();
  }

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
