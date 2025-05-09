import 'package:dartz/dartz.dart';
import 'package:nafsia_app/core/errors/failures.dart';
import 'package:nafsia_app/features/Home/data/model/appointement_data_model.dart';
import 'package:nafsia_app/features/Home/data/model/community_session_model.dart';

abstract class AppointmentRepo {
  Future<Either<Failure, AppointmentDataModel>> createAppointment({
    required String day,
    required String startAtHour,
    required int duration,
    required int price,
  });

  Future<Either<Failure, AppointmentDataModel>> updateAppointment({
    required String appointmentId,
    required String day,
    required String startAtHour,
    required int duration,
    required int price,
  });

  Future<Either<Failure, void>> deleteAppointment({
    required String postId,
  });

  Future<Either<Failure, List<AppointmentDataModel>>> getAppointments();

  Future<Either<Failure, CommunitySessionModel>> createCommunitySession({
    required DateTime startAt,
    required int duration,
    required int price,
    required int seats,
    required String meetLink,
  });
}
