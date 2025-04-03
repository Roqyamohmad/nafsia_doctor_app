import 'package:flutter/material.dart';
import 'package:nafsia_app/core/utils/app_colors.dart';
import 'package:nafsia_app/core/utils/spacing.dart' show verticalSpace;

class CustomPostActions extends StatelessWidget {
  const CustomPostActions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.favorite_border_outlined,
          color: AppColors.primaryColor,
        ),
      ),
      const Text('125'),
      const Spacer(),
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.add_circle_outline_outlined,
          color: AppColors.primaryColor,
        ),
      ),
      verticalSpace(12),
    ]);
  }
}
