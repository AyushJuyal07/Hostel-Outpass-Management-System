import 'package:flutter/foundation.dart';

String? validatePassword(String? value) {
  if (value == null || value == "") {
    return "Password is required field";
  } else if (value.length < 8) {
    return "Password length should be at least 8 character.";
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value == "") {
    return "Email is required field";
  } else if (value.length < 6) {
    return "Invalid Email";
  } else if (!value.contains('@') || !value.contains('.')) {
    return 'Invalid Email';
  }
  return null;
}

String? validateName(String? value) {
  if (value == null || value == "") {
    return "Name is required field";
  } else if (value.length < 3) {
    return "Name length should be at least 3 character.";
  }
  return null;
}

String? validatePhoneNumber(String? value) {
  if (value == null || value == "") {
    return "Phone Number is required field";
  } else if (value.length < 3) {
    return "Invalid Number";
  } else {
    try {
      int? v = int.tryParse(value);
      if (v == null) {
        return "Invalid Number";
      }
    } catch (e) {
      debugPrint("Error $e");
    }
  }
  return null;
}

String? validateDesc(String? value) {
  if (value == null || value == "") {
    return "Desc is required field";
  } else if (value.length < 50) {
    return "Desc must have at least 50 characters";
  }
  return null;
}

String? validateUid(String? value) {
  if (value == null || value == "") {
    return "Uid is required field";
  }
  // var temp = value.
  return null;
}

String? defaultValidator(String? value) {
  if (value == null || value == "") {
    return "Required field";
  } else if (value.length < 3) {
    return "Must contain at least 3 characters";
  }
  // var temp = value.
  return null;
}
