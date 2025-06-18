// ignore_for_file: avoid_print

import 'package:dartz/dartz.dart';
import 'package:nafsia_app/core/errors/failures.dart';
import 'package:nafsia_app/core/helper_functions/get_user_data.dart';
import 'package:nafsia_app/core/services/api_consumer.dart';
import 'package:nafsia_app/core/utils/backend_endpoint.dart';
import 'package:nafsia_app/features/Home/data/model/appointement_data_model.dart';
import 'package:nafsia_app/features/Home/data/model/community_messages_model.dart';
import 'package:nafsia_app/features/Home/data/model/community_session_model.dart';

import 'appointment_repo.dart';

class AppointmentRepositoryImplementation extends AppointmentRepo {
  final ApiConsumer apiConsumer;

  AppointmentRepositoryImplementation(this.apiConsumer);

  @override
  @override
  Future<Either<Failure, AppointmentDataModel>> createAppointment({
    required String day,
    required int duration,
    required int price,
    required List<ScheduleItem> schedule,
  }) async {
    try {
      final token = getUserData().data?.token;
      final data = {
        'day': day,
        'duration': duration,
        'price': price,
        'schedule': schedule.map((item) => item.toJson()).toList(),
      };
      final response = await apiConsumer.post(
        BackendEndpoint.addAppointment,
        data: data,
        headers: {'Authorization': 'Bearer $token'},
      );
      final appointmentModel = AppointmentDataModel.fromJson(response['data']);
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
    required int duration,
    required int price,
    required List<ScheduleItem> schedule,
  }) async {
    try {
      final token = getUserData().data?.token;
      final data = {
        'day': day,
        'duration': duration,
        'price': price,
        'schedule': schedule.map((item) => item.toJson()).toList(),
      };
      final response = await apiConsumer.patch(
        BackendEndpoint.updateAppointment(appointmentId),
        data: data,
        headers: {'Authorization': 'Bearer $token'},
      );
      final appointmentModel = AppointmentDataModel.fromJson(response['data']);
      return Right(appointmentModel);
    } catch (e) {
      print("Error in update: $e");
      return Left(ServerFailure(message: 'حدث خطأ ما أثناء التحديث'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAppointment({
    required String appointmentId,
  }) async {
    try {
      final token = getUserData().data?.token;
      await apiConsumer.delete(
        BackendEndpoint.deleteAppointment(appointmentId),
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
  Future<Either<Failure, Data>> createCommunitySession({
    required DateTime startAt,
    required int duration,
    required int seats,
    required String meetLink,
    required String title,
    required String description,
    required List<String> tags,
  }) async {
    try {
      final token = getUserData().data?.token;
      final data = {
        'startAt': startAt.toIso8601String(),
        'duration': duration,
        'seats': seats,
        'meetLink': meetLink,
        'title': title,
        "description": description,
        "tags": tags,
      };
      final response = await apiConsumer.post(
        BackendEndpoint.createCommunitySession,
        data: data,
        headers: {'Authorization': 'Bearer $token'},
      );
      print("Returned data: ${response['data']}");

      final communitySessionModel = Data.fromJson(response['data']);
      return Right(communitySessionModel);
    } catch (e) {
      print("Error in create: $e");
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Data>> getCommunitySessionById(
      String sessionId) async {
    try {
      final token = getUserData().data?.token;

      final response = await apiConsumer.get(
        BackendEndpoint.getSessionsById(sessionId),
        headers: {'Authorization': 'Bearer $token'},
      );

      final session = Data.fromJson(response['data']);
      return Right(session);
    } catch (e) {
      print("Error in getCommunitySessionById: $e");
      return Left(ServerFailure(message: 'فشل في جلب بيانات الجلسة'));
    }
  }

  @override
  Future<Either<Failure, List<Data>>> getAllCommunitySessions({
    required String doctorId,
    required String sessionStatus,
    required String sessionType,
  }) async {
    try {
      final token = getUserData().data?.token;

      final response = await apiConsumer.get(
        '${BackendEndpoint.getSeessions}?doctorId=$doctorId&sessionStatus=$sessionStatus&sessionType=$sessionType',
        headers: {'Authorization': 'Bearer $token'},
      );

      final List<dynamic> dataList = response['data'] ?? [];
      final sessions = dataList.map((item) => Data.fromJson(item)).toList();

      return Right(sessions);
    } catch (e) {
      print("Error in getAllCommunitySessions: $e");
      return Left(ServerFailure(message: 'فشل في جلب الجلسات'));
    }
  }

  @override
  Future<Either<Failure, CommunityMessageModel>> addMessages({
    required String sessionId,
    required String message,
  }) async {
    try {
      final response = await apiConsumer.post(
        BackendEndpoint.addmessage,
        data: {'message': message, 'sessionId': sessionId},
        headers: {'Authorization': 'Bearer ${getUserData().data?.token}'},
      );

      final newMessage = CommunityMessageModel.fromJson(response['data']);
      return Right(newMessage);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CommunityMessageModel>>> getAllMessages({
    required String sessionId,
  }) async {
    try {
      final token = getUserData().data?.token;

      final response = await apiConsumer.get(
        BackendEndpoint.getAllMessages(sessionId),
        headers: {'Authorization': 'Bearer $token'},
      );

      final List<dynamic> dataList = response['data'] ?? [];

      final messages =
          dataList.map((item) => CommunityMessageModel.fromJson(item)).toList();

      return Right(messages);
    } catch (e) {
      print("Error in getAllMessages: $e");
      return Left(ServerFailure(message: 'فشل في جلب الرسائل'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMessage({
    required String messageId,
  }) async {
    try {
      final token = getUserData().data?.token;

      await apiConsumer.delete(
        BackendEndpoint.deleteMessage(messageId),
        headers: {'Authorization': 'Bearer $token'},
      );

      return const Right(null);
    } catch (e) {
      print("Error in deleteMessage: $e");
      return Left(ServerFailure(message: 'فشل في حذف الرسالة'));
    }
  }

  @override
  Future<Either<Failure, bool>> updateMessage({
    required String messageId,
    required String updatedMessage,
  }) async {
    try {
      final token = getUserData().data?.token;

      final response = await apiConsumer.patch(
        BackendEndpoint.updateMessage(messageId),
        data: {'message': updatedMessage},
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response == null || response['success'] != true) {
        throw Exception('Unexpected response format');
      }

      return const Right(true); // ما فيش بيانات نرجعها، فقط تأكيد
    } catch (e) {
      print("Error in updateMessage: $e");
      return Left(ServerFailure(message: 'فشل في تعديل الرسالة'));
    }
  }

  @override
  Future<Either<Failure, bool>> markSessionComplete(
      {required String sessionId}) async {
    try {
      final token = getUserData().data?.token;

      final response = await apiConsumer.post(
        BackendEndpoint.updateSessionComplete(sessionId),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response == null || response['success'] != true) {
        throw Exception('Unexpected response format');
      }

      return const Right(true);
    } catch (e) {
      print("Error in markSessionAsComplete: $e");
      return Left(ServerFailure(message: 'فشل في تحديد الجلسة كمكتملة'));
    }
  }
}
