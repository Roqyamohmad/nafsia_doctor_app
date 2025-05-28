import 'package:bloc/bloc.dart';
import 'package:nafsia_app/features/Home/data/model/community_messages_model.dart';
import 'package:nafsia_app/features/Home/data/repos/appointment_repo.dart';

import 'message_state.dart';

class CommunityMessageCubit extends Cubit<CommunityMessageState> {
  final AppointmentRepo appointmentRepo;
  final List<CommunityMessageModel> _messages = [];

  CommunityMessageCubit(this.appointmentRepo)
      : super(CommunityMessageInitial());

  List<CommunityMessageModel> get messages => _messages;

  // إرسال رسالة جديدة
  Future<void> sendMessage({
    required String sessionId,
    required String message,
  }) async {
    emit(CommunityMessageLoading());

    final result = await appointmentRepo.addMessages(
      sessionId: sessionId,
      message: message,
    );

    result.fold(
      (failure) => emit(CommunityMessageFailure(failure.message)),
      (newMessage) {
        _messages.insert(0, newMessage); // بدلاً من add

        emit(CommunityMessageSent(newMessage));
        emit(CommunityMessageSuccess(List.from(_messages)));
      },
    );
  }

  // جلب جميع الرسائل
  Future<void> getAllMessages({required String sessionId}) async {
    emit(CommunityMessageLoading());

    final result = await appointmentRepo.getAllMessages(sessionId: sessionId);

    result.fold(
      (failure) => emit(CommunityMessageFailure(failure.message)),
      (fetchedMessages) {
        _messages
          ..clear()
          ..addAll(fetchedMessages);
        emit(CommunityMessageSuccess(List.from(_messages)));
      },
    );
  }

  // حذف رسالة
  Future<void> deleteMessage({required String messageId}) async {
    emit(CommunityMessageLoading());

    final result = await appointmentRepo.deleteMessage(messageId: messageId);

    result.fold(
      (failure) => emit(CommunityMessageFailure(failure.message)),
      (_) {
        _messages.removeWhere((msg) => msg.id == messageId);
        emit(CommunityMessageSuccess(List.from(_messages)));
      },
    );
  }

  // تعديل رسالة
  Future<void> updateMessage({
    required String messageId,
    required String newMessage,
  }) async {
    emit(CommunityMessageLoading());

    final result = await appointmentRepo.updateMessage(
      messageId: messageId,
      updatedMessage: newMessage,
    );

    result.fold(
      (failure) => emit(CommunityMessageFailure(failure.message)),
      (success) {
        final index = _messages.indexWhere((msg) => msg.id == messageId);
        if (index != -1) {
          _messages[index] = _messages[index].copyWith(message: newMessage);
        }
        emit(CommunityMessageSuccess(List.from(_messages)));
      },
    );
  }
}
