import 'package:nafsia_app/features/auth/data/models/user_model.dart';

class ReactionDataModel {
  final String id;
  final String type;
  final UserDataModel user;

  ReactionDataModel({
    required this.id,
    required this.type,
    required this.user,
  });

  factory ReactionDataModel.fromJson(Map<String, dynamic> json) {
    return ReactionDataModel(
      id: json['_id'],
      type: json['reactType'],
      user: UserDataModel.fromJson(json['userData']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'reactType': type,
      'userData': user.toJson(),
    };
  }
}
