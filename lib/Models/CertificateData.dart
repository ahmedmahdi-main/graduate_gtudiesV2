import 'Academicinformation.dart';

class CertificateData {
  int? isRegistrationUpgraded;
  String? name;
  int? medalTypeId;
  List<Certificatecompetency>? certificateCompetency;
  List<Documents>? documents;

  CertificateData(
      {this.isRegistrationUpgraded,
        this.name,
        this.medalTypeId,
        this.certificateCompetency,
        this.documents});

  CertificateData.fromJson(Map<String, dynamic> json) {
    isRegistrationUpgraded = json['IsRegistrationUpgraded'];
    name = json['Name'];
    medalTypeId = json['MedalTypeId'];
    if (json['certificatecompetency'] != null) {
      certificateCompetency = <Certificatecompetency>[];
      json['certificatecompetency'].forEach((v) {
        certificateCompetency!.add(Certificatecompetency.fromJson(v));
      });
    }
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(Documents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['IsRegistrationUpgraded'] = isRegistrationUpgraded;
    data['Name'] = name;
    data['MedalTypeId'] = medalTypeId;
    if (certificateCompetency != null) {
      data['certificatecompetency'] =
          certificateCompetency!.map((v) => v.toJson()).toList();
    }
    if (documents != null) {
      data['documents'] = documents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Certificatecompetency {
  double? appreciation;
  int? certificateCompetencyTypeId;
  int? examCenterId;

  Certificatecompetency(
      {this.appreciation, this.certificateCompetencyTypeId, this.examCenterId});

  Certificatecompetency.fromJson(Map<String, dynamic> json) {
    appreciation = json['Appreciation'];
    certificateCompetencyTypeId = json['CertificateCompetencyTypeId'];
    examCenterId = json['ExamCenterId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Appreciation'] = appreciation;
    data['CertificateCompetencyTypeId'] = certificateCompetencyTypeId;
    data['ExamCenterId'] = examCenterId;
    return data;
  }
}

