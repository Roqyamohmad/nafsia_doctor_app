import 'package:flutter/material.dart';
import 'package:nafsia_app/core/utils/app_text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.textInputType,
    this.suffixIcon,
    this.onChanged,
    this.needsValidation = true,
    this.onSaved,
    this.validator,
    this.controller,
    this.maxLines,
    this.minLines,
    this.showAsterisk = true,
    this.textAlign = TextAlign.right,
  });

  final String labelText;
  final TextEditingController? controller;
  final TextInputType textInputType;
  final Widget? suffixIcon;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final bool needsValidation;
  final int? maxLines;
  final int? minLines;
  final bool showAsterisk;
  final TextAlign textAlign;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        minLines: minLines,
        maxLines: maxLines,
        controller: controller,
        onSaved: onSaved,
        onChanged: onChanged,
        validator: needsValidation
            ? validator ??
                (value) {
                  if (value == null || value.isEmpty) {
                    return 'هذا الحقل مطلوب';
                  }
                  return null;
                }
            : null,
        keyboardType: textInputType,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          labelText: showAsterisk ? '$labelText *' : labelText,
          labelStyle:
              TextStyles.bold13.copyWith(color: const Color(0xff949D9E)),
          filled: true,
          fillColor: const Color(0xFFF9FAFA),
          border: buildBorder(),
          enabledBorder: buildBorder(),
          focusedBorder: buildBorder(),
        ),
        textAlign: textAlign,
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        width: 1,
        color: Color(0xFFE6E9E9),
      ),
    );
  }
}
