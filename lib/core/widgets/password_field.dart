import 'package:flutter/material.dart';
import '../utils/app_text_styles.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    this.controller,
    this.onChanged,
    this.onSaved,
    this.needsValidation = true,
    this.validator,
    this.labelText = 'كلمة المرور',
  });

  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final bool needsValidation;
  final String labelText;
  final String? Function(String?)? validator;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = true;
  final _pattern = r'^(?=.*[0-9])(?=.*[!@#\$&*~])(?=.*[A-Za-z]).{8,}$';

  String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) return 'هذا الحقل مطلوب';
    if (!RegExp(_pattern).hasMatch(value)) {
      return 'يجب أن تحتوي كلمة المرور 8+ أحرف، رقم واحد، ورمز خاص واحد';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        controller: widget.controller,
        obscureText: obscureText,
        onChanged: widget.onChanged,
        onSaved: widget.onSaved,
        validator: widget.needsValidation
            ? (widget.validator ?? _defaultValidator)
            : null,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () => setState(() => obscureText = !obscureText),
            child: Icon(
              obscureText ? Icons.remove_red_eye : Icons.visibility_off,
              color: const Color(0xffC9CECF),
            ),
          ),
          label: RichText(
            text: TextSpan(
              text: widget.labelText,
              style: TextStyles.bold13.copyWith(color: const Color(0xff949D9E)),
              children: const [
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Color.fromARGB(255, 116, 127, 133),
                    fontWeight: FontWeight.bold,
                  ),
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

  OutlineInputBorder buildBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(width: 1, color: Color(0xFFE6E9E9)),
      );
}
