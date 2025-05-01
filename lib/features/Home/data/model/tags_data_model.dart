class TagDataModel {
  final String id;
  final String name;

  TagDataModel({
    required this.id,
    required this.name,
  });

  factory TagDataModel.fromJson(Map<String, dynamic> json) {
    return TagDataModel(
      id: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}
