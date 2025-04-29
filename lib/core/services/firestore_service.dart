import 'package:dio/dio.dart';
import 'package:nafsia_app/core/services/data_service.dart';

class FireStoreService extends DatabaseService {
  final baseUrl = 'https://nafsia.up.railway.app';
  final Dio dio = Dio();

  @override
  Future<Map<String, dynamic>> addData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    var response = await dio.post('$baseUrl$path', data: data);
    return response.data;
  }

  @override
  Future<dynamic> getData(
      {required String path,
      String? docuementId,
      Map<String, dynamic>? query}) {
    throw UnimplementedError();
  }

  @override
  Future<bool> checkIfDataExists(
      {required String path, required String docuementId}) {
    throw UnimplementedError();
  }
}
