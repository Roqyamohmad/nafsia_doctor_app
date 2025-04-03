import 'package:flutter/material.dart';
import 'package:nafsia_app/features/Home/presentation/views/chats_view_widgets/support_groups_view_body.dart';

class SupportGroupsView extends StatelessWidget {
  const SupportGroupsView({super.key});
  static const routename = 'supportGroup';

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: SupportGroupsViewBody());
  }
}
