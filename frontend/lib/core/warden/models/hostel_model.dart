class HostelModel {
  HostelModel({
    required this.hostelName,
    required this.roomNo,
  });
  late String hostelName;
  late int roomNo;

  HostelModel.fromJson(Map<String, dynamic> json) {
    hostelName = json['hostelName'];
    roomNo = json['roomNo'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['hostelName'] = hostelName;
    data['roomNo'] = roomNo;
    return data;
  }
}
