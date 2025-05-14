enum CertificateCompetencyTypes {
  certificateCompetencyComputer,
  certificateCompetencyEnglish,
  certificateCompetencyArabic,
  certificateCompetencyIlits,
}

extension MyCertificateTypeExtensionId on CertificateCompetencyTypes {
  int get id {
    switch (this) {
      case CertificateCompetencyTypes.certificateCompetencyComputer:
        return 1;
      case CertificateCompetencyTypes.certificateCompetencyEnglish:
        return 2;
      case CertificateCompetencyTypes.certificateCompetencyArabic:
        return 3;
      case CertificateCompetencyTypes.certificateCompetencyIlits:
        return 4;
    }
  }

  String get name {
    switch (this) {
      case CertificateCompetencyTypes.certificateCompetencyComputer:
        return 'كفائة الحاسوب';
      case CertificateCompetencyTypes.certificateCompetencyEnglish:
        return 'الامتحان الوطني';
      case CertificateCompetencyTypes.certificateCompetencyArabic:
        return 'اللغة العربية';
      case CertificateCompetencyTypes.certificateCompetencyIlits:
        return 'IELTS';
    }
  }
}
