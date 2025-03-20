import 'package:flutter/material.dart';
import 'package:nafsia_app/core/utils/app_colors.dart' show AppColors;
import 'package:nafsia_app/core/utils/app_images.dart';
import '../../../../../core/utils/app_text_styles.dart' show TextStyles;

class LoginViewBodyLogoAndTitle extends StatelessWidget {
  const LoginViewBodyLogoAndTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 202.03,
          height: 145.69,
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
              image: AssetImage(Assets.assetsImagesIconSpla),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyles.bold28
                  .copyWith(color: AppColors.primaryColor, fontSize: 36),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }
}
