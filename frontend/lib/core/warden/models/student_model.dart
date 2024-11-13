import 'package:cu_hostel/core/warden/models/pass_model.dart';

import 'hostel_model.dart';

class StudentModel {
  StudentModel({
    required this.name,
    required this.uid,
    required this.mobileNo,
    required this.guardianNo,
    required this.hostelDetails,
  });
  late final String name;
  late final String uid;
  late final String mobileNo;
  late final String guardianNo;
  late final HostelModel hostelDetails;

  StudentModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uid = json['uid'];
    mobileNo = json['mobileNo'];
    guardianNo = json['guardianNo'];
    hostelDetails = HostelModel.fromJson(json['hostelDetails']);
  }

  StudentModel.fromPass(PassModel pass) {
    name = pass.name;
    uid = pass.uid;
    mobileNo = pass.mobileNo;
    guardianNo = pass.mobileNo;
    hostelDetails = pass.hostelDetails;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['uid'] = uid;
    data['mobileNo'] = mobileNo;
    data['guardianNo'] = guardianNo;
    data['hostelDetails'] = hostelDetails.toJson();
    return data;
  }
}
