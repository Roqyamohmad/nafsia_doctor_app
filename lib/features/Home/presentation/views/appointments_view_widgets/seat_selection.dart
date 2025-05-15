import 'package:flutter/material.dart';
import 'package:nafsia_app/core/utils/app_colors.dart' show AppColors;
import 'package:nafsia_app/core/utils/app_text_styles.dart';
import 'seat_counter.dart';

class SeatSelection extends StatelessWidget {
  final int selectedSeats;
  final Function(int) onSeatsChanged;

  const SeatSelection({
    super.key,
    required this.selectedSeats,
    required this.onSeatsChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.backGroundyColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SeatCounter(
            currentSeats: selectedSeats,
            onSeatsChanged: onSeatsChanged,
          ),
          Column(
            children: [
              Text("عدد المقاعد", style: TextStyles.bold16),
              Text(
                "$selectedSeats مقعد",
                style: TextStyles.regular16.copyWith(color: Colors.blueGrey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
