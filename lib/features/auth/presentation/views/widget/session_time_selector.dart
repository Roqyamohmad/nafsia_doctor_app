import 'package:flutter/material.dart';
import 'package:nafsia_app/core/helper_functions/pick_time.dart' show pickTime;

class SessionTimeSelector extends StatefulWidget {
  const SessionTimeSelector({super.key});

  @override
  State<SessionTimeSelector> createState() => _SessionTimeSelectorState();
}

class _SessionTimeSelectorState extends State<SessionTimeSelector> {
  TimeOfDay from = const TimeOfDay(hour: 9, minute: 0); // Default value
  TimeOfDay to = const TimeOfDay(hour: 17, minute: 0); // Default value

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => pickTime(
                context: context,
                selectedTime: from,
                onTimeSelected: (newTime) {
                  setState(() => from = newTime);
                },
              ),
              child: Text('من: ${from.format(context)}'),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: OutlinedButton(
              onPressed: () => pickTime(
                context: context,
                selectedTime: to,
                onTimeSelected: (newTime) {
                  setState(() => to = newTime);
                },
              ),
              child: Text('إلى: ${to.format(context)}'),
            ),
          ),
        ],
      ),
    );
  }
}
