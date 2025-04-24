class ExamCenters {
  List<Centers>? centers;

  ExamCenters({this.centers});

  ExamCenters.fromJson(Map<String, dynamic> json) {
    if (json['Centers'] != null) {
      centers = <Centers>[];
      json['Centers'].forEach((v) {
        centers!.add(Centers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (centers != null) {
      data['Centers'] = centers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Centers {
  int? examCenterId;
  String? name;
  dynamic deleted;

  Centers({this.examCenterId, this.name, this.deleted});

  Centers.fromJson(Map<String, dynamic> json) {
    examCenterId = json['ExamCenterId'];
    name = json['name'];
    deleted = json['deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ExamCenterId'] = examCenterId;
    data['name'] = name;
    data['deleted'] = deleted;
    return data;
  }
}
