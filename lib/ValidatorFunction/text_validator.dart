import 'email_validator.dart';

const String returnText = "الحقل مطلوب";

dynamic isTextValid(String? fullName) {
  // Check if the full name is not empty
  if (fullName == null) {
    return returnText;
  }
  if (fullName.isEmpty) {
    return returnText;
  }

  // Check if the full name contains only letters, spaces, and hyphens
  // final pattern = RegExp(r'^[a-zA-Z\u0600-\u06FF -]+$');
  // if (!pattern.hasMatch(fullName)) {
  //   return returnText;
  // }

  // final nameParts = fullName.split(' ');
  // for (String name in nameParts) {
  //   if (name.isEmpty) {
  //     return "توجد فراغات اكثر مما ينبغي";
  //   }
  // }
  // if (nameParts.length < parts) {
  //   return "يرجى كتابة الاسم الثلاثي";
  // }

  // If all checks pass, consider the full name as valid
  return null;
}

bool isFullNameValid(String fullName) {
  // Check if the full name is not empty
  if (fullName.isEmpty) {
    return false;
  }
  final pattern = RegExp(r'^[a-zA-Z\u0600-\u06FF -]+$');
  if (!pattern.hasMatch(fullName)) {
    return false;
  }

  // Check if the full name contains at least two words (e.g., first name and last name)
  final nameParts = fullName.split(' ');

  if (nameParts.length < 2) {
    return false;
  }

  // If all checks pass, consider the full name as valid
  return true;
}

dynamic validateTextWithoutAnyCharacterNumber(String? text) {
  if (text == null || text.isEmpty) {
    return 'الحقل لا يمكن أن يكون فارغًا';
  }

  // Updated regex to match only Arabic and English letters without numbers
  RegExp regex = RegExp(r'^[\p{L}\s]+$', unicode: true);

  if (regex.hasMatch(text)) {
    return null;
  }

  return 'لا يمكن لهذا الحقل ان \n يحتوي على أرقام أو رموز';
}

dynamic validateDocumentNumber(String? text) {
  if (text == null || text.isEmpty) {
    return 'الحقل لا يمكن أن يكون فارغًا\n';
  }
}

dynamic validateTextWithoutAnyCharacter(String? text) {
  if (text == null) {
    return returnText;
  }
  RegExp regex = RegExp(r'\b\d*[a-zA-Z]+\d*\b');
  if (!regex.hasMatch(text)) {
    return null;
  }

  // Test if the regex matches the text
  return 'لا يمكن لهذا الحقل \n ان يحتوي على احرف';
}

dynamic validateTextAsNumberLessThan100(String? text) {
  if (text == null || text.isEmpty) {
    return 'النص فارغ';
  }
  RegExp alphaRegex = RegExp(r'[a-zA-Z]');
  if (alphaRegex.hasMatch(text)) {
    return 'لا يمكن لهذا الحقل \n ان يحتوي على احرف';
  }
  if (double.tryParse(text) == null) {
    return 'الرجاء إدخال رقم صالح';
  }
  var number = double.parse(text);
  if (number <= 0) {
    return 'يجب أن لا يكون الرقم \n أقل او يساوي 0';
  }
  if (number > 100) {
    return 'يجب أن يكون الرقم \n أقل من 100';
  }
  return null;
}

//||
//       (phoneNumber.length <= 11 || !phoneNumber.contains("07"))
dynamic isPhoneNumberValid(String? phoneNumber) {
  if (phoneNumber == null || phoneNumber.isEmpty) {
    return returnText;
  }
  return null;
}

dynamic isEmailValid(String? email) {
  {
    if (!isCorrectEmail(email.toString())) {
      return 'بريد الاكتروني غير صحيح';
    }
    return null;
  }
}

dynamic isDropdownListValid(dynamic value) {
  if (value == null || value == 0) {
    return returnText;
  }
  return null;
}

dynamic phoneNumberValidator(String? phoneNumber) {
  // Check if the phone number is empty
  if (phoneNumber == null) {
    return "رقم الهاتف مطلوب";
  }

  // Check if the phone number contains only digits
  if (!RegExp(r'^\d+$').hasMatch(phoneNumber)) {
    return "يجب أن يحتوي رقم الهاتف على أرقام فقط";
  }

  // Check if the phone number is of valid length
  if (phoneNumber.length < 11) {
    return "يجب ألا يقل عن 11 أرقام";
  }
  if (phoneNumber.length > 15) {
    return "يجب أن يكون أصغر من 15 رقماً";
  }

  // If all conditions pass, return null
  return null;
}

dynamic houseNumberValidator(String? houseNumber) {
  // Check if the house number is empty
  if (houseNumber == null) {
    return "رقم الدار مطلوب";
  }

  // Check if the house number contains only digits
  if (!RegExp(r'^\d+$').hasMatch(houseNumber)) {
    return "يجب أن يحتوي رقم المنزل على أرقام فقط";
  }

  // Check if the house number length is within a reasonable range
  if (houseNumber.length > 5) {
    return "يجب أن يكون رقم المنزل أصغر من 5 أرقام";
  }

  // If all conditions pass, return null
  return null;
}
