class CommunityMessageModel {
  final String id;
  final String sessionId;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;

  CommunityMessageModel({
    required this.id,
    required this.sessionId,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CommunityMessageModel.fromJson(Map<String, dynamic> json) {
    return CommunityMessageModel(
      id: json['_id'] ?? '',
      sessionId: json['sessionId'] ?? '',
      message: json['message'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // ✅ New copyWith method
  CommunityMessageModel copyWith({
    String? id,
    String? sessionId,
    String? message,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CommunityMessageModel(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
