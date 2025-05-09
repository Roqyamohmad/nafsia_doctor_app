// ignore_for_file: avoid_print

import 'package:dartz/dartz.dart';
import 'package:nafsia_app/core/errors/failures.dart';
import 'package:nafsia_app/core/helper_functions/get_user_data.dart';
import 'package:nafsia_app/core/services/api_consumer.dart';
import 'package:nafsia_app/core/utils/backend_endpoint.dart';
import 'package:nafsia_app/features/Home/data/model/appointement_data_model.dart';
import 'package:nafsia_app/features/Home/data/model/community_session_model.dart';

import 'appointment_repo.dart';

class AppointmentRepositoryImplementation extends AppointmentRepo {
  final ApiConsumer apiConsumer;

  AppointmentRepositoryImplementation(this.apiConsumer);

  @override
  Future<Either<Failure, AppointmentDataModel>> createAppointment({
    required String day,
    required String startAtHour,
    required int duration,
    required int price,
  }) async {
    try {
      final token = getUserData().data?.token;
      final data = {
        'day': day,
        'startAtHour': startAtHour,
        'duration': duration,
        'price': price,
      };
      final response = await apiConsumer.post(
        BackendEndpoint.addAppointment,
        data: data,
        headers: {'Authorization': 'Bearer $token'},
      );
      final appointmentModel = AppointmentDataModel.fromJson(response);
      return Right(appointmentModel);
    } catch (e) {
      print("Error in create: $e");
      return Left(ServerFailure(message: 'حدث خطأ ما، حاول مرة أخرى'));
    }
  }

  @override
  Future<Either<Failure, AppointmentDataModel>> updateAppointment({
    required String appointmentId,
    required String day,
    required String startAtHour,
    required int duration,
    required int price,
  }) async {
    try {
      final token = getUserData().data?.token;
      final data = {
        'day': day,
        'startAtHour': startAtHour,
        'duration': duration,
        'price': price,
      };
      final response = await apiConsumer.patch(
        BackendEndpoint.updateAppointment(appointmentId),
        data: data,
        headers: {'Authorization': 'Bearer $token'},
      );
      final appointmentModel = AppointmentDataModel.fromJson(response);
      return Right(appointmentModel);
    } catch (e) {
      print("Error in update: $e");
      return Left(ServerFailure(message: 'حدث خطأ ما أثناء التحديث'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAppointment({
    required String postId,
  }) async {
    try {
      final token = getUserData().data?.token;
      await apiConsumer.delete(
        BackendEndpoint.deleteAppointment(postId),
        headers: {'Authorization': 'Bearer $token'},
      );
      return const Right(null);
    } catch (e) {
      print("Error in delete: $e");
      return Left(ServerFailure(message: 'حدث خطأ ما أثناء الحذف'));
    }
  }

  @override
  Future<Either<Failure, List<AppointmentDataModel>>> getAppointments() async {
    try {
      final token = getUserData().data?.token;
      final doctorId = getUserData().data!.user!.id!;

      final response = await apiConsumer.get(
        '${BackendEndpoint.getAppointments}?doctorId=$doctorId',
        headers: {'Authorization': 'Bearer $token'},
      );

      final List<dynamic> dataList = response['data'] ?? [];

      final appointments =
          dataList.map((item) => AppointmentDataModel.fromJson(item)).toList();

      return Right(appointments);
    } catch (e) {
      print("Error in getAppointments: $e");
      return Left(ServerFailure(message: 'فشل في جلب المواعيد'));
    }
  }

  @override
  Future<Either<Failure, CommunitySessionModel>> createCommunitySession({
    required DateTime startAt,
    required int duration,
    required int price,
    required int seats,
    required String meetLink,
  }) async {
    try {
      final token = getUserData().data?.token;
      final data = {
        'startAt': startAt.toIso8601String(),
        'duration': duration,
        'price': price,
        'seats': seats,
        'meetLink': meetLink,
      };
      final response = await apiConsumer.post(
        BackendEndpoint.createCommunitySession,
        data: data,
        headers: {'Authorization': 'Bearer $token'},
      );
      final communitySessionModel = CommunitySessionModel.fromJson(response);
      return Right(communitySessionModel);
    } catch (e) {
      print("Error in create: $e");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
