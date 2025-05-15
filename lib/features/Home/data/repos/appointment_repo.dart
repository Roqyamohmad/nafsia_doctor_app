import 'package:dartz/dartz.dart';
import 'package:nafsia_app/core/errors/failures.dart';
import 'package:nafsia_app/features/Home/data/model/appointement_data_model.dart';
import 'package:nafsia_app/features/Home/data/model/community_session_model.dart';

abstract class AppointmentRepo {
  Future<Either<Failure, AppointmentDataModel>> createAppointment({
    required String day,
    required int duration,
    required int price,
    required List<ScheduleItem> schedule,
  });

  Future<Either<Failure, AppointmentDataModel>> updateAppointment({
    required String appointmentId,
    required String day,
    required int duration,
    required int price,
    required List<ScheduleItem> schedule,
  });

  Future<Either<Failure, void>> deleteAppointment({
    required String appointmentId,
  });

  Future<Either<Failure, List<AppointmentDataModel>>> getAppointments();

  Future<Either<Failure, Data>> createCommunitySession({
    required DateTime startAt,
    required int duration,
    required int price,
    required String title,
    required int seats,
    required String meetLink,
    required String description,
    required List<String> tags,
  });
  Future<Either<Failure, Data>> getCommunitySessionById(String sessionId);

Future<Either<Failure, List<Data>>> getAllCommunitySessions({
  required String doctorId,
  required String sessionStatus,
  required String sessionType,
});

}
