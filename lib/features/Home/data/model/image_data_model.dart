class ImageDataModel {
  final String secureUrl;
  final String publicId;

  ImageDataModel({
    required this.secureUrl,
    required this.publicId,
  });

  factory ImageDataModel.fromJson(Map<String, dynamic> json) {
    // ننفذ التحقق بأن قيم JSON موجودة أو نعيد قيمة افتراضية
    return ImageDataModel(
      secureUrl: json['secure_url']?.toString() ??
          'default_url', // نضع قيمة افتراضية آمنة
      publicId: json['public_id']?.toString() ??
          'default_id', // نضع قيمة افتراضية آمنة
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'secure_url': secureUrl,
      'public_id': publicId,
    };
  }
}
