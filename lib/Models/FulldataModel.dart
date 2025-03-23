class FullDataController {
  Student? student;
  List<PersonalInformation>? personalInformation;
  List<AcademicInformation>? academicInformation;
  List<CareerInformation>? careerInformation;
  List<CertificateCompetency>? certificateCompetency;
  List<SportChampion>? sportChampion;
  ImageInformation? imageInformation;

  FullDataController(
      {this.student,
        this.personalInformation,
        this.academicInformation,
        this.careerInformation,
        this.certificateCompetency,
        this.sportChampion,
        this.imageInformation});

  FullDataController.fromJson(Map<String, dynamic> json) {
    student =
    json['student'] != null ? Student.fromJson(json['student']) : null;
    if (json['personalinformation'] != null) {
      personalInformation = <PersonalInformation>[];
      json['personalinformation'].forEach((v) {
        personalInformation!.add(PersonalInformation.fromJson(v));
      });
    }
    if (json['Academicinformation'] != null) {
      academicInformation = <AcademicInformation>[];
      json['Academicinformation'].forEach((v) {
        academicInformation!.add(AcademicInformation.fromJson(v));
      });
    }
    if (json['Careerinformation'] != null) {
      careerInformation = <CareerInformation>[];
      json['Careerinformation'].forEach((v) {
        careerInformation!.add(CareerInformation.fromJson(v));
      });
    }
    if (json['Certificatecompetency'] != null) {
      certificateCompetency = <CertificateCompetency>[];
      json['Certificatecompetency'].forEach((v) {
        certificateCompetency!.add(CertificateCompetency.fromJson(v));
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (student != null) {
      data['student'] = student!.toJson();
    }
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
      data['Sportchampion'] =
          sportChampion!.map((v) => v.toJson()).toList();
    }
    if (imageInformation != null) {
      data['ImageInformation'] = imageInformation!.toJson();
    }
    return data;
  }
}

class Student {
  int? id;
  String? studentuuid;
  String? fullName;
  String? email;

  Student({this.id, this.studentuuid, this.fullName, this.email});

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentuuid = json['studentuuid'];
    fullName = json['full_name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['studentuuid'] = studentuuid;
    data['full_name'] = fullName;
    data['email'] = email;
    return data;
  }
}

class PersonalInformation {
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
  int? scientificBackgroundId;
  int? specializationId;
  int? isRegistrationUpgraded;
  String? address;
  List<Addresses>? addresses;
  List<Typeofstudy>? typeofstudy;
  List<Admissionchannel>? admissionchannel;

  PersonalInformation(
      {this.sPIId,
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
        this.scientificBackgroundId,
        this.specializationId,
        this.isRegistrationUpgraded,
        this.address,
        this.addresses,
        this.typeofstudy,
        this.admissionchannel});

  PersonalInformation.fromJson(Map<String, dynamic> json) {
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
    scientificBackgroundId = json['ScientificBackgroundId'];
    specializationId = json['SpecializationId'];
    isRegistrationUpgraded = json['IsRegistrationUpgraded'];
    address = json['address'];
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(Addresses.fromJson(v));
      });
    }
    if (json['typeofstudy'] != null) {
      typeofstudy = <Typeofstudy>[];
      json['typeofstudy'].forEach((v) {
        typeofstudy!.add(Typeofstudy.fromJson(v));
      });
    }
    if (json['admissionchannel'] != null) {
      admissionchannel = <Admissionchannel>[];
      json['admissionchannel'].forEach((v) {
        admissionchannel!.add(Admissionchannel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    data['ScientificBackgroundId'] = scientificBackgroundId;
    data['SpecializationId'] = specializationId;
    data['IsRegistrationUpgraded'] = isRegistrationUpgraded;
    data['address'] = address;
    if (addresses != null) {
      data['addresses'] = addresses!.map((v) => v.toJson()).toList();
    }
    if (typeofstudy != null) {
      data['typeofstudy'] = typeofstudy!.map((v) => v.toJson()).toList();
    }
    if (admissionchannel != null) {
      data['admissionchannel'] =
          admissionchannel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Addresses {
  int? addressId;
  int? sPIId;
  String? state;
  String? district;
  String? neighborhood;
  String? mahalla;
  String? alley;
  int? houseNumber;

  Addresses(
      {this.addressId,
        this.sPIId,
        this.state,
        this.district,
        this.neighborhood,
        this.mahalla,
        this.alley,
        this.houseNumber});

  Addresses.fromJson(Map<String, dynamic> json) {
    addressId = json['AddressId'];
    sPIId = json['SPIId'];
    state = json['State'];
    district = json['District'];
    neighborhood = json['Neighborhood'];
    mahalla = json['Mahalla'];
    alley = json['Alley'];
    houseNumber = json['HouseNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['AddressId'] = addressId;
    data['SPIId'] = sPIId;
    data['State'] = state;
    data['District'] = district;
    data['Neighborhood'] = neighborhood;
    data['Mahalla'] = mahalla;
    data['Alley'] = alley;
    data['HouseNumber'] = houseNumber;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['TSid'] = tSid;
    data['TypeofStudyName'] = typeofStudyName;
    return data;
  }
}

class Admissionchannel {
  int? aCID;
  int? channelsId;
  int? numberOfSeats;
  int? durationOfStudy;
  String? subjects;
  int? setOff;
  int? departmentId;
  int? relativeId;

  Admissionchannel(
      {this.aCID,
        this.channelsId,
        this.numberOfSeats,
        this.durationOfStudy,
        this.subjects,
        this.setOff,
        this.departmentId,
        this.relativeId});

  Admissionchannel.fromJson(Map<String, dynamic> json) {
    aCID = json['ACID'];
    channelsId = json['channelsId'];
    numberOfSeats = json['NumberOfSeats'];
    durationOfStudy = json['DurationOfStudy'];
    subjects = json['Subjects'];
    setOff = json['SetOff'];
    departmentId = json['DepartmentId'];
    relativeId = json['RelativeId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ACID'] = aCID;
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

class AcademicInformation {
  int? aIId;
  String? certificateIssuedBy;
  String? academicYear;
  int? average;
  int? specializationId;
  int? sequence;
  int? firstStudentAverage;
  int? isFirstStudent;
  int? isDiplomaCompatible;
  int? isMasterWithinPeriod;
  int? certificateTypeId;
  int? universityId;
  int? collegesId;
  int? departmentId;
  String? studentUUID;
  List<Documents>? documents;

  AcademicInformation(
      {this.aIId,
        this.certificateIssuedBy,
        this.academicYear,
        this.average,
        this.specializationId,
        this.sequence,
        this.firstStudentAverage,
        this.isFirstStudent,
        this.isDiplomaCompatible,
        this.isMasterWithinPeriod,
        this.certificateTypeId,
        this.universityId,
        this.collegesId,
        this.departmentId,
        this.studentUUID,
        this.documents});

  AcademicInformation.fromJson(Map<String, dynamic> json) {
    aIId = json['AIId'];
    certificateIssuedBy = json['CertificateIssuedBy'];
    academicYear = json['AcademicYear'];
    average = json['Average'];
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
    studentUUID = json['StudentUUID'];
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(Documents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['AIId'] = aIId;
    data['CertificateIssuedBy'] = certificateIssuedBy;
    data['AcademicYear'] = academicYear;
    data['Average'] = average;
    data['SpecializationId'] = specializationId;
    data['sequence'] = sequence;
    data['FirstStudentAverage'] = firstStudentAverage;
    data['IsFirstStudent'] = isFirstStudent;
    data['IsDiplomaCompatible'] = isDiplomaCompatible;
    data['IsMasterWithinPeriod'] = isMasterWithinPeriod;
    data['CertificateTypeId'] = certificateTypeId;
    data['UniversityId'] = universityId;
    data['CollegesId'] = collegesId;
    data['DepartmentId'] = departmentId;
    data['StudentUUID'] = studentUUID;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['DocumentsId'] = documentsId;
    data['DocumentsNumber'] = documentsNumber;
    data['DocumentsDate'] = documentsDate;
    data['DocumentsTypeId'] = documentsTypeId;
    data['AIId'] = aIId;
    data['CareerInformationId'] = careerInformationId;
    data['ACID'] = aCID;
    data['SportChampionId'] = sportChampionId;
    return data;
  }
}

class CareerInformation {
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

  CareerInformation(
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

  CareerInformation.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
}


class CertificateCompetency {
  int? certificateCompetencyId;
  int? appreciation;
  int? certificateCompetencyTypeId;
  int? examCenterId;
  String? studentUUID;

  CertificateCompetency(
      {this.certificateCompetencyId,
        this.appreciation,
        this.certificateCompetencyTypeId,
        this.examCenterId,
        this.studentUUID});

  CertificateCompetency.fromJson(Map<String, dynamic> json) {
    certificateCompetencyId = json['CertificateCompetencyId'];
    appreciation = json['Appreciation'];
    certificateCompetencyTypeId = json['CertificateCompetencyTypeId'];
    examCenterId = json['ExamCenterId'];
    studentUUID = json['StudentUUID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['CertificateCompetencyId'] = certificateCompetencyId;
    data['Appreciation'] = appreciation;
    data['CertificateCompetencyTypeId'] = certificateCompetencyTypeId;
    data['ExamCenterId'] = examCenterId;
    data['StudentUUID'] = studentUUID;
    return data;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    data['Computer_proficiency_certificate'] =
        computerProficiencyCertificate;
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
