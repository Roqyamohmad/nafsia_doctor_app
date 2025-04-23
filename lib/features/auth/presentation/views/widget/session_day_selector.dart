import 'package:flutter/material.dart';
import 'package:nafsia_app/core/widgets/custom_drop_down_form_field.dart'; // تأكدي من المسار الصحيح

class SessionDaySelector extends StatefulWidget {
  const SessionDaySelector({super.key});

  @override
  State<SessionDaySelector> createState() => _SessionDaySelectorState();
}

class _SessionDaySelectorState extends State<SessionDaySelector> {
  String? selectedDay;

  final List<String> days = [
    'السبت',
    'الأحد',
    'الاثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
  ];

  @override
  Widget build(BuildContext context) {
    return CustomDropdownFormField(
      hintText: 'اختر يوم الجلسة',
      items: days,
      value: selectedDay,
      onChanged: (value) {
        setState(() => selectedDay = value);
      },
    );
  }
}
