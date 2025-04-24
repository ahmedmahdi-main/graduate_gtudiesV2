import 'academic_information.dart';

class CareerInformation {
  int? typeConsentId;
  int? employmentStatusId;
  String? dateCommencement;
  int? ministryId;
  int? scientificTitleId;
  String? organizationName;
  int? universityService;
  List<Documents>? documents;

  CareerInformation(
      {this.typeConsentId,
        this.employmentStatusId,
        this.dateCommencement,
        this.ministryId,
        this.scientificTitleId,
        this.organizationName,
        this.universityService,
        this.documents});

  CareerInformation.fromJson(Map<String, dynamic> json) {
    typeConsentId = json['TypeConsentId'];
    employmentStatusId = json['EmploymentStatusId'];
    dateCommencement = json['DateCommencement'];
    ministryId = json['MinistryId'];
    scientificTitleId = json['ScientificTitleId'];
    organizationName = json['OrganizationName'];
    universityService = json['UniversityService'];
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(Documents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TypeConsentId'] = typeConsentId;
    data['EmploymentStatusId'] = employmentStatusId;
    data['DateCommencement'] = dateCommencement;
    data['MinistryId'] = ministryId;
    data['ScientificTitleId'] = scientificTitleId;
    data['OrganizationName'] = organizationName;
    data['UniversityService'] = universityService;
    if (documents != null) {
      data['documents'] = documents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

