import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:nafsia_app/core/helper_functions/pick_seat.dart' show pickSeats;

class SeatSelection extends StatefulWidget {
  const SeatSelection({super.key});

  @override
  State<SeatSelection> createState() => _SeatSelectionState();
}

class _SeatSelectionState extends State<SeatSelection> {
  int selectedSeats = 1;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("عدد المقاعد"),
      subtitle: Text("$selectedSeats مقعد"),
      trailing: const Icon(Icons.arrow_drop_down),
      onTap: () {
        pickSeats(
          context: context,
          selectedSeats: selectedSeats,
          onSeatsSelected: (value) {
            setState(() => selectedSeats = value);
          },
        );
      },
    );
  }
}
