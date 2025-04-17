import 'package:flutter/material.dart';
import 'package:nafsia_app/core/utils/app_colors.dart';
import 'package:nafsia_app/core/utils/app_text_styles.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key, this.onChanged, this.controller});

  final void Function(String)? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        keyboardType: TextInputType.text,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            size: 30,
            color: AppColors.primaryColor,
          ),
          hintText: 'ابحث عن مريض…',
          hintStyle:
              TextStyles.regular16.copyWith(color: const Color(0xff949D9E)),
          filled: true,
          fillColor: const Color(0xffF9FAFA),
          border: buildBorder(),
          enabledBorder: buildBorder(),
          focusedBorder: buildBorder(),
        ),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Colors.transparent),
    );
  }
}
