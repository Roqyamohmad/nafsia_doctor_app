import 'package:flutter/material.dart';
import 'package:nafsia_app/core/utils/constants.dart';
import 'package:nafsia_app/core/utils/spacing.dart' show verticalSpace;
import 'package:nafsia_app/core/widgets/search_text_field.dart';
import 'package:nafsia_app/features/Home/domain/entities/support_group_entity.dart';
import 'package:nafsia_app/features/Home/presentation/views/appointments_view_widgets/support_groups_list.dart';
import 'package:nafsia_app/features/Home/presentation/views/chats_view_widgets/support_groups_view.dart';
import 'package:nafsia_app/features/Home/presentation/views/widget/custom_main_view_app_bar.dart'
    show CustomMainViewsAppBar;
import 'package:nafsia_app/features/Home/presentation/views/appointments_view_widgets/appointments_chats_list.dart';

class AppointmentsViewBody extends StatefulWidget {
  const AppointmentsViewBody({super.key});

  @override
  State<AppointmentsViewBody> createState() => _AppointmentsViewBodyState();
}

class _AppointmentsViewBodyState extends State<AppointmentsViewBody> {
  final List<SupportGroupDataEntity> supportGroups = [];

  Future<void> _addSupportGroup() async {
    final group = await showSupportGroupsView(context);
    if (group != null) {
      setState(() {
        supportGroups.add(group);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kHorizontalPadding,
        vertical: kVerticalPadding,
      ),
      child: Column(
        children: [
          // المحتوى القابل للتمرير
          Expanded(
            child: CustomScrollView(
              slivers: [
                // AppBar
                const SliverToBoxAdapter(
                    child: CustomMainViewsAppBar(title: 'المواعيد')),
                SliverToBoxAdapter(child: verticalSpace(16)),

                // شريط البحث
                const SliverToBoxAdapter(child: SearchTextField()),
                SliverToBoxAdapter(child: verticalSpace(16)),

                // قائمة المحادثات
                const AppointmentsChatsList(),

                // قائمة مجموعات الدعم
                SliverToBoxAdapter(
                  child: SupportGroupsList(supportGroups: supportGroups),
                ),
                SliverToBoxAdapter(child: verticalSpace(16)),
              ],
            ),
          ),

          // زر الإضافة
          ElevatedButton.icon(
            onPressed: _addSupportGroup,
            icon: const Icon(Icons.add),
            label: const Text("إضافة جلسة دعم"),
          ),
        ],
      ),
    );
  }
}
