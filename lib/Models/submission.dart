import 'academic_information.dart';

class Submission {
  int? channelId;
  int? oSId;

  int? scientificBackgroundId;
  int? specializationId;
  int? departmentId;
  int? relativeId;
  List<Documents>? documents;

  Submission(
      {this.channelId,
        this.oSId,

        this.scientificBackgroundId,
        this.specializationId,
        this.departmentId,
        this.relativeId,
        this.documents});

  Submission.fromJson(Map<String, dynamic> json) {
    channelId = json['channelId'];
    oSId = json['OSId'];
    scientificBackgroundId = json['ScientificBackgroundId'];
    specializationId = json['SpecializationId'];
    departmentId = json['departmentId'];
    departmentId = json['relativeId'];
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(Documents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['channelId'] = channelId;
    data['Osid'] = oSId;
    data['relativeId'] = relativeId;
    data['ScientificBackgroundId'] = scientificBackgroundId;
    data['SpecializationId'] = specializationId;
    data['departmentId'] = departmentId;
    if (documents != null) {
      data['documents'] = documents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

