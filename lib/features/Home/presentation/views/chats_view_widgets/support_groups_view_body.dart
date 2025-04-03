import 'package:flutter/material.dart';
import 'package:nafsia_app/core/utils/app_colors.dart';
import 'package:nafsia_app/features/Home/presentation/views/chats_view_widgets/seat_selection.dart';
import 'package:nafsia_app/features/Home/presentation/views/chats_view_widgets/support_group_name_input.dart'
    show SupportGroupNameInput;

class SupportGroupsViewBody extends StatelessWidget {
  const SupportGroupsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backGroundyColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SupportGroupNameInput(),
            SizedBox(height: 20),
            SeatSelection(),
          ],
        ),
      ),
    );
  }
}
