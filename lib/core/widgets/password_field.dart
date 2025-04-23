import 'package:flutter/material.dart';

import '../utils/app_text_styles.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    this.onSaved,
  });

  final void Function(String?)? onSaved;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        obscureText: obscureText,
        onSaved: widget.onSaved,
        //hintText: 'كلمة المرور',
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () {
              obscureText = !obscureText;
              setState(() {});
            },
            child: obscureText
                ? const Icon(
                    Icons.remove_red_eye,
                    color: Color(0xffC9CECF),
                  )
                : const Icon(
                    Icons.visibility_off,
                    color: Color(0xffC9CECF),
                  ),
          ),
          label: RichText(
            text: TextSpan(
              text: 'كلمة المرور',
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
