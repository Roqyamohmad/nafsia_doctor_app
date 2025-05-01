class LoginResponseModel {
  final bool success;
  final String message;
  final UserModel data;

  LoginResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'],
      message: json['message'],
      data: UserModel.fromJson(json['data']),
    );
  }
}

class UserModel {
  final UserDataModel user;
  final String token;

  UserModel({
    required this.user,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      user: UserDataModel.fromJson(json['user']),
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'token': token,
    };
  }
}

class UserDataModel {
  final String name;
  final String email;
  final String phone;
  final String gender;
  final int age;
  final String role;
  bool? isVerified;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserDataModel({
    required this.name,
    required this.email,
    required this.gender,
    required this.age,
    required this.phone,
    required this.role,
    this.isVerified,
    this.createdAt,
    this.updatedAt,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      name: json['name'],
      email: json['email'],
      gender: json['gender'],
      age: json['age'],
      phone: json['phone'],
      role: json['role'],
      isVerified: true,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'gender': gender,
      'age': age,
      'phone': phone,
      'role': role,
      'isVerified': isVerified,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
