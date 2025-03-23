class CollegeAuthorize {
  CollegeAuthorized? collegeAuthorized;

  CollegeAuthorize({this.collegeAuthorized});

  CollegeAuthorize.fromJson(Map<String, dynamic> json) {
    collegeAuthorized = json['College_Authorized'] != null
        ? CollegeAuthorized.fromJson(json['College_Authorized'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (collegeAuthorized != null) {
      data['College_Authorized'] = collegeAuthorized!.toJson();
    }
    return data;
  }
}

class CollegeAuthorized {
  int? id;
  int? idCollege;
  String? name;
  // String? deletedAt;

  CollegeAuthorized({this.id, this.idCollege, this.name});

  CollegeAuthorized.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idCollege = json['id_College'];
    name = json['name'];
    // deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_College'] = idCollege;
    data['name'] = name;
    // data['deleted_at'] = deletedAt;
    return data;
  }
}
