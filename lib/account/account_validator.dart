// ignore_for_file: non_constant_identifier_names

class RegistrationValidator {
  static String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'username cannot be empty';
    }

    if (username.length < 6) {
      return 'username is too short';
    }

    return null;
  }

  static String? validateEmail(String? email_address) {
    if (email_address == null || email_address.isEmpty) {
      return 'email cannot be empty';
    }

    if (!email_address.contains('@')) {
      return 'email must be valid';
    }

    return null;
  }

  static String? validatePhone(String? phone_number) {
    if (phone_number == null || phone_number.isEmpty) {
      return 'phone cannot be empty';
    }

    if (phone_number.length < 10) {
      return 'Phonenumber is too short';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'password cannot be empty';
    }

    if (password.length < 6) {
      return 'password is too short';
    }
    return null;
  }
}

class LoginValidator {
  static String? validateEmail(String? email_address) {
    if (email_address == null || email_address.isEmpty) {
      return 'email cannot be empty';
    }

    if (!email_address.contains('@')) {
      return 'email must be valid';
    }

    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'password cannot be empty';
    }

    if (password.length < 6) {
      return 'password is too short';
    }
    return null;
  }
}
