import 'package:nafsia_app/features/auth/data/models/avater_model.dart';

class DoctorDataModel {
  final String? id;
  final String? userId;
  final String? specialization;
  final bool? isApproved;
  final int? rate;
  final int? balance;
  final String? description;
  final List<String>? image;
  final MedicalLicenseModel? medicalLicense; // ✅ جديد

  DoctorDataModel({
    this.description,
    this.id,
    this.userId,
    this.specialization,
    this.isApproved,
    this.rate,
    this.balance,
    this.image,
    this.medicalLicense, // ✅ جديد
  });

  factory DoctorDataModel.fromJson(Map<String, dynamic> json) {
    return DoctorDataModel(
      id: json['id'] ?? json['_id'],
      userId: json['userId'],
      description: json['description'],
      specialization: json['specialization'],
      isApproved: json['isApproved'],
      rate: json['rate'],
      balance: json['balance'],
      image: json['image'] != null
          ? List<String>.from(json['image'] as List)
          : null,
      medicalLicense: json['medicalLicense'] != null
          ? MedicalLicenseModel.fromJson(json['medicalLicense'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'userId': userId,
      'specialization': specialization,
      'isApproved': isApproved,
      'rate': rate,
      'balance': balance,
      if (image != null) 'image': image,
      if (medicalLicense != null)
        'medicalLicense': medicalLicense!.toJson(), // ✅ جديد
    };
  }

  DoctorDataModel copyWith({
    String? id,
    String? userId,
    String? specialization,
    String? description,
    bool? isApproved,
    int? rate,
    int? balance,
    List<String>? image,
    MedicalLicenseModel? medicalLicense, // ✅ جديد
  }) {
    return DoctorDataModel(
      description: description,
      id: id ?? this.id,
      userId: userId ?? this.userId,
      specialization: specialization ?? this.specialization,
      isApproved: isApproved ?? this.isApproved,
      rate: rate ?? this.rate,
      balance: balance ?? this.balance,
      image: image ?? this.image,
      medicalLicense: medicalLicense ?? this.medicalLicense, // ✅ جديد
    );
  }
}
