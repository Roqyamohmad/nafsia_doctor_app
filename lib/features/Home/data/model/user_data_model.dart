class UserDataModel {
  final String id;
  final String name;
  final String avatar;

  UserDataModel({
    required this.id,
    required this.name,
    required this.avatar,
  });

  /// ✅ Factory ثابتة عشان تستخدمها لو عايز نسخة فاضية.
  static var empty = UserDataModel(id: '', name: '', avatar: '');

  factory UserDataModel.fromJson(Map<dynamic, dynamic>? json) {
    if (json == null) {
      return UserDataModel.empty;
    }

    return UserDataModel(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      avatar: json['avatar'] is String ? json['avatar'] : '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'avatar': avatar,
    };
  }
}
