class Validator {
  static String emailValidator(String value) {
    if (value.isEmpty) return "*required";
    RegExp regex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    if (!regex.hasMatch(value)) return "invalid";
    return null;
  }

  static String passwordValidator(String value) {
    if (value.isEmpty) return "*required";
    RegExp regex = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");
    if (!regex.hasMatch(value))
      return "Minimum 8 characters, at least one letter and one digit";
    return null;
  }

  static String personNameValidator(String value) {
    if (value.isEmpty) return "*required";
    RegExp regex = RegExp(r"^[a-zA-Z]+(([ ][a-zA-Z ])?[a-zA-Z]*)*$");
    if (!regex.hasMatch(value)) return "invalid";
    return null;
  }

  static String nicValidator(String value) {
    if (value.isEmpty) return "*required";
    RegExp regex = RegExp(r"^[0-9]{9}[v|V]$");
    if (!regex.hasMatch(value)) return "invalid";
    return null;
  }

  static String phoneValidator(String value) {
    if (value.isEmpty) return "*required";
    RegExp regex = RegExp(r"^0[0-9]{9}$");
    if (!regex.hasMatch(value)) return "invalid";
    return null;
  }

  static String addressLineValidator(String value) {
    if (value.isEmpty) return "*required";
    RegExp regex =
    RegExp(r"^[a-zA-Z0-9]+(([,. -@/()][a-zA-Z0-9 ])?[a-zA-Z0-9]*)*$");
    if (!regex.hasMatch(value)) return "invalid";
    return null;
  }

  static String postalCodeValidator(String value) {
    if (value.isEmpty) return "*required";
    RegExp regex =
    RegExp(r"^[0-9]{5}$");
    if (!regex.hasMatch(value)) return "invalid";
    return null;
  }

  static String textValidator(String value) {
    if (value.isEmpty) return "*required";
    RegExp regex =
        RegExp(r"^[a-zA-Z0-9]+(([',. -_*@$/&!()][a-zA-Z0-9 ])?[a-zA-Z0-9]*)*$");
    if (!regex.hasMatch(value)) return "invalid";
    return null;
  }

  static String multiLineTextValidator(String value) {
    if (value.isEmpty) return "*required";
//    RegExp regex =
//    RegExp(r"^[a-zA-Z0-9]+(([',. -_*@\n$/&!()][a-zA-Z0-9 ])?[a-zA-Z0-9]*)*$");
//    if (!regex.hasMatch(value)) return "invalid";
    return null;
  }
}
