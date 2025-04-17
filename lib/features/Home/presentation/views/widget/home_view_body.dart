import 'package:flutter/material.dart';
import 'package:nafsia_app/core/utils/app_colors.dart';
import 'package:nafsia_app/core/utils/constants.dart';
import 'package:nafsia_app/core/utils/spacing.dart';
import 'package:nafsia_app/core/widgets/custom_post_item.dart'
    show CustomPostItem;
import 'package:nafsia_app/features/Home/presentation/views/widget/custom_home_app_bar.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        width: 40,
        height: 40,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.primaryColor,
          child: const Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: kHorizontalPadding, vertical: kVerticalPadding),
              child: CustomHomeAppBar(),
            ),
          ),
          SliverToBoxAdapter(
            child: verticalSpace(16),
          ),
          SliverList.builder(
            itemBuilder: (context, index) => const CustomPostItem(),
            itemCount: 10,
          ),
        ],
      ),
    );
  }
}
