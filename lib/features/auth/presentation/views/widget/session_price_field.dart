import 'package:flutter/material.dart';

class SessionPriceField extends StatelessWidget {
  const SessionPriceField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'سعر الجلسة (بالجنيه)',
        border: OutlineInputBorder(),
      ),
    );
  }
}
