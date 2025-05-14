class UserProfile {
  int? id;
  String? studentUuid;
  String? fullName;
  String? email;
  int? code;

  UserProfile({this.id, this.studentUuid, this.fullName, this.email,this.code});

  UserProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentUuid = json['studentuuid'];
    fullName = json['full_name'];
    email = json['email'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['studentuuid'] = studentUuid;
    data['full_name'] = fullName;
    data['email'] = email;
    data['code'] = code;
    return data;
  }
}
