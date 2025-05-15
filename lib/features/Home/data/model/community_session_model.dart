class CommunitySessionModel {
  final bool success;
  final String message;
  final Data? data;

  CommunitySessionModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CommunitySessionModel.fromJson(Map<String, dynamic> json) {
    return CommunitySessionModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }
}

class Data {
  final String id;
  final String doctorId;
  final List<dynamic> participations;
  final DateTime? startAt;
  final int duration;
  final int price;
  final int seats;
  final int bookedSeats;
  final String type;
  final String status;
  final String title;
  final String description;
  final List<String> tags;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DataDoctorData? doctorData;
  final List<dynamic> participationsData;
  final String dataId;

  Data({
    required this.id,
    required this.doctorId,
    required this.participations,
    required this.startAt,
    required this.duration,
    required this.price,
    required this.seats,
    required this.bookedSeats,
    required this.type,
    required this.status,
    required this.title,
    required this.description,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
    required this.doctorData,
    required this.participationsData,
    required this.dataId,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['_id'] ?? json['id'] ?? '',
      doctorId: json['doctorId'] ?? '',
      participations: json['participations'] ?? [],
      startAt: _tryParseDate(json['startAt']),
      duration: json['duration'] ?? 0,
      price: json['price'] ?? 0,
      seats: json['seats'] ?? 0,
      bookedSeats: json['bookedSeats'] ?? 0,
      type: json['type'] ?? '',
      status: json['status'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
      createdAt: _tryParseDate(json['createdAt']),
      updatedAt: _tryParseDate(json['updatedAt']),
      doctorData: json['doctorData'] != null
          ? DataDoctorData.fromJson(json['doctorData'])
          : null,
      participationsData: json['participationsData'] ?? [],
      dataId: json['_id'] ?? '',
    );
  }
}

class Avatar {
  final String secureUrl;
  final String publicId;

  Avatar({
    required this.secureUrl,
    required this.publicId,
  });

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(
      secureUrl: json['secure_url'] ?? '',
      publicId: json['public_id'] ?? '',
    );
  }
}

class DoctorDataDoctorData {
  final Avatar medicalLicense;
  final String id;
  final String userId;
  final String specialization;
  final bool isApproved;
  final int rate;
  final int balance;
  final String doctorDataId;

  DoctorDataDoctorData({
    required this.medicalLicense,
    required this.id,
    required this.userId,
    required this.specialization,
    required this.isApproved,
    required this.rate,
    required this.balance,
    required this.doctorDataId,
  });

  factory DoctorDataDoctorData.fromJson(Map<String, dynamic> json) {
    return DoctorDataDoctorData(
      medicalLicense: json['medicalLicense'] != null
          ? Avatar.fromJson(json['medicalLicense'])
          : Avatar(secureUrl: '', publicId: ''),
      id: json['_id'] ?? json['id'] ?? '',
      userId: json['userId'] ?? '',
      specialization: json['specialization'] ?? '',
      isApproved: json['isApproved'] ?? false,
      rate: json['rate'] ?? 0,
      balance: json['balance'] ?? 0,
      doctorDataId: json['_id'] ?? json['id'] ?? '',
    );
  }
}

class DataDoctorData {
  final Avatar avatar;
  final String id;
  final String name;
  final String email;
  final String password;
  final String phone;
  final String role;
  final int age;
  final String gender;
  final bool isVerified;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DoctorDataDoctorData? doctorData;
  final String doctorDataId;

  DataDoctorData({
    required this.avatar,
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
    required this.doctorDataId,
  });

  factory DataDoctorData.fromJson(Map<String, dynamic> json) {
    return DataDoctorData(
      avatar: json['avatar'] != null
          ? Avatar.fromJson(json['avatar'])
          : Avatar(secureUrl: '', publicId: ''),
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? '',
      age: json['age'] ?? 0,
      gender: json['gender'] ?? '',
      isVerified: json['isVerified'] ?? false,
      createdAt: _tryParseDate(json['createdAt']),
      updatedAt: _tryParseDate(json['updatedAt']),
      doctorData: json['doctorData'] != null
          ? DoctorDataDoctorData.fromJson(json['doctorData'])
          : null,
      doctorDataId: json['doctorData']?['_id'] ?? '',
    );
  }
}

// Helper function for safe date parsing
DateTime? _tryParseDate(dynamic date) {
  if (date == null) return null;
  try {
    return DateTime.parse(date);
  } catch (_) {
    return null;
  }
}
