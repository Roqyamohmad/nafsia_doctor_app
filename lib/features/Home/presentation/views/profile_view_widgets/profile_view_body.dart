import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafsia_app/core/helper_functions/build_error_bar.dart';
import 'package:nafsia_app/core/helper_functions/get_user_data.dart';
import 'package:nafsia_app/core/utils/constants.dart';
import 'package:nafsia_app/core/utils/spacing.dart';
import 'package:nafsia_app/core/widgets/custom_animated_loading_widget.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/more_cubit/more_cubit.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/more_cubit/more_state.dart';
import 'package:nafsia_app/features/Home/presentation/views/profile_view_widgets/update_user_profile_button.dart';
import 'package:nafsia_app/features/Home/presentation/views/profile_view_widgets/update_user_profiles_text_fields.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  @override
  void initState() {
    var cubit = context.read<MoreCubit>();
    cubit.updatedNameController.text = getUserData().data!.user!.name!;
    cubit.updatedPhoneController.text = getUserData().data!.user!.phone!;
    cubit.updatedSpecializationController.text =
        getUserData().data!.user!.doctorData!.specialization;
    cubit.updatedAgeController.text = getUserData().data!.user!.age.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<MoreCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kHorizontalPadding, vertical: kVerticalPadding),
      child: BlocConsumer<MoreCubit, MoreState>(
        listener: (context, state) {
          if (state is UpdateUserProfileSuccessState) {
            showBar(context, 'تم التعديل بنجاح');
          } else if (state is UpdateUserProfileFailureState) {
            showBar(context, state.errorMessage);
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              verticalSpace(24),
              UpdateUserProfileTextFields(cubit: cubit),
              verticalSpace(48),
              state is UpdateUserProfileLoadingState
                  ? const Center(child: CustomAnimatedLoadingWidget())
                  : UpdateUserProfileButton(cubit: cubit),
            ],
          );
        },
      ),
    );
  }
}
