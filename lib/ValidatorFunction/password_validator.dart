dynamic passwordValidator(String password) {
  if (password.isEmpty) {
    return "كلمة المرور  مطلوبة";
  }
  if (password.length < 8) {
    return "يجب ان لاتقل عن 8 حروف";
  }
  if (password.length > 16) {
    return "يجب ان تكون اصغر من 16 حرفاً";
  }
  return null;
}

dynamic confirmPasswordValidator(String password, String confirmPassword) {
  if (confirmPassword.isEmpty) {
    return "كلمة المرور  مطلوبة";
  }
  if (password != confirmPassword) {
    return "كلمة المرور غير متطابقة";
  }
  return null;
}
