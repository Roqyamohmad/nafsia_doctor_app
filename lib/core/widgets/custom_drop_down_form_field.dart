import 'package:flutter/material.dart';

import '../utils/app_text_styles.dart';

class CustomDropdownFormField extends StatelessWidget {
  final String hintText;
  final List<String> items;
  final String? value;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? contentPadding;
  final bool needsValidation;

  const CustomDropdownFormField({
    super.key,
    required this.hintText,
    required this.items,
    this.value,
    this.onChanged,
    this.validator,
    this.contentPadding,
    this.needsValidation = true,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DropdownButtonFormField<String>(
        value: value,
        validator: needsValidation
            ? validator ??
                (val) {
                  if (val == null || val.isEmpty) {
                    return 'هذا الحقل مطلوب';
                  }
                  return null;
                }
            : null,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyles.bold13.copyWith(
            color: const Color.fromARGB(255, 116, 127, 133),
          ),
          contentPadding: contentPadding,
          filled: true,
          fillColor: const Color(0xffF9FAFA),
          border: buildBorder(16),
          enabledBorder: buildBorder(16),
          focusedBorder: buildBorder(16),
        ),
        items: items
            .map((String gender) => DropdownMenuItem(
              alignment: Alignment.centerRight,
                  value: gender,
                  child: Text(
                    gender,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 116, 127, 133),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  OutlineInputBorder buildBorder(double? borderRadius) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          borderRadius ?? 4.0,
        ),
        borderSide: const BorderSide(color: Color(0xffE6E9E9)));
  }
}
