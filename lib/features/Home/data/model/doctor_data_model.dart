class DoctorDataModel {
  final String id;
  final String name;
  final String avatarUrl;

  DoctorDataModel({
    required this.id,
    required this.name,
    required this.avatarUrl,
  });

  factory DoctorDataModel.fromJson(Map<String, dynamic> json) {
    return DoctorDataModel(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      avatarUrl: json['avatar'] is Map
          ? (json['avatar']['secure_url']?.toString() ?? 'default.png')
          : (json['avatar']?.toString() ?? 'default.png'),
    );
  }
}
