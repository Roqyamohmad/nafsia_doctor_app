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
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                // Chat icon
                const Icon(Icons.chat_bubble, color: AppColors.primaryColor),

                const SizedBox(width: 12),

                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'مريم محمد',
                        style: TextStyles.bold16
                            .copyWith(color: AppColors.primaryColor),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'video call',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // Profile image
                const CircleAvatar(
                    radius: 22,
                    backgroundImage: AssetImage(
                      Assets.assetsImagesProfileTestImage,
                    )),
              ],
            ),
          );
        },
        childCount: 5,
      ),
    );
  }
}
