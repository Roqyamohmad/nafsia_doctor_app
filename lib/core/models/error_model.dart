class ErrorModel {
  final String errorMessage;

  ErrorModel({required this.errorMessage});
  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    return ErrorModel(
      errorMessage: jsonData['message'],
    );
  }
}
