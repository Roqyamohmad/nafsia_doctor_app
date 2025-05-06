class TagDataModel {
  final String id;
  final String name;

  TagDataModel({
    required this.id,
    required this.name,
  });

  static var empty = TagDataModel(id: '', name: '');

  factory TagDataModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return TagDataModel.empty;
    }

    return TagDataModel(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}
