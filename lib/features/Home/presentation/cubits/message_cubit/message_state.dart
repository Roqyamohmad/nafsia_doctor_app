import '../../../data/model/community_messages_model.dart'
    show CommunityMessageModel;

abstract class CommunityMessageState {}

class CommunityMessageInitial extends CommunityMessageState {}

class CommunityMessageLoading extends CommunityMessageState {}

class CommunityMessageSuccess extends CommunityMessageState {
  final List<CommunityMessageModel> messages;

  CommunityMessageSuccess(this.messages);
}

class CommunityMessageFailure extends CommunityMessageState {
  final String error;

  CommunityMessageFailure(this.error);
}

class CommunityMessageSent extends CommunityMessageState {
  final CommunityMessageModel message;

  CommunityMessageSent(this.message);
}
