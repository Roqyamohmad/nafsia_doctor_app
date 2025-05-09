class DoctorDataModel {
  final String id;
  final String userId;
  final String specialization;
  final bool isApproved;
  final int rate;
  final int balance;
  final List<String>? image; // قائمة روابط الصور

  DoctorDataModel({
    required this.id,
    required this.userId,
    required this.specialization,
    required this.isApproved,
    required this.rate,
    required this.balance,
    this.image,
  });

  factory DoctorDataModel.fromJson(Map<String, dynamic> json) {
    return DoctorDataModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      specialization: json['specialization'] as String,
      isApproved: json['isApproved'] as bool,
      rate: json['rate'] as int,
      balance: json['balance'] as int,
      image: json['image'] != null
          ? List<String>.from(json['image'] as List)
          : null,
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
      if (image != null) 'image': image,
    };
  }

  DoctorDataModel copyWith({
    String? id,
    String? userId,
    String? specialization,
    bool? isApproved,
    int? rate,
    int? balance,
    List<String>? image, // <-- هنا ضبط النوع
  }) {
    return DoctorDataModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      specialization: specialization ?? this.specialization,
      isApproved: isApproved ?? this.isApproved,
      rate: rate ?? this.rate,
      balance: balance ?? this.balance,
      image: image ?? this.image,
    );
  }
}
