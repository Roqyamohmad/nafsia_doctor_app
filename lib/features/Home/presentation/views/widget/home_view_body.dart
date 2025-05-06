import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:nafsia_app/core/helper_functions/build_error_bar.dart';
import 'package:nafsia_app/core/utils/app_colors.dart';
import 'package:nafsia_app/core/utils/spacing.dart';
import 'package:nafsia_app/core/widgets/custom_post_item.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/home_cubit/home_cubit.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/home_cubit/home_state.dart';
import 'package:nafsia_app/features/Home/presentation/views/widget/add_post_view.dart';
import 'package:nafsia_app/features/Home/presentation/views/widget/custom_home_app_bar.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddPostView(homeCubit: context.read<HomeCubit>()),
            ),
          );
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add, size: 50, color: Colors.white),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: CustomHomeAppBar(),
            ),
          ),
          SliverToBoxAdapter(
            child: verticalSpace(16),
          ),
          SliverToBoxAdapter(
            child: BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {
                // مفيش حاجة هنا خلاص 😊
              },
              buildWhen: (previous, current) =>
                  current is GetAllPostsLoadingState ||
                  current is GetAllPostsSuccessState ||
                  current is GetAllPostsFailureState,
              builder: (context, state) {
                if (state is GetAllPostsSuccessState) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.posts.length,
                    itemBuilder: (context, index) => CustomPostItem(
                      postModel: state.posts[index],
                    ),
                  );
                } else if (state is GetAllPostsFailureState) {
                  return Center(
                    child: Text(state.errorMessage),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
