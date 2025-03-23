class DataInformation {
  List<Ministry>? ministry;
  List<Typeconsentforstudys>? typeconsentforstudys;
  List<Scientifictitles>? scientifictitles;
  List<EmploymentstatusData>? employmentstatusData;

  DataInformation(
      {this.ministry,
        this.typeconsentforstudys,
        this.scientifictitles,
        this.employmentstatusData});

  DataInformation.fromJson(Map<String, dynamic> json) {
    if (json['Ministry'] != null) {
      ministry = <Ministry>[];
      json['Ministry'].forEach((v) {
        ministry!.add(Ministry.fromJson(v));
      });
    }
    if (json['Typeconsentforstudys'] != null) {
      typeconsentforstudys = <Typeconsentforstudys>[];
      json['Typeconsentforstudys'].forEach((v) {
        typeconsentforstudys!.add(Typeconsentforstudys.fromJson(v));
      });
    }
    if (json['Scientifictitles'] != null) {
      scientifictitles = <Scientifictitles>[];
      json['Scientifictitles'].forEach((v) {
        scientifictitles!.add(Scientifictitles.fromJson(v));
      });
    }
    if (json['EmploymentstatusData'] != null) {
      employmentstatusData = <EmploymentstatusData>[];
      json['EmploymentstatusData'].forEach((v) {
        employmentstatusData!.add(EmploymentstatusData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ministry != null) {
      data['Ministry'] = ministry!.map((v) => v.toJson()).toList();
    }
    if (typeconsentforstudys != null) {
      data['Typeconsentforstudys'] =
          typeconsentforstudys!.map((v) => v.toJson()).toList();
    }
    if (scientifictitles != null) {
      data['Scientifictitles'] =
          scientifictitles!.map((v) => v.toJson()).toList();
    }
    if (employmentstatusData != null) {
      data['EmploymentstatusData'] =
          employmentstatusData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ministry {
  int? ministryId;
  String? name;
  int? heirghEduSevice;

  Ministry({this.ministryId, this.name});

  Ministry.fromJson(Map<String, dynamic> json) {
    ministryId = json['MinistryId'];
    name = json['Name'];
    heirghEduSevice = json['heirghEduSevice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MinistryId'] = ministryId;
    data['Name'] = name;
    data['heirghEduSevice'] = heirghEduSevice;
    return data;
  }
}

class Typeconsentforstudys {
  int? typeConsentId;
  String? typeConsentName;
  String? infromation;

  Typeconsentforstudys(
      {this.typeConsentId, this.typeConsentName, this.infromation});

  Typeconsentforstudys.fromJson(Map<String, dynamic> json) {
    typeConsentId = json['TypeConsentId'];
    typeConsentName = json['TypeConsentName'];
    infromation = json['Infromation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TypeConsentId'] = typeConsentId;
    data['TypeConsentName'] = typeConsentName;
    data['Infromation'] = infromation;
    return data;
  }
}

class Scientifictitles {
  int? scientificTitleId;
  String? name;

  Scientifictitles({this.scientificTitleId, this.name});

  Scientifictitles.fromJson(Map<String, dynamic> json) {
    scientificTitleId = json['ScientificTitleId'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ScientificTitleId'] = scientificTitleId;
    data['Name'] = name;
    return data;
  }
}

class EmploymentstatusData {
  int? employmentStatusId;
  String? statusName;

  EmploymentstatusData({this.employmentStatusId, this.statusName});

  EmploymentstatusData.fromJson(Map<String, dynamic> json) {
    employmentStatusId = json['EmploymentStatusId'];
    statusName = json['StatusName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EmploymentStatusId'] = employmentStatusId;
    data['StatusName'] = statusName;
    return data;
  }
}
