import 'package:flutter/material.dart';
import 'package:nafsia_app/core/utils/app_colors.dart';
import '../../../../../core/helper_functions/pick_time.dart';

class TimeSelection extends StatelessWidget {
  final TimeOfDay selectedTime;
  final Function(TimeOfDay) onTimeSelected;

  const TimeSelection({
    super.key,
    required this.selectedTime,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backGroundyColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            "وقت الجلسة",
            textAlign: TextAlign.right,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: Align(
          alignment: Alignment.centerRight,
          child: Text("${selectedTime.hour}:${selectedTime.minute}"),
        ),
        leading: const Icon(Icons.access_time, color: Colors.black54),
        onTap: () {
          pickTime(
            context: context,
            selectedTime: selectedTime,
            onTimeSelected: onTimeSelected,
          );
        },
      ),
    );
  }
}
