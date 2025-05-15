import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/community_session_cubit.dart/community_session_cubit.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/community_session_cubit.dart/community_session_state.dart';
import 'package:nafsia_app/features/Home/data/model/community_session_model.dart';
import 'package:nafsia_app/features/Home/presentation/views/group_chat_view_widgets/doctor_chat_page.dart';

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
                  return const _LoadingIndicator();
                } else if (state is CommunitySessionFailure) {
                  return ErrorMessage(error: state.error);
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
              onPressed: () {
                // هنا ممكن تفتح دايلوج أو تنفذ أي فعل لإضافة جلسة دعم
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('إضافة جلسة دعم جديدة'),
                      content: const Text(
                          'ضع هنا نموذج إضافة جلسة الدعم أو فعل آخر.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('إلغاء'),
                        ),
                        TextButton(
                          onPressed: () {
                            // تنفيذ إضافة الجلسة
                            Navigator.of(context).pop();
                          },
                          child: const Text('إضافة'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('إضافة جلسة دعم'),
            ),
          ),
        ],
      ),
    );
  }
}

// باقي الكلاسات كما هي، بدون تعديل

class CommunitySessionCard extends StatelessWidget {
  final Data session;

  const CommunitySessionCard({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DoctorChatPage(sessionTitle: session.title),
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

class InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoChip({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Chip(
      backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: theme.colorScheme.primary),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              '$label: $value',
              style: theme.textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) =>
      const Center(child: CircularProgressIndicator());
}

class ErrorMessage extends StatelessWidget {
  final String error;

  const ErrorMessage({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'حدث خطأ: $error',
        style: TextStyle(
            color: Theme.of(context).colorScheme.error,
            fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class EmptyMessage extends StatelessWidget {
  final String message;

  const EmptyMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: Theme.of(context).textTheme.titleMedium,
        textAlign: TextAlign.center,
      ),
    );
  }
}
