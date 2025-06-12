// ignore_for_file: non_constant_identifier_names

class AccountRegistrationModel {
  final String username;
  final String email_address;
  final String phone_number;
  final String password;

  AccountRegistrationModel(
      {required this.username,
      required this.email_address,
      required this.phone_number,
      required this.password});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email_address': email_address,
      'phone_number': phone_number,
      'password': password
    };
  }

  factory AccountRegistrationModel.fromJson(Map<String, dynamic> json) {
    return AccountRegistrationModel(
      username: json['username'], // Extracting data from JSON
      email_address: json['email_address'],
      phone_number: json['phone_number'],
      password: json['password'],
    );
  }
}

class AccountLoginModel {
  final String email_address;
  final String password;

  AccountLoginModel({required this.email_address, required this.password});

  Map<String, dynamic> toJson() {
    return {'email_address': email_address, 'password': password};
  }

  factory AccountLoginModel.fromJson(Map<String, dynamic> json) {
    return AccountLoginModel(
      email_address: json['email_address'],
      password: json['password'],
    );
  }
}

class AccountEditModel {
  final String username;
  final String password;

  AccountEditModel({required this.username, required this.password});

  Map<String, dynamic> toJson() {
    return {'username': username, 'password': password};
  }

  factory AccountEditModel.fromJson(Map<String, dynamic> json) {
    return AccountEditModel(
      username: json['email_address'],
      password: json['password'],
    );
  }
}
