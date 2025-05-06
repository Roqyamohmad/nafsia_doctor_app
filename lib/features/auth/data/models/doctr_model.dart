class DoctorDataModel {
  final String id;
  final String userId;
  final String specialization;
  final bool isApproved;
  final int rate;
  final int balance;

  DoctorDataModel({
    required this.id,
    required this.userId,
    required this.specialization,
    required this.isApproved,
    required this.rate,
    required this.balance,
  });

  factory DoctorDataModel.fromJson(Map<String, dynamic> json) {
    return DoctorDataModel(
      id: json['id'],
      userId: json['userId'],
      specialization: json['specialization'],
      isApproved: json['isApproved'],
      rate: json['rate'],
      balance: json['balance'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'specialization': specialization,
      'isApproved': isApproved,
      'rate': rate,
      'balance': balance,
    };
  }
}
