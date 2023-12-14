class FormatCheck {
  bool checkEmailFormat(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  bool checkPasswordLength(String password) {
    return password.length >= 6;
  }

  bool checkPhone(String phone) {
    return phone.length == 10 && phone.substring(0, 2) == "05";
  }
}
