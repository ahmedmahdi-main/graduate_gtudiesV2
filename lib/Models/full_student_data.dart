import '../module/Addresses.dart';
import '../view/pages/PersonalInformation/StudentPersonalInformation.dart';
import 'Academicinformation.dart';
import 'CareerInformation.dart';
import 'CertificateData.dart';
import 'Submission.dart';
import 'TypeofStudy.dart';

/*
* FullStudentData.fromJson(Map<String, dynamic> json) {
  student = json['student'];
  collegeAuthorized = json['College_Authorized'];

  // Handle personalInformation as an object, not a list
  if (json['personalinformation'] != null) {
    personalInformation = <FullDataPersonalInformation>[];
    personalInformation!.add(FullDataPersonalInformation.fromJson(json['personalinformation']));
  }

  // Ensure 'Academicinformation' is a list before iterating
  if (json['Academicinformation'] != null && json['Academicinformation'] is List) {
    academicInformation = <FullDataAcademicInformation>[];
    json['Academicinformation'].forEach((v) {
      academicInformation!.add(FullDataAcademicInformation.fromJson(v));
    });
  }

  // Ensure 'Careerinformation' is a list before iterating
  if (json['Careerinformation'] != null && json['Careerinformation'] is List) {
    careerInformation = <FullDataCareerInformation>[];
    json['Careerinformation'].forEach((v) {
      careerInformation!.add(FullDataCareerInformation.fromJson(v));
    });
  }

  // Ensure 'Certificatecompetency' is a list before iterating
  if (json['Certificatecompetency'] != null && json['Certificatecompetency'] is List) {
    certificateCompetency = <FullDataCertificateCompetency>[];
    json['Certificatecompetency'].forEach((v) {
      certificateCompetency!.add(FullDataCertificateCompetency.fromJson(v));
    });
  }

  // Ensure 'Sportchampion' is a list before iterating
  if (json['Sportchampion'] != null && json['Sportchampion'] is List) {
    sportChampion = <SportChampion>[];
    json['Sportchampion'].forEach((v) {
      sportChampion!.add(SportChampion.fromJson(v));
    });
  }

  // Handling ImageInformation and SystemConfig
  imageInformation = json['ImageInformation'] != null
      ? ImageInformation.fromJson(json['ImageInformation'])
      : null;
  serial = json['serial'];
  systemConfig = json['systemconfig'] != null
      ? SystemConfig.fromJson(json['systemconfig'])
      : null;
}

*
*
* */
class FullStudentData {
  String? student;
  String? collegeAuthorized;
  List<FullDataPersonalInformation>? personalInformation;
  List<FullDataAcademicInformation>? academicInformation;
  List<FullDataCareerInformation>? careerInformation;
  List<FullDataCertificateCompetency>? certificateCompetency;
  List<SportChampion>? sportChampion;
  ImageInformation? imageInformation;
  int? serial;
  SystemConfig? systemConfig;

  FullStudentData(
      {this.student,
      this.collegeAuthorized,
      this.personalInformation,
      this.academicInformation,
      this.careerInformation,
      this.certificateCompetency,
      this.sportChampion,
      this.imageInformation,
      this.serial,this.systemConfig});

  // FullStudentData.fromJson(Map<String, dynamic> json) {
  //   student = json['student'];
  //   collegeAuthorized = json['College_Authorized'];
  //
  //   // Handle personalInformation as an object, not a list
  //   if (json['personalinformation'] != null) {
  //     personalInformation = <FullDataPersonalInformation>[];
  //     personalInformation!.add(
  //         FullDataPersonalInformation.fromJson(json['personalinformation']));
  //   }
  //
  //   // Ensure 'Academicinformation' is a list before iterating
  //   if (json['Academicinformation'] != null &&
  //       json['Academicinformation'] is List) {
  //     academicInformation = <FullDataAcademicInformation>[];
  //     json['Academicinformation'].forEach((v) {
  //       academicInformation!.add(FullDataAcademicInformation.fromJson(v));
  //     });
  //   }
  //
  //   // Ensure 'Careerinformation' is a list before iterating
  //   if (json['Careerinformation'] != null &&
  //       json['Careerinformation'] is List) {
  //     careerInformation = <FullDataCareerInformation>[];
  //     json['Careerinformation'].forEach((v) {
  //       careerInformation!.add(FullDataCareerInformation.fromJson(v));
  //     });
  //   }
  //
  //   // Ensure 'Certificatecompetency' is a list before iterating
  //   if (json['Certificatecompetency'] != null &&
  //       json['Certificatecompetency'] is List) {
  //     certificateCompetency = <FullDataCertificateCompetency>[];
  //     json['Certificatecompetency'].forEach((v) {
  //       certificateCompetency!.add(FullDataCertificateCompetency.fromJson(v));
  //     });
  //   }
  //
  //   // Ensure 'Sportchampion' is a list before iterating
  //   if (json['Sportchampion'] != null && json['Sportchampion'] is List) {
  //     sportChampion = <SportChampion>[];
  //     json['Sportchampion'].forEach((v) {
  //       sportChampion!.add(SportChampion.fromJson(v));
  //     });
  //   }
  //
  //   // Handling ImageInformation and SystemConfig
  //   imageInformation = json['ImageInformation'] != null
  //       ? ImageInformation.fromJson(json['ImageInformation'])
  //       : null;
  //   serial = json['serial'];
  //   systemConfig = json['systemconfig'] != null
  //       ? SystemConfig.fromJson(json['systemconfig'])
  //       : null;
  // }

  FullStudentData.fromJson(Map<String, dynamic> json) {
    student = json['student'];
    collegeAuthorized = json['College_Authorized'];
    if (json['personalinformation'] != null) {
      personalInformation = <FullDataPersonalInformation>[];
      json['personalinformation'].forEach((v) {
        personalInformation!.add(FullDataPersonalInformation.fromJson(v));
      });
    }
    if (json['Academicinformation'] != null) {
      academicInformation = <FullDataAcademicInformation>[];
      json['Academicinformation'].forEach((v) {
        academicInformation!.add(FullDataAcademicInformation.fromJson(v));
      });
    }
    if (json['Careerinformation'] != null) {
      careerInformation = <FullDataCareerInformation>[];
      json['Careerinformation'].forEach((v) {
        careerInformation!.add(FullDataCareerInformation.fromJson(v));
      });
    }
    if (json['Certificatecompetency'] != null) {
      certificateCompetency = <FullDataCertificateCompetency>[];
      json['Certificatecompetency'].forEach((v) {
        certificateCompetency!.add(FullDataCertificateCompetency.fromJson(v));
      });
    }
    if (json['Sportchampion'] != null) {
      sportChampion = <SportChampion>[];
      json['Sportchampion'].forEach((v) {
        sportChampion!.add(SportChampion.fromJson(v));
      });
    }
    imageInformation = json['ImageInformation'] != null
        ? ImageInformation.fromJson(json['ImageInformation'])
        : null;
    serial = json['serial'];
    systemConfig = json['systemconfig'] != null
        ? SystemConfig.fromJson(json['systemconfig'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student'] = student;
    data['College_Authorized'] = collegeAuthorized;
    if (personalInformation != null) {
      data['personalinformation'] =
          personalInformation!.map((v) => v.toJson()).toList();
    }
    if (academicInformation != null) {
      data['Academicinformation'] =
          academicInformation!.map((v) => v.toJson()).toList();
    }
    if (careerInformation != null) {
      data['Careerinformation'] =
          careerInformation!.map((v) => v.toJson()).toList();
    }
    if (certificateCompetency != null) {
      data['Certificatecompetency'] =
          certificateCompetency!.map((v) => v.toJson()).toList();
    }
    if (sportChampion != null) {
      data['Sportchampion'] = sportChampion!.map((v) => v.toJson()).toList();
    }
    if (imageInformation != null) {
      data['ImageInformation'] = imageInformation!.toJson();
    }
    data['serial'] = serial;
    if (systemConfig != null) {
      data['systemconfig'] = systemConfig!.toJson();
    }
    return data;
  }
}

class FullDataPersonalInformation {
  int? sPIId;
  String? studentUUID;
  String? firstName;
  String? secondName;
  String? thirdName;
  String? fourthName;
  String? firstMothersName;
  String? secondMothersName;
  String? thirdMothersName;
  String? nationality;
  String? dateOfBirth;
  String? gender;
  String? phone;
  int? isBlind;
  int? aCId;
  int? tSId;
  int? osId;
  int? scientificBackgroundId;
  int? specializationId;
  int? departmentId;
  int? isRegistrationUpgraded;
  String? address;

  List<Addresses>? addresses;
  List<TypeofStudy>? typeofStudy;
  List<AdmissionChannel>? admissionChannel;
  FullDataSubmission? submission;

  FullDataPersonalInformation({
    this.sPIId,
    this.studentUUID,
    this.firstName,
    this.secondName,
    this.thirdName,
    this.fourthName,
    this.firstMothersName,
    this.secondMothersName,
    this.thirdMothersName,
    this.nationality,
    this.dateOfBirth,
    this.gender,
    this.phone,
    this.isBlind,
    this.aCId,
    this.tSId,
    this.osId,
    this.scientificBackgroundId,
    this.specializationId,
    this.departmentId,
    this.isRegistrationUpgraded,
    this.address,
    this.addresses,
    this.typeofStudy,
    this.admissionChannel,
    this.submission,
  });

  FullDataPersonalInformation.fromJson(Map<String, dynamic> json) {
    sPIId = json['SPIId'];
    studentUUID = json['StudentUUID'];
    firstName = json['FirstName'];
    secondName = json['SecondName'];
    thirdName = json['ThirdName'];
    fourthName = json['FourthName'];
    firstMothersName = json['FirstMothersName'];
    secondMothersName = json['SecondMothersName'];
    thirdMothersName = json['ThirdMothersName'];
    nationality = json['Nationality'];
    dateOfBirth = json['DateOfBirth'];
    gender = json['Gender'];
    phone = json['Phone'];
    isBlind = json['IsBlind'];
    aCId = json['ACId'];
    tSId = json['TSId'];
    osId = json['osId'];
    scientificBackgroundId = json['ScientificBackgroundId'];
    specializationId = json['SpecializationId'];
    departmentId = json['DepartmentId'];
    isRegistrationUpgraded = json['IsRegistrationUpgraded'];
    address = json['address'];
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(Addresses.fromJson(v));
      });
    }
    if (json['typeofstudy'] != null) {
      typeofStudy = <TypeofStudy>[];
      json['typeofstudy'].forEach((v) {
        typeofStudy!.add(TypeofStudy.fromJson(v));
      });
    }
    if (json['admissionchannel'] != null) {
      admissionChannel = <AdmissionChannel>[];
      json['admissionchannel'].forEach((v) {
        admissionChannel!.add(AdmissionChannel.fromJson(v));
      });
      submission = json['submission'] != null
          ? FullDataSubmission.fromJson(json['submission'])
          : null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SPIId'] = sPIId;
    data['StudentUUID'] = studentUUID;
    data['FirstName'] = firstName;
    data['SecondName'] = secondName;
    data['ThirdName'] = thirdName;
    data['FourthName'] = fourthName;
    data['FirstMothersName'] = firstMothersName;
    data['SecondMothersName'] = secondMothersName;
    data['ThirdMothersName'] = thirdMothersName;
    data['Nationality'] = nationality;
    data['DateOfBirth'] = dateOfBirth;
    data['Gender'] = gender;
    data['Phone'] = phone;
    data['IsBlind'] = isBlind;
    data['ACId'] = aCId;
    data['TSId'] = tSId;
    data['osId'] = osId;
    data['ScientificBackgroundId'] = scientificBackgroundId;
    data['SpecializationId'] = specializationId;
    data['DepartmentId'] = departmentId;

    data['IsRegistrationUpgraded'] = isRegistrationUpgraded;
    data['address'] = address;
    if (addresses != null) {
      data['addresses'] = addresses!.map((v) => v.toJson()).toList();
    }
    if (typeofStudy != null) {
      data['typeofstudy'] = typeofStudy!.map((v) => v.toJson()).toList();
    }
    if (admissionChannel != null) {
      data['admissionchannel'] =
          admissionChannel!.map((v) => v.toJson()).toList();
    }
    if (submission != null) {
      data['submission'] = submission!.toJson();
    }
    return data;
  }

  static FullDataPersonalInformation fromStudentPersonalInformation(
      StudentPersonalInformation spi) {
    return FullDataPersonalInformation(
      sPIId: spi.sPIId,
      studentUUID: spi.studentUUID,
      firstName: spi.firstName,
      secondName: spi.secondName,
      thirdName: spi.thirdName,
      fourthName: spi.fourthName,
      firstMothersName: spi.firstMothersName,
      secondMothersName: spi.secondMothersName,
      thirdMothersName: spi.thirdMothersName,
      nationality: spi.nationality,
      dateOfBirth: spi.dateOfBirth,
      gender: spi.gender,
      phone: spi.Phone,
      isBlind: spi.isBlind != null ? (spi.isBlind! ? 1 : 0) : null,
      aCId: spi.aCId,
      tSId: spi.tSId,
      osId: spi.oSId,
      scientificBackgroundId: spi.scientificBackgroundId,
      addresses: spi.addresses,
    );
  }

// Method to get the full name
  String getFullName() {
    return [
      firstName,
      secondName,
      thirdName,
      fourthName
    ].where((name) => name != null && name.isNotEmpty).join(' ');
  }
}

class FullDataSubmission {
  int? id;
  int? aCId;
  int? tSId;
  int? osId;
  int? specializationId;
  int? scientificBackgroundId;
  int? departmentId;
  int? relativeId;
  String? studentUUID;
  List<Documents>? documents;

  FullDataSubmission({
    this.id,
    this.aCId,
    this.tSId,
    this.osId,
    this.specializationId,
    this.scientificBackgroundId,
    this.departmentId,
    this.relativeId,
    this.studentUUID,
    this.documents,
  });

  FullDataSubmission.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    aCId = json['ACId'];
    tSId = json['TSId'];
    osId = json['osId'];
    specializationId = json['SpecializationId'];
    scientificBackgroundId = json['ScientificBackgroundId'];
    departmentId = json['DepartmentId'];
    relativeId = json['RelativeId'];
    studentUUID = json['StudentUUID'];
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(Documents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ACId'] = aCId;
    data['TSId'] = tSId;
    data['osId'] = osId;
    data['SpecializationId'] = specializationId;
    data['ScientificBackgroundId'] = scientificBackgroundId;
    data['DepartmentId'] = departmentId;
    data['RelativeId'] = relativeId;
    data['StudentUUID'] = studentUUID;
    if (documents != null) {
      data['documents'] = documents!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  // Method to transfer data from Submission to FullDataSubmission
  static FullDataSubmission fromSubmission(Submission submission,
      {int? id, String? studentUUID}) {
    return FullDataSubmission(
      id: 1,
      // Optional field for FullDataSubmission
      aCId: submission.channelId,
      // Assuming ACId corresponds to channelId
      osId: submission.oSId,
      specializationId: submission.specializationId,
      scientificBackgroundId: submission.scientificBackgroundId,
      departmentId: submission.departmentId,
      relativeId: submission.relativeId,
      studentUUID: studentUUID,
      // Optional field for FullDataSubmission
      documents: submission.documents != null
          ? List<Documents>.from(submission.documents!)
          : null,
    );
  }
}

class AdmissionChannel {
  int? aCID;
  int? osId;
  int? channelsId;
  int? numberOfSeats;
  int? durationOfStudy;
  String? subjects;
  int? setOff;
  int? departmentId;
  int? relativeId;

  AdmissionChannel(
      {this.aCID,
      this.osId,
      this.channelsId,
      this.numberOfSeats,
      this.durationOfStudy,
      this.subjects,
      this.setOff,
      this.departmentId,
      this.relativeId});

  AdmissionChannel.fromJson(Map<String, dynamic> json) {
    aCID = json['ACID'];
    osId = json['osId'];
    channelsId = json['channelsId'];
    numberOfSeats = json['NumberOfSeats'];
    durationOfStudy = json['DurationOfStudy'];
    subjects = json['Subjects'];
    setOff = json['SetOff'];
    departmentId = json['DepartmentId'];
    relativeId = json['RelativeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ACID'] = aCID;
    data['osId'] = osId;
    data['channelsId'] = channelsId;
    data['NumberOfSeats'] = numberOfSeats;
    data['DurationOfStudy'] = durationOfStudy;
    data['Subjects'] = subjects;
    data['SetOff'] = setOff;
    data['DepartmentId'] = departmentId;
    data['RelativeId'] = relativeId;
    return data;
  }
}

class FullDataAcademicInformation {
  int? aIId;
  String? certificateIssuedBy;
  String? academicYear;
  double? average;
  dynamic specializationId;
  int? sequence;
  double? firstStudentAverage;
  int? isFirstStudent;
  int? firstQuarter;
  int? isDiplomaCompatible;
  int? isMasterWithinPeriod;
  int? certificateTypeId;
  int? nOBatch;

  dynamic universityId;
  dynamic collegesId;
  dynamic departmentId;
  String? studentUUID;
  List<Documents>? documents;

  FullDataAcademicInformation(
      {this.aIId,
      this.certificateIssuedBy,
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
      this.universityId,
      this.nOBatch,
      this.collegesId,
      this.departmentId,
      this.studentUUID,
      this.documents});

  FullDataAcademicInformation.fromJson(Map<String, dynamic> json) {
    aIId = json['AIId'];
    certificateIssuedBy = json['CertificateIssuedBy'];
    academicYear = json['AcademicYear'];
    average = json['Average'];
    specializationId = json['SpecializationId'];
    sequence = json['sequence'];
    firstStudentAverage = json['FirstStudentAverage'];
    isFirstStudent = json['IsFirstStudent'];
    firstQuarter = json['FirstQuarter'];
    isDiplomaCompatible = json['IsDiplomaCompatible'];
    isMasterWithinPeriod = json['IsMasterWithinPeriod'];
    certificateTypeId = json['CertificateTypeId'];
    universityId = json['UniversityId'];
    collegesId = json['CollegesId'];
    departmentId = json['DepartmentId'];
    nOBatch = json['NO_Batch'];
    studentUUID = json['StudentUUID'];
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(Documents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AIId'] = aIId;
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
    data['StudentUUID'] = studentUUID;
    if (documents != null) {
      data['documents'] = documents!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static FullDataAcademicInformation fromAcademicInformation(
      AcademicInformation info) {
    return FullDataAcademicInformation(
      certificateIssuedBy: info.certificateIssuedBy,
      academicYear: info.academicYear,
      average: info.average,
      specializationId: info.specializationId,
      sequence: info.sequence,
      nOBatch: info.nOBatch,
      firstStudentAverage: info.firstStudentAverage?.toDouble(),
      isFirstStudent: info.isFirstStudent,
      isDiplomaCompatible: info.isDiplomaCompatible,
      isMasterWithinPeriod: info.isMasterWithinPeriod,
      certificateTypeId: info.certificateTypeId,
      universityId: info.universityId,
      collegesId: info.collegesId,
      departmentId: info.departmentId,
      documents: info.documents,
    );
  }
}

// Function to convert a list of AcademicInformation to a list of FullDataAcademicInformation
List<FullDataAcademicInformation> convertAcademicInfoList(
    List<AcademicInformation>? academicList) {
  // Check if the list is null and handle it appropriately
  if (academicList == null) {
    // Return an empty list if the input is null
    return [];
  }
  // Convert the list if it is not null
  return academicList
      .map(FullDataAcademicInformation.fromAcademicInformation)
      .toList();
}

class FullDataCareerInformation {
  int? careerInformationId;
  int? typeConsentId;
  int? employmentStatusId;
  String? dateCommencement;
  int? ministryId;
  int? scientificTitleId;
  String? organizationName;
  int? universityService;
  String? studentUUID;
  List<Documents>? documents;

  FullDataCareerInformation(
      {this.careerInformationId,
      this.typeConsentId,
      this.employmentStatusId,
      this.dateCommencement,
      this.ministryId,
      this.scientificTitleId,
      this.organizationName,
      this.universityService,
      this.studentUUID,
      this.documents});

  FullDataCareerInformation.fromJson(Map<String, dynamic> json) {
    careerInformationId = json['CareerInformationId'];
    typeConsentId = json['TypeConsentId'];
    employmentStatusId = json['EmploymentStatusId'];
    dateCommencement = json['DateCommencement'];
    ministryId = json['MinistryId'];
    scientificTitleId = json['ScientificTitleId'];
    organizationName = json['OrganizationName'];
    universityService = json['UniversityService'];
    studentUUID = json['StudentUUID'];
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(Documents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CareerInformationId'] = careerInformationId;
    data['TypeConsentId'] = typeConsentId;
    data['EmploymentStatusId'] = employmentStatusId;
    data['DateCommencement'] = dateCommencement;
    data['MinistryId'] = ministryId;
    data['ScientificTitleId'] = scientificTitleId;
    data['OrganizationName'] = organizationName;
    data['UniversityService'] = universityService;
    data['StudentUUID'] = studentUUID;
    if (documents != null) {
      data['documents'] = documents!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  CareerInformation toCareerInformation() {
    return CareerInformation(
      typeConsentId: typeConsentId,
      employmentStatusId: employmentStatusId,
      dateCommencement: dateCommencement,
      ministryId: ministryId,
      scientificTitleId: scientificTitleId,
      organizationName: organizationName,
      universityService: universityService,
      documents: documents != null ? List<Documents>.from(documents!) : null,
    );
  }

  // Method to transfer data from CareerInformation to FullDataCareerInformation
  static FullDataCareerInformation fromCareerInformation(
      CareerInformation careerInfo,
      {int? careerInformationId,
      String? studentUUID}) {
    return FullDataCareerInformation(
      careerInformationId: careerInformationId,
      // Optional field for FullDataCareerInformation
      typeConsentId: careerInfo.typeConsentId,
      employmentStatusId: careerInfo.employmentStatusId,
      dateCommencement: careerInfo.dateCommencement,
      ministryId: careerInfo.ministryId,
      scientificTitleId: careerInfo.scientificTitleId,
      organizationName: careerInfo.organizationName,
      universityService: careerInfo.universityService,
      studentUUID: studentUUID,
      // Optional field for FullDataCareerInformation
      documents: careerInfo.documents != null
          ? List<Documents>.from(careerInfo.documents!)
          : null,
    );
  }
}

class FullDataCertificateCompetency {
  int? certificateCompetencyId;
  int? appreciation;
  int? certificateCompetencyTypeId;
  int? examCenterId;
  String? studentUUID;

  FullDataCertificateCompetency(
      {this.certificateCompetencyId,
      this.appreciation,
      this.certificateCompetencyTypeId,
      this.examCenterId,
      this.studentUUID});

  FullDataCertificateCompetency.fromJson(Map<String, dynamic> json) {
    certificateCompetencyId = json['CertificateCompetencyId'];
    appreciation = json['Appreciation'];
    certificateCompetencyTypeId = json['CertificateCompetencyTypeId'];
    examCenterId = json['ExamCenterId'];
    studentUUID = json['StudentUUID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CertificateCompetencyId'] = certificateCompetencyId;
    data['Appreciation'] = appreciation;
    data['CertificateCompetencyTypeId'] = certificateCompetencyTypeId;
    data['ExamCenterId'] = examCenterId;
    data['StudentUUID'] = studentUUID;
    return data;
  }

  Certificatecompetency toCertificateCompetency() {
    return Certificatecompetency(
      appreciation: appreciation?.toDouble(),
      certificateCompetencyTypeId: certificateCompetencyTypeId,
      examCenterId: examCenterId,
    );
  }
}

class SportChampion {
  int? sportChampionId;
  String? name;
  int? medalTypeId;
  String? studentUUID;
  Documents? documents;

  SportChampion(
      {this.sportChampionId,
      this.name,
      this.medalTypeId,
      this.studentUUID,
      this.documents});

  SportChampion.fromJson(Map<String, dynamic> json) {
    sportChampionId = json['SportChampionId'];
    name = json['Name'];
    medalTypeId = json['MedalTypeId'];
    studentUUID = json['StudentUUID'];
    documents = json['documents'] != null
        ? Documents.fromJson(json['documents'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SportChampionId'] = sportChampionId;
    data['Name'] = name;
    data['MedalTypeId'] = medalTypeId;
    data['StudentUUID'] = studentUUID;
    if (documents != null) {
      data['documents'] = documents!.toJson();
    }
    return data;
  }
}

class ImageInformation {
  String? personalPhoto;
  String? nationalCardFace1;
  String? nationalCardFace2;
  String? residenceCardFace1;
  String? residenceCardFace2;
  String? studyApproval;
  String? olympicCommitteeBook;
  String? iletsCertificate;
  String? arabicLanguageProficiencyCertificate;
  String? englishLanguageProficiencyCertificate;
  String? computerProficiencyCertificate;
  String? universityOrderRegardingObtainingAnAcademicTitle;
  String? universityOrderForDiploma;
  String? universityOrderForTheMastersDegree;
  String? firstStudentAverage;
  String? graduationDocument;
  String? politicalPrisoners;
  String? peopleWithSpecialNeeds;
  String? martyrsFoundation;

  ImageInformation(
      {this.personalPhoto,
      this.nationalCardFace1,
      this.nationalCardFace2,
      this.residenceCardFace1,
      this.residenceCardFace2,
      this.studyApproval,
      this.olympicCommitteeBook,
      this.iletsCertificate,
      this.arabicLanguageProficiencyCertificate,
      this.englishLanguageProficiencyCertificate,
      this.computerProficiencyCertificate,
      this.universityOrderRegardingObtainingAnAcademicTitle,
      this.universityOrderForDiploma,
      this.universityOrderForTheMastersDegree,
      this.firstStudentAverage,
      this.graduationDocument,
      this.politicalPrisoners,
      this.peopleWithSpecialNeeds,
      this.martyrsFoundation});

  ImageInformation.fromJson(Map<String, dynamic> json) {
    personalPhoto = json['personal_photo'];
    nationalCardFace1 = json['National_card_face_1'];
    nationalCardFace2 = json['National_card_face_2'];
    residenceCardFace1 = json['Residence_card_face_1'];
    residenceCardFace2 = json['Residence_card_face_2'];
    studyApproval = json['Study_approval'];
    olympicCommitteeBook = json['Olympic_Committee_book'];
    iletsCertificate = json['ilets_certificate'];
    arabicLanguageProficiencyCertificate =
        json['Arabic_language_proficiency_certificate'];
    englishLanguageProficiencyCertificate =
        json['English_language_proficiency_certificate'];
    computerProficiencyCertificate = json['Computer_proficiency_certificate'];
    universityOrderRegardingObtainingAnAcademicTitle =
        json['University_order_regarding_obtaining_an_academic_title'];
    universityOrderForDiploma = json['University_order_for_diploma'];
    universityOrderForTheMastersDegree =
        json['University_order_for_the_masters_degree'];
    firstStudentAverage = json['First_student_average'];
    graduationDocument = json['Graduation_document'];
    politicalPrisoners = json['Political_prisoners'];
    peopleWithSpecialNeeds = json['People_with_special_needs'];
    martyrsFoundation = json['Martyrs_Foundation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['personal_photo'] = personalPhoto;
    data['National_card_face_1'] = nationalCardFace1;
    data['National_card_face_2'] = nationalCardFace2;
    data['Residence_card_face_1'] = residenceCardFace1;
    data['Residence_card_face_2'] = residenceCardFace2;
    data['Study_approval'] = studyApproval;
    data['Olympic_Committee_book'] = olympicCommitteeBook;
    data['ilets_certificate'] = iletsCertificate;
    data['Arabic_language_proficiency_certificate'] =
        arabicLanguageProficiencyCertificate;
    data['English_language_proficiency_certificate'] =
        englishLanguageProficiencyCertificate;
    data['Computer_proficiency_certificate'] = computerProficiencyCertificate;
    data['University_order_regarding_obtaining_an_academic_title'] =
        universityOrderRegardingObtainingAnAcademicTitle;
    data['University_order_for_diploma'] = universityOrderForDiploma;
    data['University_order_for_the_masters_degree'] =
        universityOrderForTheMastersDegree;
    data['First_student_average'] = firstStudentAverage;
    data['Graduation_document'] = graduationDocument;
    data['Political_prisoners'] = politicalPrisoners;
    data['People_with_special_needs'] = peopleWithSpecialNeeds;
    data['Martyrs_Foundation'] = martyrsFoundation;
    return data;
  }
}

class SystemConfig {
  List<FormMessage>? formmessage;
  String? opensystem;

  SystemConfig({this.formmessage, this.opensystem});

  SystemConfig.fromJson(Map<String, dynamic> json) {
    if (json['Formmessage'] != null) {
      formmessage = <FormMessage>[];
      json['Formmessage'].forEach((v) {
        formmessage!.add(FormMessage.fromJson(v));
      });
    }
    opensystem = json['opensystem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (formmessage != null) {
      data['Formmessage'] = formmessage!.map((v) => v.toJson()).toList();
    }
    data['opensystem'] = opensystem;
    return data;
  }
}

class FormMessage {
  int? id;
  int? serial;
  String? audit;
  String? message;
  String? auditAt;
  String? approveAt;
  String? modifiedAt;

  FormMessage(
      {this.id,
      this.serial,
      this.audit,
      this.message,
      this.auditAt,
      this.approveAt,
      this.modifiedAt});

  FormMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serial = json['Serial'];
    audit = json['Audit'];
    message = json['Message'];
    auditAt = json['AuditAt'];
    approveAt = json['ApproveAt'];
    modifiedAt = json['ModifiedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['Serial'] = serial;
    data['Audit'] = audit;
    data['Message'] = message;
    data['AuditAt'] = auditAt;
    data['ApproveAt'] = approveAt;
    data['ModifiedAt'] = modifiedAt;
    return data;
  }
}
