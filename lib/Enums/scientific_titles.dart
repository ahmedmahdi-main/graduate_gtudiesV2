enum ScientificTitles {
  assistantLecturer(1, "مدرس مساعد"),
  lecturer(2, "مدرس"),
  assistantProfessor(3, "استاذ مساعد"),
  professor(4, "استاذ"),
  bachelor(5, "بكالوريوس"),
  unknown(0, "غير معروف");

  final int id;
  final String name;

  const ScientificTitles(this.id, this.name);
}

// Extension to easily get the enum from id or name
extension ScientificTitlesExtension on ScientificTitles {
  static ScientificTitles? fromId(int id) {
    return ScientificTitles.values.firstWhere((e) => e.id == id, orElse: () => ScientificTitles.unknown);
  }

  static ScientificTitles? fromName(String name) {
    return ScientificTitles.values.firstWhere((e) => e.name == name, orElse: () => ScientificTitles.unknown);
  }
}
