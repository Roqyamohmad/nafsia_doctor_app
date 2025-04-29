import 'package:flutter/material.dart';
import 'package:nafsia_app/core/utils/app_colors.dart';
import 'package:nafsia_app/core/utils/constants.dart';
import 'package:nafsia_app/core/utils/spacing.dart';
import 'package:nafsia_app/core/widgets/custom_post_item.dart'
    show CustomPostItem;
import 'package:nafsia_app/features/Home/presentation/views/widget/add_post_view.dart'
    show AddPostView;
import 'package:nafsia_app/features/Home/presentation/views/widget/custom_home_app_bar.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddPostView()),
            );
          },
          backgroundColor: AppColors.primaryColor,
          child: const Icon(
            Icons.add,
            size: 50,
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
