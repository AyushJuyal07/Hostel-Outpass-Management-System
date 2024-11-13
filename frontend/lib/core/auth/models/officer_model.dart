import 'package:cu_hostel/utils/utility.dart';

import '../../../utils/enums.dart';

class OfficerModel {
  OfficerModel({
    required this.eid,
    required this.name,
    required this.role,
    required this.id,
    this.token,
  });
  late String eid;
  late String name;
  late String id;
  late OfficerRole role;
  String? token;

  OfficerModel.fromJson(Map<String, dynamic> json) {
    eid = json['user']['eid'];
    name = json['user']['name'];
    id = json['user']['_id'];
    role = parseRoleFromString(json['user']['role']);
    token = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user']['eid'] = eid;
    data['user']['name'] = name;
    data['user']['_id'] = id;
    data['user']['role'] = officerRole2String(role);
    data['user']['accessToken'] = token;
    return data;
  }
}

// {"eid":"1234","name":"John Doe","role":"warden"}