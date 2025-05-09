import 'package:nafsia_app/features/auth/data/models/doctr_model.dart';

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
  Data copyWith({
    User? user,
    String? token,
  }) {
    return Data(
      user: user ?? user,
      token: token ?? this.token,
    );
  }
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
  DateTime? createdAt;
  DateTime? updatedAt;
  String? id;
  DoctorDataModel? doctorData; // ✅ بدل dynamic

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
    this.id,
    this.doctorData,
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
        createdAt = json['createdAt'] != null
            ? DateTime.tryParse(json['createdAt'].toString())
            : null,
        updatedAt = json['updatedAt'] != null
            ? DateTime.tryParse(json['updatedAt'].toString())
            : null,
        id = json['id'],
        doctorData = json['doctorData'] != null
            ? DoctorDataModel.fromJson(json['doctorData'])
            : null;

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
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'doctorData': doctorData?.toJson(),
        'id': id,
      };

  User copyWith({
    String? sId,
    String? name,
    String? email,
    String? password,
    String? phone,
    String? role,
    int? age,
    String? gender,
    bool? isVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    DoctorDataModel? doctorData,
  }) {
    return User(
      sId: sId ?? this.sId,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      doctorData: doctorData ?? this.doctorData,
      id: id ?? this.id,
    );
  }
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
