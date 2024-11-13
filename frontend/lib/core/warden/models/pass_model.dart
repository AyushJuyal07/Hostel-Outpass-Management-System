import 'dart:convert';

import 'package:cu_hostel/core/warden/models/hostel_model.dart';
import 'package:cu_hostel/core/warden/models/inner_officer.dart';
import 'package:cu_hostel/core/warden/models/student_model.dart';
import 'package:cu_hostel/utils/enums.dart';

import '../../../utils/utility.dart';

class PassModel {
  PassModel({
    required this.name,
    required this.uid,
    required this.mobileNo,
    required this.guardianNo,
    required this.hostelDetails,
    required this.purpose,
    required this.place,
    required this.outTime,
    required this.inTime,
    required this.warden,
    this.openedBy,
    this.closedBy,
    this.isDayPass = true,
    this.status = PassStatus.generated,
  });
  late String name;
  late String uid;
  late String mobileNo;
  late HostelModel hostelDetails;
  late String purpose;
  late String place;
  late DateTime outTime;
  late DateTime inTime;
  late InnerOfficerModel warden;
  String? guardianNo;
  InnerOfficerModel? openedBy; // Guard who verify student going outside
  InnerOfficerModel? closedBy; // Guard who verify student returning back
  bool isDayPass = true;
  PassStatus status = PassStatus.generated;

  PassModel.demo([
    this.isDayPass = true,
    this.status = PassStatus.generated,
  ]) {
    name = "test";
    uid = "22bsc32523";
    mobileNo = "32536246426";
    hostelDetails = HostelModel(hostelName: "NCT-6", roomNo: 701);
    purpose = "dummy";
    place = "dummy land";
    outTime = DateTime.now();
    inTime = outTime.add(const Duration(hours: 32));
    warden = InnerOfficerModel(id: "3243252", name: "name");
  }

  PassModel.fromStudentDetails(
    StudentModel std, {
    required this.purpose,
    required this.place,
    required this.outTime,
    required this.inTime,
    required this.warden,
    this.openedBy,
    this.closedBy,
    this.status = PassStatus.generated,
    this.isDayPass = true,
  }) {
    var json = std.toJson();
    name = json['name'];
    uid = json['uid'];
    mobileNo = json['mobileNo'];
    guardianNo = json['guardianNo'];
    hostelDetails = HostelModel.fromJson(json['hostelDetails']);
  }

  PassModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uid = json['uid'];
    mobileNo = json['mobileNo'];
    guardianNo = json['guardianNo'];
    hostelDetails = HostelModel.fromJson(json['hostelDetails']);
    purpose = json['purpose'];
    place = json['place'];
    outTime = DateTime.parse(json['outTime']);
    inTime = DateTime.parse(json['inTime']);
    isDayPass =
        json['category'].toString().toLowerCase() == "night" ? false : true;
    warden = InnerOfficerModel.fromJson(json['warden']);
    if (json['openedBy'] != null) {
      openedBy = InnerOfficerModel.fromJson(json['openedBy']);
    }
    if (json['closedBy'] != null) {
      closedBy = InnerOfficerModel.fromJson(json['closedBy']);
    }
    status = parsePassStatusFromString(json['status']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['uid'] = uid;
    data['mobileNo'] = mobileNo;
    data['guardianNo'] = guardianNo;
    data['hostelDetails'] = hostelDetails.toJson();
    data['purpose'] = purpose;
    data['place'] = place;
    data['outTime'] = outTime.toIso8601String();
    data['inTime'] = inTime.toIso8601String();
    data['category'] = isDayPass ? "DAY" : "NIGHT";
    data['warden'] = warden.toJson();
    data['openedBy'] = openedBy?.toJson();
    data['closedBy'] = closedBy?.toJson();
    data['status'] = passStatus2String(status);
    return data;
  }
}




// {
//   "name": "Naimish Mishra",
//   "uid": "21BCG1018",
//   "mobileNo": "5689231245",
//   "gurdianNo": "1245785623",
//   "hostelDetails": {
//     "hostelName": "Govind-B",
//     "roomNo": 301
//   }, 
//   "purpose":"",
//   "place":"",
//   "outTime":23,
//   "inTime":23,
//   "wardenId":""
// }