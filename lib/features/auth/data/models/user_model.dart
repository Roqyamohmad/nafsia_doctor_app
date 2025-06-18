import 'package:nafsia_app/features/auth/data/models/avater_model.dart';
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
  DoctorDataModel? doctorData;
  AvatarModel? avatar; // ✅ جديد

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
    this.avatar, // ✅ جديد
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
            : null,
        avatar = json['avatar'] != null
            ? AvatarModel.fromJson(json['avatar'])
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
        'avatar': avatar?.toJson(), // ✅ جديد
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
    AvatarModel? avatar, // ✅ جديد
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
      avatar: avatar ?? this.avatar, // ✅ جديد
      id: id ?? this.id,
    );
  }
}
