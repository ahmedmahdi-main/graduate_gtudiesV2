enum DocumentsType {
  bachelorDegreeCertificate,
  firstStudentAverageConfirmationLetter,
  diplomaOrder,
  masterDegreeOrder,
  noObjectionLetter,
  promotionOrder,
  olympicCommitteeLetter,
  martyrsFoundation, // Adding the id 14 from your JSON
  cooperationMechanismBook // Adding the id 15 from your JSON
}

extension DocumentsTypeExtension on DocumentsType {
  int get id {
    switch (this) {
      case DocumentsType.bachelorDegreeCertificate:
        return 1;
      case DocumentsType.firstStudentAverageConfirmationLetter:
        return 2;
      case DocumentsType.diplomaOrder:
        return 3;
      case DocumentsType.masterDegreeOrder:
        return 4;
      case DocumentsType.noObjectionLetter:
        return 5;
      case DocumentsType.promotionOrder:
        return 6;
      case DocumentsType.olympicCommitteeLetter:
        return 7;
      case DocumentsType.martyrsFoundation:
        return 14;
      case DocumentsType.cooperationMechanismBook:
        return 15;
      default:
        throw Exception("Unknown enum value");
    }
  }

  String get name {
    switch (this) {
      case DocumentsType.bachelorDegreeCertificate:
        return 'وثيقة بكالوريوس';
      case DocumentsType.firstStudentAverageConfirmationLetter:
        return 'كتاب تأييد توفر او عدم توفر معدل الطالب الاول';
      case DocumentsType.diplomaOrder:
        return 'الامر الجامعي الخاص بالدبلوم';
      case DocumentsType.masterDegreeOrder:
        return 'الامر الجامعي الخاص بالماجستير';
      case DocumentsType.noObjectionLetter:
        return 'كتاب عدم الممانعة';
      case DocumentsType.promotionOrder:
        return 'امر الترقية';
      case DocumentsType.olympicCommitteeLetter:
        return 'كتاب اللجنة الاولمبية';
      case DocumentsType.martyrsFoundation:
        return 'مؤسسة الشهداء';
      case DocumentsType.cooperationMechanismBook:
        return 'كتاب وفق الية التعاون';
      default:
        throw Exception("Unknown value");
    }
  }

  static DocumentsType? fromId(int id) {
    switch (id) {
      case 1:
        return DocumentsType.bachelorDegreeCertificate;
      case 2:
        return DocumentsType.firstStudentAverageConfirmationLetter;
      case 3:
        return DocumentsType.diplomaOrder;
      case 4:
        return DocumentsType.masterDegreeOrder;
      case 5:
        return DocumentsType.noObjectionLetter;
      case 6:
        return DocumentsType.promotionOrder;
      case 7:
        return DocumentsType.olympicCommitteeLetter;
      case 14:
        return DocumentsType.martyrsFoundation;
      case 15:
        return DocumentsType.cooperationMechanismBook;
      default:
        return null;
    }
  }
}
