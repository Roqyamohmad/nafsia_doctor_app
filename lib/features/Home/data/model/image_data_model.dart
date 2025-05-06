class ImageDataModel {
  final String secureUrl;
  final String publicId;

  ImageDataModel({
    required this.secureUrl,
    required this.publicId,
  });

  factory ImageDataModel.fromJson(Map<String, dynamic> json) {
    return ImageDataModel(
      secureUrl: json['secure_url']?.toString() ?? '',
      publicId: json['public_id']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'secure_url': secureUrl,
      'public_id': publicId,
    };
  }
}
