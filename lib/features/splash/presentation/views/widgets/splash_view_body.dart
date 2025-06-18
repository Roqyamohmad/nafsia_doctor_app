import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nafsia_app/core/helper_functions/cache_helper.dart';
import 'package:nafsia_app/core/utils/app_colors.dart';
import 'package:nafsia_app/core/utils/app_images.dart';
import 'package:nafsia_app/core/utils/chache_helper_keys.dart';
import 'package:nafsia_app/features/Home/presentation/views/main_view.dart';
import 'package:nafsia_app/features/auth/data/models/user_model.dart';
import 'package:nafsia_app/features/auth/presentation/views/signin_view.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    super.initState();
    executeNavigation();
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

  void executeNavigation() async {
    await Future.delayed(const Duration(seconds: 3));

    final cachedData = CacheHelper.getData(key: kSaveUserDataKey);

    if (cachedData != null && cachedData is String) {
      try {
        final user = UserModel.fromJson(jsonDecode(cachedData));

        if (user.data?.user?.isVerified == true) {
          // المستخدم مسجل ومفعل
          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, MainView.routeName);
          return;
        }
      } catch (e) {
        debugPrint("Error parsing user data: $e");
      }
    }

    // المستخدم مش مسجل أو البيانات فيها مشكلة
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, SigninView.routeName);
  }
}
