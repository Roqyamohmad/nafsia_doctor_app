// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    bool success;
    String message;
    Data data;

    UserModel({
        required this.success,
        required this.message,
        required this.data,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    User user;

    Data({
        required this.user,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
    };
}

class User {
    String id;
    String name;
    String email;
    String password;
    String phone;
    String role;
    int age;
    String gender;
    bool isVerified;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic doctorData;
    String userId;

    User({
        required this.id,
        required this.name,
        required this.email,
        required this.password,
        required this.phone,
        required this.role,
        required this.age,
        required this.gender,
        required this.isVerified,
        required this.createdAt,
        required this.updatedAt,
        required this.doctorData,
        required this.userId,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        role: json["role"],
        age: json["age"],
        gender: json["gender"],
        isVerified: json["isVerified"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        doctorData: json["doctorData"],
        userId: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "role": role,
        "age": age,
        "gender": gender,
        "isVerified": isVerified,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "doctorData": doctorData,
        "id": userId,
    };
}
