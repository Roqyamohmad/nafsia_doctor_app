import 'package:flutter/material.dart';
import 'package:nafsia_app/core/utils/app_colors.dart';
import 'package:nafsia_app/core/utils/app_images.dart';
import 'package:nafsia_app/features/auth/presentation/views/signin_view.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    excuteNaviagtion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundyColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 470,
              height: 270,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle, // يجعلها دائرية
                image: DecorationImage(
                  image: AssetImage(Assets.assetsImagesIconSpla),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Text(
              'نفسية',
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 80,
                  fontWeight: FontWeight.w800),
            ),
            const Text(
              'اهتم بصحتك',
              style: TextStyle(
                  color: AppColors.primaryColor,
                  letterSpacing: 8,
                  fontSize: 40,
                  fontWeight: FontWeight.w800),
            )
          ],
        ),
      ),
    );
  }

  void excuteNaviagtion() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, SigninView.routeName);
    });
  }
}
