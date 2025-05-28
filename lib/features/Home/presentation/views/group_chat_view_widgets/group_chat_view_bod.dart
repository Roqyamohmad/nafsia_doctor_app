import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafsia_app/core/widgets/custom_animated_loading_widget.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/community_session_cubit.dart/community_session_cubit.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/community_session_cubit.dart/community_session_state.dart';
import 'package:nafsia_app/features/Home/presentation/views/appointments_view_widgets/support_groups_view.dart';
import 'package:nafsia_app/features/Home/presentation/views/group_chat_view_widgets/community_session_card.dart';

import 'empty_message.dart';

class GroupChatViewBody extends StatelessWidget {
  const GroupChatViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<CommunitySessionCubit, CommunitySessionState>(
              builder: (context, state) {
                if (state is CommunitySessionLoading) {
                  return const CustomAnimatedLoadingWidget();
                } else if (state is CommunitySessionSuccess) {
                  final sessions = state.sessions;

                  if (sessions.isEmpty) {
                    return const EmptyMessage(message: 'لا توجد جلسات حالياً');
                  }

                  return ListView.separated(
                    itemCount: sessions.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) =>
                        CommunitySessionCard(session: sessions[index]),
                  );
                } else {
                  return const EmptyMessage(message: 'ابدأ بعرض الجلسات');
                }
              },
            ),
          ),

          const SizedBox(height: 12),

          // زر إضافة جلسة دعم
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => showSupportGroupsView(context),
              icon: const Icon(Icons.add),
              label: const Text('إضافة جلسة دعم'),
            ),
          ),
        ],
      ),
    );
  }
}
