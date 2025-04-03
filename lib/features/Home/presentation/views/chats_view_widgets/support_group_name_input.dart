import 'package:flutter/material.dart';

class SupportGroupNameInput extends StatefulWidget {
  const SupportGroupNameInput({super.key});

  @override
  State<SupportGroupNameInput> createState() => _SupportGroupNameInputState();
}

class _SupportGroupNameInputState extends State<SupportGroupNameInput> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "اسم مجموعة الدعم",
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: "أدخل اسم المجموعة هنا...",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          ),
        ),
      ],
    );
  }
}
