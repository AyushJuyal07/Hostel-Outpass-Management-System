class InnerOfficerModel {
  InnerOfficerModel({
    required this.id,
    required this.name,
  });
  late String id;
  late String name;

  InnerOfficerModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    return data;
  }
}


// {
//   "_id":"",
//   "name":""
// }