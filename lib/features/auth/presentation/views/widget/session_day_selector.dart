import 'package:flutter/material.dart';
import 'package:nafsia_app/core/widgets/custom_drop_down_form_field.dart';

class SessionDaySelector extends StatefulWidget {
  final String? initialDay; // القيمة الحالية ليوم الجلسة
  final Function(String day)? onDaySelected;

  const SessionDaySelector({
    super.key,
    this.initialDay,
    this.onDaySelected,
  });

  @override
  State<SessionDaySelector> createState() => _SessionDaySelectorState();
}

class _SessionDaySelectorState extends State<SessionDaySelector> {
  late String? selectedDay;

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
  void initState() {
    super.initState();
    selectedDay = widget.initialDay; // تعيين اليوم المحدد
  }

  @override
  Widget build(BuildContext context) {
    return CustomDropdownFormField(
      hintText: 'اختر يوم الجلسة',
      items: days,
      value: selectedDay, // اليوم المحدد
      onChanged: (value) {
        setState(() {
          selectedDay = value; // تحديث اليوم عند تغييره
        });
        if (widget.onDaySelected != null && value != null) {
          widget.onDaySelected!(value); // نقل القيمة إلى الوالد
        }
      },
    );
  }
}
