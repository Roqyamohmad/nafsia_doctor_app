class AvatarModel {
  final String? secureUrl;
  final String? publicId;

  AvatarModel({this.secureUrl, this.publicId});

  factory AvatarModel.fromJson(Map<String, dynamic> json) {
    return AvatarModel(
      secureUrl: json['secure_url'],
      publicId: json['public_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'secure_url': secureUrl,
      'public_id': publicId,
    };
  }
}

class MedicalLicenseModel {
  final String? secureUrl;
  final String? publicId;

  MedicalLicenseModel({this.secureUrl, this.publicId});

  factory MedicalLicenseModel.fromJson(Map<String, dynamic> json) {
    return MedicalLicenseModel(
      secureUrl: json['secure_url'],
      publicId: json['public_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'secure_url': secureUrl,
      'public_id': publicId,
    };
  }
}
