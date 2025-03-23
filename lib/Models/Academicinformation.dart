import 'full_student_data.dart';

class AcademicInformationModel {
  List<AcademicInformation>? academicInformation;

  AcademicInformationModel({this.academicInformation});

  AcademicInformationModel.fromJson(Map<String, dynamic> json) {
    if (json['academicInformation'] != null) {
      academicInformation = <AcademicInformation>[];
      json['academicInformation'].forEach((v) {
        academicInformation!.add(AcademicInformation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (academicInformation != null) {
      data['academicInformation'] =
          academicInformation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AcademicInformation {
  String? certificateIssuedBy;
  String? academicYear;
  double? average;
  String? specializationId;
  int? sequence;
  int? firstStudentAverage;
  int? isFirstStudent;
  int? firstQuarter;
  int? nOBatch;
  int? isDiplomaCompatible;
  int? isMasterWithinPeriod;
  int? certificateTypeId;
  String? universityId;
  String? collegesId;
  String? departmentId;

  // String? studentUUID;
  List<Documents>? documents;

  AcademicInformation(
      {this.certificateIssuedBy,
      this.academicYear,
      this.average,
      this.specializationId,
      this.sequence,
      this.firstStudentAverage,
      this.isFirstStudent,
      this.firstQuarter,
      this.isDiplomaCompatible,
      this.isMasterWithinPeriod,
      this.certificateTypeId,
      this.nOBatch,
      this.universityId,
      this.collegesId,
      this.departmentId,
      // this.studentUUID,
      this.documents});

  static AcademicInformation fromFullData(
      FullDataAcademicInformation fullData) {
    return AcademicInformation(
      certificateIssuedBy: fullData.certificateIssuedBy,
      academicYear: fullData.academicYear,
      average: fullData.average,
      specializationId: fullData.specializationId.toString(),
      sequence: fullData.sequence,
      firstStudentAverage: fullData.firstStudentAverage?.toInt(),
      isFirstStudent: fullData.isFirstStudent,
      isDiplomaCompatible: fullData.isDiplomaCompatible,
      isMasterWithinPeriod: fullData.isMasterWithinPeriod,
      certificateTypeId: fullData.certificateTypeId,
      universityId: fullData.universityId.toString(),
      collegesId: fullData.collegesId.toString(),
      departmentId: fullData.departmentId.toString(),
      nOBatch: fullData.nOBatch,
      firstQuarter: fullData.firstQuarter,
      // studentUUID: fullData.studentUUID, // Uncomment if needed
      documents: fullData.documents,
    );
  }

  AcademicInformation.fromJson(Map<String, dynamic> json) {
    certificateIssuedBy = json['CertificateIssuedBy'];
    academicYear = json['AcademicYear'];
    average = json['Average'];
    firstQuarter = json['FirstQuarter'];
    specializationId = json['SpecializationId'];
    sequence = json['sequence'];
    firstStudentAverage = json['FirstStudentAverage'];
    isFirstStudent = json['IsFirstStudent'];
    isDiplomaCompatible = json['IsDiplomaCompatible'];
    isMasterWithinPeriod = json['IsMasterWithinPeriod'];
    certificateTypeId = json['CertificateTypeId'];
    universityId = json['UniversityId'];
    collegesId = json['CollegesId'];
    departmentId = json['DepartmentId'];
    nOBatch = json['NO_Batch'];
    // studentUUID = json['StudentUUID'];
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(Documents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CertificateIssuedBy'] = certificateIssuedBy;
    data['AcademicYear'] = academicYear;
    data['Average'] = average;
    data['SpecializationId'] = specializationId;
    data['sequence'] = sequence;
    data['FirstStudentAverage'] = firstStudentAverage;
    data['IsFirstStudent'] = isFirstStudent;
    data['FirstQuarter'] = firstQuarter;
    data['IsDiplomaCompatible'] = isDiplomaCompatible;
    data['IsMasterWithinPeriod'] = isMasterWithinPeriod;
    data['CertificateTypeId'] = certificateTypeId;
    data['UniversityId'] = universityId;
    data['CollegesId'] = collegesId;
    data['DepartmentId'] = departmentId;
    data['NO_Batch'] = nOBatch;
    // data['StudentUUID'] = studentUUID;
    if (documents != null) {
      data['documents'] = documents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Documents {
  int? documentsId;
  String? documentsNumber;
  String? documentsDate;
  int? documentsTypeId;
  int? aIId;
  int? careerInformationId;
  int? aCID;
  int? sportChampionId;

  Documents(
      {this.documentsId,
      this.documentsNumber,
      this.documentsDate,
      this.documentsTypeId,
      this.aIId,
      this.careerInformationId,
      this.aCID,
      this.sportChampionId});

  Documents.fromJson(Map<String, dynamic> json) {
    documentsId = json['DocumentsId'];
    documentsNumber = json['DocumentsNumber'];
    documentsDate = json['DocumentsDate'];
    documentsTypeId = json['DocumentsTypeId'];
    aIId = json['AIId'];
    careerInformationId = json['CareerInformationId'];
    aCID = json['ACID'];
    sportChampionId = json['SportChampionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DocumentsId'] = this.documentsId;
    data['DocumentsNumber'] = this.documentsNumber;
    data['DocumentsDate'] = this.documentsDate;
    data['DocumentsTypeId'] = this.documentsTypeId;
    data['AIId'] = this.aIId;
    data['CareerInformationId'] = this.careerInformationId;
    data['ACID'] = this.aCID;
    data['SportChampionId'] = this.sportChampionId;
    return data;
  }
}
