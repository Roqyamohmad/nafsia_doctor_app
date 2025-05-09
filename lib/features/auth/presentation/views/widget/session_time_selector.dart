import 'package:flutter/material.dart';
import 'package:nafsia_app/core/helper_functions/pick_time.dart' show pickTime;

class SessionTimeSelector extends StatefulWidget {
  final Function(TimeOfDay startAt, int durationInMinutes) onTimeSelected;
  final TimeOfDay? initialStartAt; // القيمة المبدئية لوقت البداية
  final TimeOfDay? initialTo; // القيمة المبدئية لوقت النهاية

  const SessionTimeSelector({
    super.key,
    required this.onTimeSelected,
    this.initialStartAt, // تمرير وقت البداية المبدئي
    this.initialTo, // تمرير وقت النهاية المبدئي
  });

  @override
  State<SessionTimeSelector> createState() => _SessionTimeSelectorState();
}

class _SessionTimeSelectorState extends State<SessionTimeSelector> {
  late TimeOfDay from;
  late TimeOfDay to;

  @override
  void initState() {
    super.initState();
    // استخدام القيم المبدئية إذا كانت موجودة
    from = widget.initialStartAt ??
        const TimeOfDay(
            hour: 9, minute: 0); // القيم المبدئية أو القيمة الافتراضية
    to = widget.initialTo ??
        const TimeOfDay(
            hour: 10, minute: 0); // القيم المبدئية أو القيمة الافتراضية
  }

  void _updateFrom(TimeOfDay newFrom) {
    setState(() {
      from = newFrom;
    });
    _notifyParent();
  }

  void _updateTo(TimeOfDay newTo) {
    setState(() {
      to = newTo;
    });
    _notifyParent();
  }

  void _notifyParent() {
    final duration = _calculateDurationInMinutes(from, to);
    widget.onTimeSelected(from, duration);
  }

  int _calculateDurationInMinutes(TimeOfDay start, TimeOfDay end) {
    final startMinutes = start.hour * 60 + start.minute;
    final endMinutes = end.hour * 60 + end.minute;
    int duration = endMinutes - startMinutes;
    if (duration < 0) {
      duration += 24 * 60; // handle crossing midnight
    }
    return duration;
  }

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
                onTimeSelected: _updateFrom,
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
                onTimeSelected: _updateTo,
              ),
              child: Text('إلى: ${to.format(context)}'),
            ),
          ),
        ],
      ),
    );
  }
}
