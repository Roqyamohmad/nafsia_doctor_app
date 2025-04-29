abstract class DatabaseService {
  Future<Map<String,dynamic>> addData(
      {required String path,
      required Map<String, dynamic> data,
      });
  Future<dynamic> getData({
    required String path,
    String? docuementId,
    Map<String, dynamic>? query,
  });
  Future<bool> checkIfDataExists(
      {required String path, required String docuementId});
}
