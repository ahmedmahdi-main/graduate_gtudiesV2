bool isCorrectEmail(String email) {
  // Define a regular expression pattern for a valid email address
  const pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
  // Create a RegExp instance with the defined pattern
  final regExp = RegExp(pattern);
  // Use the hasMatch method to check if the email matches the pattern
  return regExp.hasMatch(email);
}
