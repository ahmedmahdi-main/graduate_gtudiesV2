class SuperData {
  List<Universities>? universities;
  List<Colleges>? colleges;
  List<Department>? department;
  List<Scientificbackgrounds>? scientificBackgrounds;
  List<Specializations>? specializations;
  List<Subspecializations>? subSpecializations;
  List<DocumentsTypes>? documentsTypes;
  List<Admissionchannel>? admissionchannel;
  List<Relativerelations>? relativeRelations;
  List<TypeofStudies>? typeofStudies;
  List<ChannelsData>? channelsData;
  List<OpenStudies>? openStudies;
  List<String>? years;
  List<String>? countries;
  List<CertificateCompetencyTypeData>? certificateCompetencyTypeData;
  List<Medaltype>? medalTypes;

  SuperData(
      {this.universities,
      this.colleges,
      this.department,
      this.scientificBackgrounds,
      this.specializations,
      this.subSpecializations,
      this.documentsTypes,
      this.admissionchannel,
      this.relativeRelations,
      this.typeofStudies,
      this.channelsData,
      this.openStudies,
      this.years,
      this.medalTypes,
      this.countries});

  SuperData.fromJson(Map<String, dynamic> json) {
    if (json['universities'] != null) {
      universities = <Universities>[];
      json['universities'].forEach((v) {
        universities!.add(Universities.fromJson(v));
      });
    }

    if (json['Medaltype'] != null) {
      medalTypes = <Medaltype>[];
      json['Medaltype'].forEach((v) {
        medalTypes!.add(Medaltype.fromJson(v));
      });
    }
    if (json['colleges'] != null) {
      colleges = <Colleges>[];
      json['colleges'].forEach((v) {
        colleges!.add(Colleges.fromJson(v));
      });
    }
    if (json['Department'] != null) {
      department = <Department>[];
      json['Department'].forEach((v) {
        department!.add(Department.fromJson(v));
      });
    }
    if (json['Scientificbackgrounds'] != null) {
      scientificBackgrounds = <Scientificbackgrounds>[];
      json['Scientificbackgrounds'].forEach((v) {
        scientificBackgrounds!.add(Scientificbackgrounds.fromJson(v));
      });
    }
    if (json['Specializations'] != null) {
      specializations = <Specializations>[];
      json['Specializations'].forEach((v) {
        specializations!.add(Specializations.fromJson(v));
      });
    }
    if (json['Subspecializations'] != null) {
      subSpecializations = <Subspecializations>[];
      json['Subspecializations'].forEach((v) {
        subSpecializations!.add(Subspecializations.fromJson(v));
      });
    }
    if (json['Documentstypes'] != null) {
      documentsTypes = <DocumentsTypes>[];
      json['Documentstypes'].forEach((v) {
        documentsTypes!.add(DocumentsTypes.fromJson(v));
      });
    }
    if (json['Admissionchannel'] != null) {
      admissionchannel = <Admissionchannel>[];
      json['Admissionchannel'].forEach((v) {
        admissionchannel!.add(Admissionchannel.fromJson(v));
      });
    }
    if (json['Relativerelations'] != null) {
      relativeRelations = <Relativerelations>[];
      json['Relativerelations'].forEach((v) {
        relativeRelations!.add(Relativerelations.fromJson(v));
      });
    }
    if (json['typeofStudies'] != null) {
      typeofStudies = <TypeofStudies>[];
      json['typeofStudies'].forEach((v) {
        typeofStudies!.add(TypeofStudies.fromJson(v));
      });
    }
    if (json['ChannelsData'] != null) {
      channelsData = <ChannelsData>[];

      json['ChannelsData'].forEach((v) {
        channelsData!.add(ChannelsData.fromJson(v));
      });
    }
    if (json['Openstudies'] != null) {
      openStudies = <OpenStudies>[];
      json['Openstudies'].forEach((v) {
        openStudies!.add(OpenStudies.fromJson(v));
      });
    }
    if (json['CertificateCompetencyTypeData'] != null) {
      certificateCompetencyTypeData = <CertificateCompetencyTypeData>[];
      json['CertificateCompetencyTypeData'].forEach((v) {
        certificateCompetencyTypeData!
            .add(CertificateCompetencyTypeData.fromJson(v));
      });
    }
    years = json['years'].cast<String>();
    countries = json['Countries'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (certificateCompetencyTypeData != null) {
      data['CertificateCompetencyTypeData'] =
          certificateCompetencyTypeData!.map((v) => v.toJson()).toList();
    }

    if (medalTypes != null) {
      data['Medaltype'] = medalTypes!.map((v) => v.toJson()).toList();
    }
    if (universities != null) {
      data['universities'] = universities!.map((v) => v.toJson()).toList();
    }
    if (colleges != null) {
      data['colleges'] = colleges!.map((v) => v.toJson()).toList();
    }
    if (department != null) {
      data['Department'] = department!.map((v) => v.toJson()).toList();
    }
    if (scientificBackgrounds != null) {
      data['Scientificbackgrounds'] =
          scientificBackgrounds!.map((v) => v.toJson()).toList();
    }
    if (specializations != null) {
      data['Specializations'] =
          specializations!.map((v) => v.toJson()).toList();
    }
    if (subSpecializations != null) {
      data['Subspecializations'] =
          subSpecializations!.map((v) => v.toJson()).toList();
    }
    if (documentsTypes != null) {
      data['Documentstypes'] = documentsTypes!.map((v) => v.toJson()).toList();
    }
    if (admissionchannel != null) {
      data['Admissionchannel'] =
          admissionchannel!.map((v) => v.toJson()).toList();
    }
    if (relativeRelations != null) {
      data['Relativerelations'] =
          relativeRelations!.map((v) => v.toJson()).toList();
    }
    if (typeofStudies != null) {
      data['typeofStudies'] = typeofStudies!.map((v) => v.toJson()).toList();
    }
    if (channelsData != null) {
      data['ChannelsData'] = channelsData!.map((v) => v.toJson()).toList();
    }
    if (openStudies != null) {
      data['Openstudies'] = openStudies!.map((v) => v.toJson()).toList();
    }
    data['years'] = years;
    data['Countries'] = countries;
    return data;
  }
}

class Universities {
  int? universityId;
  String? universityName;
  String? country;
  int? status;
  int? isActive;

  Universities(
      {this.universityId,
      this.universityName,
      this.country,
      this.status,
      this.isActive});

  Universities.fromJson(Map<String, dynamic> json) {
    universityId = json['UniversityId'];
    universityName = json['UniversityName'];
    country = json['country'];
    status = json['status'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UniversityId'] = universityId;
    data['UniversityName'] = universityName;
    data['country'] = country;
    data['status'] = status;
    data['isActive'] = isActive;
    return data;
  }
}

class Colleges {
  int? collegesId;
  String? collegesName;
  int? universityId;
  int? status;
  String? pathImg;

  Colleges(
      {this.collegesId,
      this.collegesName,
      this.universityId,
      this.status,
      this.pathImg});

  Colleges.fromJson(Map<String, dynamic> json) {
    collegesId = json['CollegesId'];
    collegesName = json['CollegesName'];
    universityId = json['UniversityId'];
    status = json['status'];
    pathImg = json['path_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CollegesId'] = collegesId;
    data['CollegesName'] = collegesName;
    data['UniversityId'] = universityId;
    data['status'] = status;
    data['path_img'] = pathImg;
    return data;
  }
}

class Department {
  int? universityId;
  int? collegesId;
  int? departmentId;
  String? departmentName;
  String? pathImg;

  Department(
      {this.universityId,
      this.collegesId,
      this.departmentId,
      this.departmentName,
      this.pathImg});

  Department.fromJson(Map<String, dynamic> json) {
    universityId = json['UniversityId'];
    collegesId = json['CollegesId'];
    departmentId = json['DepartmentId'];
    departmentName = json['DepartmentName'];
    pathImg = json['path_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UniversityId'] = universityId;
    data['CollegesId'] = collegesId;
    data['DepartmentId'] = departmentId;
    data['DepartmentName'] = departmentName;
    data['path_img'] = pathImg;
    return data;
  }
}

class Scientificbackgrounds {
  int? universityId;
  int? collegesId;
  int? departmentId;
  int? scientificbackgroundId;
  String? scientificbackgroundName;
  int? typeofstudy;

  Scientificbackgrounds(
      {this.universityId,
      this.collegesId,
      this.departmentId,
      this.scientificbackgroundId,
      this.scientificbackgroundName,
      this.typeofstudy});

  Scientificbackgrounds.fromJson(Map<String, dynamic> json) {
    universityId = json['UniversityId'];
    collegesId = json['CollegesId'];
    departmentId = json['DepartmentId'];
    scientificbackgroundId = json['ScientificbackgroundId'];
    scientificbackgroundName = json['ScientificbackgroundName'];
    typeofstudy = json['typeofstudy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UniversityId'] = universityId;
    data['CollegesId'] = collegesId;
    data['DepartmentId'] = departmentId;
    data['ScientificbackgroundId'] = scientificbackgroundId;
    data['ScientificbackgroundName'] = scientificbackgroundName;
    data['typeofstudy'] = typeofstudy;
    return data;
  }
}

class Specializations {
  int? universityId;
  int? collegesId;
  int? departmentId;
  int? specializationId;
  String? specializationName;
  String? typeofstudy;

  Specializations(
      {this.universityId,
      this.collegesId,
      this.departmentId,
      this.specializationId,
      this.specializationName,
      this.typeofstudy});

  Specializations.fromJson(Map<String, dynamic> json) {
    universityId = json['UniversityId'];
    collegesId = json['CollegesId'];
    departmentId = json['DepartmentId'];
    specializationId = json['SpecializationId'];
    specializationName = json['SpecializationName'];
    typeofstudy = json['typeofstudy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UniversityId'] = universityId;
    data['CollegesId'] = collegesId;
    data['DepartmentId'] = departmentId;
    data['SpecializationId'] = specializationId;
    data['SpecializationName'] = specializationName;
    data['typeofstudy'] = typeofstudy;
    return data;
  }
}

class Subspecializations {
  int? universityId;
  int? collegesId;
  int? departmentId;
  int? specializationId;
  int? subspecializationId;
  String? subspecializationName;

  Subspecializations(
      {this.universityId,
      this.collegesId,
      this.departmentId,
      this.specializationId,
      this.subspecializationId,
      this.subspecializationName});

  Subspecializations.fromJson(Map<String, dynamic> json) {
    universityId = json['UniversityId'];
    collegesId = json['CollegesId'];
    departmentId = json['DepartmentId'];
    specializationId = json['SpecializationId'];
    subspecializationId = json['SubspecializationId'];
    subspecializationName = json['SubspecializationName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UniversityId'] = universityId;
    data['CollegesId'] = collegesId;
    data['DepartmentId'] = departmentId;
    data['SpecializationId'] = specializationId;
    data['SubspecializationId'] = subspecializationId;
    data['SubspecializationName'] = subspecializationName;
    return data;
  }
}

class DocumentsTypes {
  int? documentsTypeId;
  String? documentsTypeName;

  DocumentsTypes({this.documentsTypeId, this.documentsTypeName});

  DocumentsTypes.fromJson(Map<String, dynamic> json) {
    documentsTypeId = json['DocumentsTypeId'];
    documentsTypeName = json['DocumentsTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DocumentsTypeId'] = documentsTypeId;
    data['DocumentsTypeName'] = documentsTypeName;
    return data;
  }
}

class Admissionchannel {
  int? aCID;
  int? osId;
  int? channelsId;
  int? numberOfSeats;
  int? deleted;

  Admissionchannel(
      {this.aCID,
      this.osId,
      this.channelsId,
      this.numberOfSeats,
      this.deleted});

  Admissionchannel.fromJson(Map<String, dynamic> json) {
    aCID = json['ACID'];
    osId = json['osId'];
    channelsId = json['channelsId'];
    numberOfSeats = json['NumberOfSeats'];
    deleted = json['deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ACID'] = aCID;
    data['osId'] = osId;
    data['channelsId'] = channelsId;
    data['NumberOfSeats'] = numberOfSeats;
    data['deleted'] = deleted;
    return data;
  }
}

class Relativerelations {
  int? relativeId;
  String? namerelation;
  int? effict;

  Relativerelations({this.relativeId, this.namerelation, this.effict});

  Relativerelations.fromJson(Map<String, dynamic> json) {
    relativeId = json['RelativeId'];
    namerelation = json['namerelation'];
    effict = json['effict'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['RelativeId'] = relativeId;
    data['namerelation'] = namerelation;
    data['effict'] = effict;
    return data;
  }
}

class TypeofStudies {
  int? tSid;
  String? name;

  TypeofStudies({this.tSid, this.name});

  TypeofStudies.fromJson(Map<String, dynamic> json) {
    tSid = json['TSid'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TSid'] = tSid;
    data['name'] = name;
    return data;
  }
}

class ChannelsData {
  int? channelId;
  String? name;
  int? state;
  int? status;
  List<ChannelsDataDocumentsTypes>? documentstypes;

  ChannelsData(
      {this.channelId,
      this.name,
      this.state,
      this.status,
      this.documentstypes});

  ChannelsData.fromJson(Map<String, dynamic> json) {
    channelId = json['Channelid'];
    name = json['name'];
    state = json['state'];
    status = json['status'];
    if (json['documentstypes'] != null) {
      documentstypes = <ChannelsDataDocumentsTypes>[];
      json['documentstypes'].forEach((v) {
        documentstypes!.add(ChannelsDataDocumentsTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Channelid'] = channelId;
    data['name'] = name;
    data['state'] = state;
    data['status'] = status;
    if (documentstypes != null) {
      data['documentstypes'] = documentstypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChannelsDataDocumentsTypes {
  int? id;
  String? name;

  ChannelsDataDocumentsTypes({this.id, this.name});

  ChannelsDataDocumentsTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class OpenStudies {
  int? osId;
  int? departmentId;
  int? typeofstudy;
  int? durationOfStudy;
  String? subjects;

  OpenStudies(
      {this.osId,
      this.departmentId,
      this.typeofstudy,
      this.durationOfStudy,
      this.subjects});

  OpenStudies.fromJson(Map<String, dynamic> json) {
    osId = json['osId'];
    departmentId = json['DepartmentId'];
    typeofstudy = json['typeofstudy'];
    durationOfStudy = json['DurationOfStudy'];
    subjects = json['subjects'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['osId'] = osId;
    data['DepartmentId'] = departmentId;
    data['typeofstudy'] = typeofstudy;
    data['DurationOfStudy'] = durationOfStudy;
    data['subjects'] = subjects;
    return data;
  }
}

class OpenStudy {
  int? osId;
  int? departmentId;
  String? typeofstudy;
  int? durationOfStudy;
  String? subjects;

  OpenStudy(
      {this.osId,
      this.departmentId,
      this.typeofstudy,
      this.durationOfStudy,
      this.subjects});

  OpenStudy.fromJson(Map<String, dynamic> json) {
    osId = json['osId'];
    departmentId = json['DepartmentId'];
    typeofstudy = json['typeofstudy'];
    durationOfStudy = json['DurationOfStudy'];
    subjects = json['subjects'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['osId'] = osId;
    data['DepartmentId'] = departmentId;
    data['typeofstudy'] = typeofstudy;
    data['DurationOfStudy'] = durationOfStudy;
    data['subjects'] = subjects;
    return data;
  }
}

class CertificateCompetencyTypeData {
  int? certificateCompetencyTypeId;
  String? name;

  CertificateCompetencyTypeData({this.certificateCompetencyTypeId, this.name});

  CertificateCompetencyTypeData.fromJson(Map<String, dynamic> json) {
    certificateCompetencyTypeId = json['CertificateCompetencyTypeId'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CertificateCompetencyTypeId'] = certificateCompetencyTypeId;
    data['name'] = name;
    return data;
  }
}

class Medaltype {
  int? medalTypeId;
  String? name;

  Medaltype({this.medalTypeId, this.name});

  Medaltype.fromJson(Map<String, dynamic> json) {
    medalTypeId = json['MedalTypeId'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MedalTypeId'] = medalTypeId;
    data['Name'] = name;
    return data;
  }
}
