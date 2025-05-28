import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafsia_app/core/services/get_it_service.dart';
import 'package:nafsia_app/features/Home/data/repos/appointment_repo.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/message_cubit/message_cubit.dart';
import 'package:nafsia_app/features/Home/presentation/views/group_chat_view_widgets/doctor_chat_page.dart';
import 'package:nafsia_app/features/Home/presentation/views/group_chat_view_widgets/info_chip.dart';

import '../../../data/model/community_session_model.dart';

class CommunitySessionCard extends StatelessWidget {
  final Data session;

  const CommunitySessionCard({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        final cubit = CommunityMessageCubit(getIt<AppointmentRepo>());

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: cubit,
              child: DoctorChatPage(
                sessionId: session.id,
                sessionTitle: session.title,
              ),
            ),
          ),
        );
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                session.title.trim().isNotEmpty ? session.title : 'بدون عنوان',
                style: theme.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                session.description.trim().isNotEmpty
                    ? session.description
                    : 'لا يوجد وصف',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: Colors.grey[600]),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 6,
                children: [
                  InfoChip(
                    icon: Icons.access_time,
                    label: 'المدة',
                    value: '${session.duration} دقيقة',
                  ),
                  const InfoChip(
                    icon: Icons.attach_money,
                    label: 'السعر',
                    value: "Free",
                  ),
                  InfoChip(
                    icon: Icons.event_seat,
                    label: 'المقاعد',
                    value: '${session.seats}',
                  ),
                  if (session.tags.isNotEmpty)
                    InfoChip(
                      icon: Icons.label,
                      label: 'التصنيفات',
                      value: session.tags.join('، '),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
