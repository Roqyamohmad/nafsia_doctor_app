class UserModel {
  bool? success;
  String? message;
  Data? data;

  UserModel({this.success, this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json)
      : success = json['success'],
        message = json['message'],
        data = json['data'] != null ? Data.fromJson(json['data']) : null;

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        if (data != null) 'data': data!.toJson(),
      };
}

class Data {
  User? user;
  String? token;

  Data({this.user, this.token});

  Data.fromJson(Map<String, dynamic> json)
      : user = json['user'] != null ? User.fromJson(json['user']) : null,
        token = json['token'];

  Map<String, dynamic> toJson() => {
        if (user != null) 'user': user!.toJson(),
        'token': token,
      };
}

class User {
  String? sId;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? role;
  int? age;
  String? gender;
  bool? isVerified;
  String? createdAt;
  String? updatedAt;
  String? id;
  dynamic doctorData; // لو لسه مش معرف النوع

  User({
    this.sId,
    this.name,
    this.email,
    this.password,
    this.phone,
    this.role,
    this.age,
    this.gender,
    this.isVerified,
    this.createdAt,
    this.updatedAt,
    this.doctorData,
    this.id,
  });

  User.fromJson(Map<String, dynamic> json)
      : sId = json['_id'],
        name = json['name'],
        email = json['email'],
        password = json['password'],
        phone = json['phone'],
        role = json['role'],
        age = json['age'],
        gender = json['gender'],
        isVerified = json['isVerified'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'],
        doctorData = json['doctorData'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
        '_id': sId,
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'role': role,
        'age': age,
        'gender': gender,
        'isVerified': isVerified,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'doctorData': doctorData,
        'id': id,
      };
}

/*
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

  UserModel copyWith({
    UserDataModel? userDataModel,
    String? token,
  }) {
    return UserModel(
      user: userDataModel ?? user,
      token: token ?? this.token,
    );
  }
}

class UserDataModel {
  final String name;
  final String email;
  final String phone;
  final String id;
  final String gender;
  final int age;
  final String role;
  bool? isVerified;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserDataModel({
    required this.name,
    required this.email,
    required this.id,
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
      id: json['id'],
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
      'id': id,
      'isVerified': isVerified,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  UserDataModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    int? age,
    String? role,
    String? token,
    bool? isVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? gender,
  }) {
    return UserDataModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      age: age ?? this.age,
      role: role ?? this.role,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      gender: gender ?? this.gender,
    );
  }
  
}
*/
