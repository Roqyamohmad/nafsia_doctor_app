import 'package:flutter/material.dart';
import 'package:nafsia_app/core/helper_functions/build_error_bar.dart';
import 'package:nafsia_app/core/helper_functions/get_user_data.dart';
import 'package:nafsia_app/core/utils/app_colors.dart';
import 'package:nafsia_app/core/widgets/custom_button.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/more_cubit/more_cubit.dart';

class UpdateUserProfileButton extends StatelessWidget {
  const UpdateUserProfileButton({
    super.key,
    required this.cubit,
  });

  final MoreCubit cubit;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
        backgroundColor:
            cubit.hasChanges ? AppColors.primaryColor : Colors.grey,
        text: 'حفظ',
        onPressed: () {
          cubit.hasChanges
              ? cubit.updateUserProfile(
                  name: cubit.updatedNameController.text ==
                          getUserData().data!.user!.name!
                      ? getUserData().data!.user!.name!
                      : cubit.updatedNameController.text,
                  phone: cubit.updatedPhoneController.text ==
                          getUserData().data!.user!.phone!
                      ? getUserData().data!.user!.phone!
                      : cubit.updatedPhoneController.text,
                  age: int.parse(cubit.updatedAgeController.text ==
                          getUserData().data!.user!.age.toString()
                      ? getUserData().data!.user!.age.toString()
                      : cubit.updatedAgeController.text),
                  specialization: cubit.updatedSpecializationController.text ==
                          getUserData().data!.user!.doctorData!.specialization
                      ? getUserData().data!.user!.doctorData!.specialization
                      : cubit.updatedSpecializationController.text,
                )
              : showBar(context, 'لا يوجد تغييرات');
        });
  }
}
