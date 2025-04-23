import 'package:flutter/material.dart';
import 'package:nafsia_app/core/utils/app_colors.dart';
import 'package:nafsia_app/core/utils/app_text_styles.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: const Text(
            'الإشعارات',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: 5, // عدد الإشعارات الوهمية
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              leading: const Icon(Icons.notifications_active_outlined,
                  color: AppColors.primaryColor),
              title: Text(
                'إشعار رقم ${index + 1}',
                style: TextStyles.bold16,
                textDirection: TextDirection.rtl,
              ),
              subtitle: const Text(
                'هذا هو نص الإشعار الذي يوضح للمستخدم تفاصيل معينة.',
                textDirection: TextDirection.rtl,
              ),
              onTap: () {
                // يمكن وضع تنقل أو أي شيء هنا
              },
            );
          },
        ),
      ),
    );
  }
}
