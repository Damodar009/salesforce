class Validators {
   static String? validator(String? string) {
    if (string == null || string.isEmpty) {
      return 'this cannot be empty';
    }
    return null;
  }
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static bool isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidName(String name) {
    return name.isNotEmpty;
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }

  static isValidConfirmPassword(String oldPassword, String newPassword) {
    return oldPassword == newPassword;
  }

  static isPasswordLength(String password) {
    return password.length > 3;
  }
}
