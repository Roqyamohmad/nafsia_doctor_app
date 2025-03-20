import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nafsia_app/core/utils/app_text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.textInputType,
    this.suffixIcon,
    this.needsValidation = true,
    this.onSaved,
    this.validator,
    this.obscureText = false,
  });

  final String labelText;
  final TextInputType textInputType;
  final Widget? suffixIcon;
  final void Function(String?)? onSaved;
  final bool obscureText;
  final String? Function(String?)? validator;
  final bool needsValidation;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // Ensures right-aligned text
      child: TextFormField(
        obscureText: obscureText,
        onSaved: onSaved,
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
          label: RichText(
            text: TextSpan(
              text: labelText,
              style: TextStyles.bold13.copyWith(color: const Color(0xff949D9E)),
              children: const [
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                      color: Color.fromARGB(255, 116, 127, 133),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          filled: true,
          fillColor: const Color(0xFFF9FAFA),
          border: buildBorder(),
          enabledBorder: buildBorder(),
          focusedBorder: buildBorder(),
        ),
        textAlign: TextAlign.right,
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
