import 'package:flutter/material.dart';
import 'package:nafsia_app/core/utils/app_colors.dart';
import 'package:nafsia_app/core/utils/app_images.dart' show Assets;
import 'package:nafsia_app/core/utils/app_text_styles.dart' show TextStyles;
import 'package:nafsia_app/features/Home/presentation/views/profile_view_widgets/edit_profile_view.dart'
    show EditProfileView;
import 'package:nafsia_app/features/Home/presentation/views/widget/custom_main_view_app_bar.dart'
    show CustomMainViewsAppBar;

import 'build_info_tile.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl, // تحديد الاتجاه من اليمين لليسار
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const CustomMainViewsAppBar(
                title: ('الملف الشخصي'),
              ),
              const CircleAvatar(
                radius: 60,
                backgroundImage:
                    AssetImage(Assets.assetsImagesProfileTestImage),
              ),
              const SizedBox(height: 16),
              const Text(
                'د. أحمد علي',
                style: TextStyles.bold28,
              ),
              const SizedBox(height: 4),
              const Text(
                'ahmed.ali@email.com',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const EditProfileView(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                label: const Text(
                  'تعديل الملف الشخصي',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  backgroundColor: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              buildInfoTile(Icons.phone, 'رقم الجوال', '+966 512345678'),
              buildInfoTile(Icons.work, 'الوظيفة', 'أخصائي نفسي'),
              buildInfoTile(Icons.location_on, 'العنوان', 'الرياض - السعودية'),
              buildInfoTile(Icons.language, 'اللغة', 'العربية'),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
