import 'package:flutter/material.dart';
import 'package:nafsia_app/core/utils/app_colors.dart';
import 'package:nafsia_app/core/utils/app_images.dart' show Assets;
import 'package:nafsia_app/core/utils/app_text_styles.dart';

class AppointmentsChatsList extends StatelessWidget {
  const AppointmentsChatsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 22,
                    backgroundImage: AssetImage(
                      Assets.assetsImagesProfileTestImage,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'مريم محمد',
                        style: TextStyles.bold16.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'video call',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.chat_bubble,
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
            ),
          );
        },
        childCount: 5,
      ),
    );
  }
}
