import 'package:nafsia_app/features/Home/data/repos/appointment_repo.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/community_session_cubit.dart/community_session_state.dart';
import 'package:bloc/bloc.dart';

class CommunitySessionCubit extends Cubit<CommunitySessionState> {
  CommunitySessionCubit(this.appointmentRepo)
      : super(CommunitySessionInitial());
  final AppointmentRepo appointmentRepo;
  Future<void> createCommunitySession({
    required DateTime startAt,
    required int duration,
    required int price,
    required int seats,
    required String meetLink,
  }) async {
    emit(CommunitySessionLoading());
    final result = await appointmentRepo.createCommunitySession(
      startAt: startAt,
      duration: duration,
      price: price,
      seats: seats,
      meetLink: meetLink,
    );

    result.fold(
      (failure) {
        emit(CommunitySessionFailure(failure.message));
      },
      (session) {
        emit(CommunitySessionSuccess(session));
      },
    );
  }
}
