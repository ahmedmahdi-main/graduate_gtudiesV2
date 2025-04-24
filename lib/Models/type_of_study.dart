class TypeofStudy {
  List<Typeofstudy>? typeofStudy;

  TypeofStudy({this.typeofStudy});

  TypeofStudy.fromJson(Map<String, dynamic> json) {
    if (json['typeofstudy'] != null) {
      typeofStudy = <Typeofstudy>[];
      json['typeofstudy'].forEach((v) {
        typeofStudy!.add(Typeofstudy.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (typeofStudy != null) {
      data['typeofstudy'] = typeofStudy!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Typeofstudy {
  int? tSid;
  String? typeofStudyName;

  Typeofstudy({this.tSid, this.typeofStudyName});

  Typeofstudy.fromJson(Map<String, dynamic> json) {
    tSid = json['TSid'];
    typeofStudyName = json['TypeofStudyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TSid'] = tSid;
    data['TypeofStudyName'] = typeofStudyName;
    return data;
  }
}
