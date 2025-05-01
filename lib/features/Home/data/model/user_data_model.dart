class UserDataModel {
  final String id;
  final String name;
  final String avatar;

  UserDataModel({
    required this.id,
    required this.name,
    required this.avatar,
  });

  factory UserDataModel.fromJson(Map<dynamic, dynamic> json) {
    final avatarValue = json['avatar'];
    return UserDataModel(
      id: json['_id'],
      name: json['name'],
      avatar: avatarValue is String ? avatarValue : '',
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
