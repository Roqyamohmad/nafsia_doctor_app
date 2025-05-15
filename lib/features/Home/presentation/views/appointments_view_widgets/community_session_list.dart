import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafsia_app/core/utils/app_colors.dart';
import 'package:nafsia_app/core/utils/app_text_styles.dart' show TextStyles;
import 'package:nafsia_app/features/Home/presentation/cubits/community_session_cubit.dart/community_session_cubit.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/community_session_cubit.dart/community_session_state.dart';

class CommunitySessionList extends StatelessWidget {
  const CommunitySessionList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunitySessionCubit, CommunitySessionState>(
      builder: (context, state) {
        if (state is CommunitySessionLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CommunitySessionSuccess) {
          final sessions = state.sessions;

          if (sessions.isEmpty) {
            // ✅ واجهة لا يوجد جلسات
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.group_off, size: 80, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    "لا توجد جلسات دعم حاليًا",
                    style: TextStyles.bold16
                        .copyWith(color: AppColors.primaryColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "ابدأ بإضافة جلسة جديدة الآن وشجع الآخرين على المشاركة.",
                    style: TextStyles.medium15
                        .copyWith(color: Colors.grey.shade600),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                    ),
                    onPressed: () {
                      // TODO: افتح شاشة إنشاء الجلسة
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("إنشاء جلسة دعم"),
                  )
                ],
              ),
            );
          }

          // ✅ الجلسات موجودة
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("جلسات الدعم",
                    style: TextStyles.bold16
                        .copyWith(color: AppColors.primaryColor)),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 170,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: sessions.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final session = sessions[index];

                    return Container(
                      width: 270,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.group, color: Colors.blue),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  session.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.timer,
                                  size: 20, color: Colors.orange),
                              const SizedBox(width: 6),
                              Text("المدة: ${session.duration} دقيقة"),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.attach_money,
                                  size: 20, color: Colors.green),
                              const SizedBox(width: 6),
                              Text("السعر: ${session.price} جنيه"),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.event_seat,
                                  size: 20, color: Colors.purple),
                              const SizedBox(width: 6),
                              Text("المقاعد: ${session.seats}"),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else if (state is CommunitySessionFailure) {
          return Center(child: Text("خطأ: ${state.error}"));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
