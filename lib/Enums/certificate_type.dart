enum CertificateType {
  diploma,
  bachelors,
  higherDiploma,
  masters,
  phD,
}

extension MyCertificateTypeExtensionId on CertificateType {
  int get id {
    switch (this) {
      case CertificateType.diploma:
        return 1;
      case CertificateType.bachelors:
        return 2;
        case CertificateType.higherDiploma:
        return 3;
      case CertificateType.masters:
        return 4;
      case CertificateType.phD:
        return 5;
      default:
        throw 0;
    }
  }

  String get name {
    switch (this) {
      case CertificateType.diploma:
        return 'دبلوم';
      case CertificateType.bachelors:
        return 'بكالوريوس';
      case CertificateType.higherDiploma:
        return 'دبلوم عالي';
      case CertificateType.masters:
        return 'ماجستير';
      case CertificateType.phD:
        return 'دكتوراه';
      default:
        throw Exception("Unknown enum value");
    }
  }
}
