import 'package:nafsia_app/features/auth/data/models/doctr_model.dart';

class CommunitySessionModel {
  final String id;
  final String doctorId;
  final List<dynamic> participations;
  final DateTime startAt;
  final int duration;
  final int price;
  final int seats;
  final int bookedSeats;
  final String type;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DoctorDataModel doctorData;
  final String meetLink;
  final List<dynamic> participationsData;

  CommunitySessionModel({
    required this.meetLink,
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
    required this.createdAt,
    required this.updatedAt,
    required this.doctorData,
    required this.participationsData,
  });

  factory CommunitySessionModel.fromJson(Map<String, dynamic> json) {
    return CommunitySessionModel(
      meetLink: json['meetLink'] ?? '', // أضفنا حماية هنا
      id: json['id'] ?? '',
      doctorId: json['doctorId'] ?? '',
      participations: json['participations'] ?? [],
      startAt: DateTime.parse(json['startAt']),
      duration: json['duration'] ?? 0,
      price: json['price'] ?? 0,
      seats: json['seats'] ?? 0,
      bookedSeats: json['bookedSeats'] ?? 0,
      type: json['type'] ?? '',
      status: json['status'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      doctorData: DoctorDataModel.fromJson(json['doctorData'] ?? {}),
      participationsData: json['participationsData'] ?? [],
    );
  }
}
