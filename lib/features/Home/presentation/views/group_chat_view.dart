import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafsia_app/core/helper_functions/get_user_data.dart';
import 'package:nafsia_app/core/services/get_it_service.dart';
import 'package:nafsia_app/features/Home/data/repos/appointment_repo.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/community_session_cubit.dart/community_session_cubit.dart';
import 'package:nafsia_app/features/Home/presentation/views/group_chat_view_widgets/group_chat_view_bod.dart';

class GroupChatView extends StatelessWidget {
  const GroupChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommunitySessionCubit(getIt<AppointmentRepo>())
        ..getAllCommunitySessions(
          doctorId: getUserData().data!.user!.id!, // أو جيب ID بطريقة مناسبة
          sessionStatus: 'active',
          sessionType: 'community',
        ),
      child: const GroupChatViewBody(),
    );
  }
}
