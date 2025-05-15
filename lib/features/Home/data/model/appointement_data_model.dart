class AppointmentDataModel {
  final String? id;
  final String? doctorId;
  final String? day;
  final int? duration;
  final int? price;
  final List<ScheduleItem>? schedule;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DoctorModel? doctorData;

  AppointmentDataModel({
    this.id,
    this.doctorId,
    this.day,
    this.duration,
    this.price,
    this.schedule,
    this.createdAt,
    this.updatedAt,
    this.doctorData,
  });

  factory AppointmentDataModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json;
    return AppointmentDataModel(
      id: data['_id'],
      doctorId: data['doctorId'],
      day: data['day'],
      duration: data['duration'],
      price: data['price'],
      schedule: (data['schedule'] as List<dynamic>?)
          ?.map((item) => ScheduleItem.fromJson(item))
          .toList(),
      createdAt:
          data['createdAt'] != null ? DateTime.parse(data['createdAt']) : null,
      updatedAt:
          data['updatedAt'] != null ? DateTime.parse(data['updatedAt']) : null,
      doctorData: data['doctorData'] != null
          ? DoctorModel.fromJson(data['doctorData'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'doctorId': doctorId,
      'day': day,
      'duration': duration,
      'price': price,
      'schedule': schedule?.map((item) => item.toJson()).toList(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'doctorData': doctorData?.toJson(),
    };
  }
}

class ScheduleItem {
  final String? id;
  final String? startAt;
  final bool? isBooked;

  ScheduleItem({
    this.id,
    this.startAt,
    this.isBooked,
  });

  factory ScheduleItem.fromJson(Map<String, dynamic> json) {
    return ScheduleItem(
      id: json['_id'],
      startAt: json['startAt'],
      isBooked: json['isBooked'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'startAt': startAt,
      'isBooked': isBooked,
    };
  }
}

class DoctorModel {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? role;
  final int? age;
  final String? gender;
  final bool? isVerified;
  final String? avatarUrl;
  final DoctorDetails? doctorDetails;

  DoctorModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.role,
    this.age,
    this.gender,
    this.isVerified,
    this.avatarUrl,
    this.doctorDetails,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
      age: json['age'],
      gender: json['gender'],
      isVerified: json['isVerified'],
      avatarUrl: json['avatar']?['secure_url'],
      doctorDetails: json['doctorData'] != null
          ? DoctorDetails.fromJson(json['doctorData'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'age': age,
      'gender': gender,
      'isVerified': isVerified,
      'avatar': {'secure_url': avatarUrl},
      'doctorData': doctorDetails?.toJson(),
    };
  }
}

class DoctorDetails {
  final String? id;
  final String? userId;
  final String? specialization;
  final bool? isApproved;
  final int? rate;
  final int? balance;
  final String? licenseUrl;

  DoctorDetails({
    this.id,
    this.userId,
    this.specialization,
    this.isApproved,
    this.rate,
    this.balance,
    this.licenseUrl,
  });

  factory DoctorDetails.fromJson(Map<String, dynamic> json) {
    return DoctorDetails(
      id: json['_id'],
      userId: json['userId'],
      specialization: json['specialization'],
      isApproved: json['isApproved'],
      rate: json['rate'],
      balance: json['balance'],
      licenseUrl: json['medicalLicense']?['secure_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'specialization': specialization,
      'isApproved': isApproved,
      'rate': rate,
      'balance': balance,
      'medicalLicense': {'secure_url': licenseUrl},
    };
  }
}
