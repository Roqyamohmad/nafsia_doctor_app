import 'package:flutter/material.dart';
import 'package:nafsia_app/core/utils/app_colors.dart';
import 'package:nafsia_app/core/utils/app_text_styles.dart' show TextStyles;

class CustomMainViewsAppBar extends StatelessWidget {
  final String title;
  final bool showBack;

  const CustomMainViewsAppBar({
    super.key,
    required this.title,
    this.showBack = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showBack)
            IconButton(
              icon: const Icon(Icons.arrow_back_ios,
                  color: AppColors.primaryColor),
              onPressed: () => Navigator.pop(context),
            )
          else
            const SizedBox(width: 48), // يعادل حجم الأيقونة للحفاظ على التمركز
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyles.bold23.copyWith(color: AppColors.primaryColor),
            ),
          ),
          const SizedBox(width: 48), // لإبقاء العنوان في المنتصف
        ],
      ),
    );
  }
}
