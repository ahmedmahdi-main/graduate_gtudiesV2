class UserProfile {
  int? id;
  String? studentuuid;
  String? fullName;
  String? email;

  UserProfile({this.id, this.studentuuid, this.fullName, this.email});

  UserProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentuuid = json['studentuuid'];
    fullName = json['full_name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['studentuuid'] = this.studentuuid;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    return data;
  }
}
