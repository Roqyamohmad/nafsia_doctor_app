import 'package:nafsia_app/features/Home/data/model/reactions_data_model.dart';
import 'package:nafsia_app/features/Home/data/model/tags_data_model.dart';

import 'doctor_data_model.dart';
import 'image_data_model.dart';

class PostModel {
  final String id;
  final String title;
  final String content;
  final List<ImageDataModel> images;
  final DoctorDataModel doctor;
  final List<TagDataModel> tags;
  final List<ReactionDataModel> reactions;
  final DateTime createdAt;
  final DateTime updatedAt;

  PostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.images,
    required this.doctor,
    required this.tags,
    required this.reactions,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PostModel.fromJson(Map<dynamic, dynamic> json) {
    return PostModel(
      id: json['_id'],
      title: json['title'],
      content: json['content'],
      images: (json['images'] as List)
          .map((img) => ImageDataModel.fromJson(img))
          .toList(),
      doctor: DoctorDataModel.fromJson(json['doctorData']),
      tags: (json['tagsData'] as List)
          .map((tag) => TagDataModel.fromJson(tag))
          .toList(),
      reactions: (json['reactionsData'] as List)
          .map((react) => ReactionDataModel.fromJson(react))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
  PostModel copyWith({
    String? id,
    String? title,
    String? content,
    List<ImageDataModel>? images,
    DoctorDataModel? doctor,
    List<TagDataModel>? tags,
    List<ReactionDataModel>? reactions,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PostModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      images: images ?? this.images,
      doctor: doctor ?? this.doctor,
      tags: tags ?? this.tags,
      reactions: reactions ?? this.reactions,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
