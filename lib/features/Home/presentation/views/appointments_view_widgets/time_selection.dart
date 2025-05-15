import 'package:flutter/material.dart';
import 'package:nafsia_app/core/utils/app_colors.dart';
import '../../../../../core/helper_functions/pick_time.dart';

class TimeSelection extends StatelessWidget {
  final TimeOfDay selectedTime;
  final Function(TimeOfDay) onTimeSelected;
  final String label;

  const TimeSelection({
    super.key,
    required this.selectedTime,
    required this.onTimeSelected,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pickTime(
          context: context,
          selectedTime: selectedTime,
          onTimeSelected: onTimeSelected,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.backGroundyColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const Icon(Icons.access_time, size: 16, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}
