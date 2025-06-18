import 'package:bloc/bloc.dart';
import 'package:nafsia_app/features/Home/data/model/community_session_model.dart';
import 'package:nafsia_app/features/Home/data/repos/appointment_repo.dart';
import 'community_session_state.dart';

class CommunitySessionCubit extends Cubit<CommunitySessionState> {
  CommunitySessionCubit(this.appointmentRepo)
      : super(CommunitySessionInitial());

  final AppointmentRepo appointmentRepo;
  final List<Data> _sessions = [];

  List<Data> get sessions => _sessions;

  Future<void> createCommunitySession({
    required DateTime startAt,
    required int duration,
    required int seats,
    required String meetLink,
    required String title,
    required String description,
    required List<String> tags,
  }) async {
    emit(CommunitySessionLoading());
    final result = await appointmentRepo.createCommunitySession(
      startAt: startAt,
      duration: duration,
      seats: seats,
      meetLink: meetLink,
      title: title,
      description: description,
      tags: tags,
    );

    result.fold(
      (failure) {
        emit(CommunitySessionFailure(failure.message));
      },
      (session) {
        _sessions.add(session);
        emit(CommunitySessionSuccess(List.from(_sessions)));
      },
    );
  }

  Future<void> getCommunitySessionById(String sessionId) async {
    emit(CommunitySessionLoading());
    final result = await appointmentRepo.getCommunitySessionById(sessionId);

    result.fold(
      (failure) => emit(CommunitySessionFailure(failure.message)),
      (session) {
        if (!_sessions.any((s) => s.id == session.id)) {
          _sessions.add(session);
        }
        emit(CommunitySessionSuccess(List.from(_sessions)));
      },
    );
  }

  Future<void> getAllCommunitySessions({
    required String doctorId,
    required String sessionStatus,
    required String sessionType,
  }) async {
    emit(CommunitySessionLoading());

    final result = await appointmentRepo.getAllCommunitySessions(
      doctorId: doctorId,
      sessionStatus: sessionStatus,
      sessionType: sessionType,
    );

    result.fold(
      (failure) {
        emit(CommunitySessionFailure(failure.message));
      },
      (sessionsList) {
        _sessions
          ..clear()
          ..addAll(sessionsList);
        emit(CommunitySessionSuccess(List.from(_sessions)));
      },
    );
  }
}
