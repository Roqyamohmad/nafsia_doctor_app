import 'package:flutter/material.dart';

class SeatCounter extends StatelessWidget {
  final int currentSeats;
  final Function(int) onSeatsChanged;

  const SeatCounter({
    Key? key,
    required this.currentSeats,
    required this.onSeatsChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Prevent unnecessary vertical expansion
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_drop_up),
          constraints: const BoxConstraints.tightFor(),
          style: ButtonStyle(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: MaterialStateProperty.all(EdgeInsets.zero),
          ),
          onPressed: () {
            if (currentSeats < 10) {
              onSeatsChanged(currentSeats + 1);
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.arrow_drop_down),
          constraints: const BoxConstraints.tightFor(),
          style: ButtonStyle(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            minimumSize: MaterialStateProperty.all(const Size(0, 0)),
          ),
          onPressed: () {
            if (currentSeats > 1) {
              onSeatsChanged(currentSeats - 1);
            }
          },
        ),
      ],
    );
  }
}
