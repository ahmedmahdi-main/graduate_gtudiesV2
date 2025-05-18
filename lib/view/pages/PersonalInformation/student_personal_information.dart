import '../../../Models/addresses.dart';

class StudentPersonalInformation {
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
  bool? isBlind;
  int? aCId;
  int? tSId;
  int? oSId;
  int? scientificBackgroundId;
  String? Phone;
  List<Addresses>? addresses;

  StudentPersonalInformation(
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
      this.isBlind,
      this.aCId,
      this.tSId,
      this.oSId,
      this.scientificBackgroundId,
      //this.specializationId,
      this.Phone,
      this.addresses});

  StudentPersonalInformation.fromJson(Map<String, dynamic> json) {
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
    isBlind = json['IsBlind'];
    aCId = json['ACId'];
    tSId = json['TSId'];
    oSId = json['Osid'];
    scientificBackgroundId = json['ScientificBackgroundId'];
    //specializationId = json['SpecializationId'];
    Phone = json['Phone'];
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(Addresses.fromJson(v));
      });
    }
  }

  List<Map<String, dynamic>> toJson() {
    final Map<String, dynamic> data = {};
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
    data['IsBlind'] = isBlind;
    data['ACId'] = aCId;
    data['TSId'] = tSId;
    data['Osid'] = oSId;
    data['ScientificBackgroundId'] = scientificBackgroundId;
    // data['SpecializationId'] = specializationId;
    data['Phone'] = Phone;
    if (addresses != null) {
      data['addresses'] = addresses!.map((v) => v.toJson()).toList();
    }
    return [data];
  }
}
