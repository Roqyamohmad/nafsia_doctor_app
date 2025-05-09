import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafsia_app/core/services/get_it_service.dart';
import 'package:nafsia_app/core/utils/constants.dart';
import 'package:nafsia_app/core/utils/spacing.dart' show verticalSpace;
import 'package:nafsia_app/core/widgets/search_text_field.dart'
    show SearchTextField;
import 'package:nafsia_app/features/Home/data/repos/appointment_repo.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/appointment_cubit/appintment_cubit.dart';
import 'package:nafsia_app/features/Home/presentation/views/chats_view_widgets/empty_chats_list.dart'
    show EmptyChatsList;
import 'package:nafsia_app/features/Home/presentation/views/widget/custom_main_view_app_bar.dart';
import 'package:nafsia_app/features/auth/presentation/views/widget/show_doctor_session_dialog.dart';

class ChatsViewBody extends StatelessWidget {
  const ChatsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kHorizontalPadding,
        vertical: kVerticalPadding,
      ),
      child: Column(
        children: [
          // Scrollable Content
          Expanded(
            child: CustomScrollView(
              slivers: [
                // AppBar Section
                const SliverToBoxAdapter(
                    child: CustomMainViewsAppBar(title: 'المحادثات')),
                SliverToBoxAdapter(child: verticalSpace(16)),

                // Search Bar
                const SliverToBoxAdapter(child: SearchTextField()),
                SliverToBoxAdapter(child: verticalSpace(16)),

                // Empty Chat List Placeholder
                const SliverToBoxAdapter(child: EmptyChatsList()),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (dialogContext) => BlocProvider(
                  create: (context) =>
                      AppointmentCubit(getIt<AppointmentRepo>()),
                  child: const DoctorSessionDialog(),
                ),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('تحديد مواعيد الجلسات'),
          ),
        ],
      ),
    );
  }
}
