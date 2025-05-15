import 'package:nafsia_app/features/Home/data/model/community_session_model.dart';

abstract class CommunitySessionState {}

class CommunitySessionInitial extends CommunitySessionState {}

class CommunitySessionLoading extends CommunitySessionState {}

class CommunitySessionSuccess extends CommunitySessionState {
  final List<Data> sessions;

  CommunitySessionSuccess(this.sessions);
}

class CommunitySessionFailure extends CommunitySessionState {
  final String error;

  CommunitySessionFailure(this.error);
}
