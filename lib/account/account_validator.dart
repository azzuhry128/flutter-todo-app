// ignore_for_file: non_constant_identifier_names

class RegistrationValidator {
  static String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Username cannot be empty';
    }

    if (username.length < 6) {
      return 'Username is too short';
    }

    return null;
  }

  static String? validateEmail(String? email_address) {
    if (email_address == null || email_address.isEmpty) {
      return 'Email cannot be empty';
    }

    if (!email_address.contains('@')) {
      return 'Enter a valid email address';
    }

    return null;
  }

  static String? validatePhone(String? phone_number) {
    if (phone_number == null || phone_number.isEmpty) {
      return 'Phone cannot be empty';
    }

    if (phone_number.length < 10) {
      return 'Phone number must be at least 10 characters long';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password cannot be empty';
    }

    if (password.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }
}

class LoginValidator {
  static String? validateEmail(String? email_address) {
    if (email_address == null || email_address.isEmpty) {
      return 'Email cannot be empty';
    }

    if (!email_address.contains('@')) {
      return 'Enter a valid email address';
    }

    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password cannot be empty';
    }

    if (password.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }
}
