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
    final avatarField = json['avatar'];
    String avatarUrl = 'default.png';

    if (avatarField is Map && avatarField['secure_url'] != null) {
      avatarUrl = avatarField['secure_url'].toString();
    } else if (avatarField is String) {
      avatarUrl = avatarField;
    }

    return DoctorDataModel(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      avatarUrl: avatarUrl,
    );
  }

  /// optional: default empty constructor if needed
  factory DoctorDataModel.empty() {
    return DoctorDataModel(id: '', name: '', avatarUrl: 'default.png');
  }
}
