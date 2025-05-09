import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nafsia_app/core/helper_functions/custom_quick_alret_view.dart';
import 'package:nafsia_app/core/utils/app_text_styles.dart';
import 'package:nafsia_app/core/utils/spacing.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/more_cubit/more_cubit.dart';
import 'package:nafsia_app/features/Home/presentation/views/change_appointment_view.dart';
import 'package:nafsia_app/features/Home/presentation/views/change_password_view.dart';
import 'package:nafsia_app/features/Home/presentation/views/profile_view.dart';
import 'package:nafsia_app/features/Home/presentation/views/profile_view_widgets/custom_more_view_list_tile_item.dart';
import 'package:nafsia_app/features/auth/presentation/views/signin_view.dart';
import 'package:quickalert/models/quickalert_type.dart';
import '../../../../../core/utils/app_colors.dart';

class CustomMoreViewListTileActions extends StatelessWidget {
  const CustomMoreViewListTileActions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomMoreViewListTileItem(
              title: Text(
                'تعديل الملف الشخصي',
                style: TextStyles.bold16,
              ),
              leading: const Icon(
                Icons.person,
                color: AppColors.primaryColor,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.primaryColor,
              ),
              onTap: () => Navigator.pushNamed(context, ProfileView.routename)),
          const Divider(),
          CustomMoreViewListTileItem(
              title: Text(
                'تغيير كلمة المرور',
                style: TextStyles.bold16,
              ),
              leading: const Icon(
                Icons.lock,
                color: AppColors.primaryColor,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.primaryColor,
              ),
              onTap: () =>
                  Navigator.pushNamed(context, ChangePasswordView.routename)),

          const Divider(),
          CustomMoreViewListTileItem(
              title: Text(
                'تعديل المواعيد ',
                style: TextStyles.bold16,
              ),
              leading: const Icon(
                Icons.edit,
                color: AppColors.primaryColor,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.primaryColor,
              ),
              onTap: () => Navigator.pushNamed(
                  context, ChangeAppointmentView.routeName)),

          const Divider(),

          // Log Out
          CustomMoreViewListTileItem(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: Text('تسجيل الخروج',
                style: TextStyles.bold16.copyWith(color: Colors.red)),
            onTap: () {
              customQuickAlertView(
                context,
                text: 'هل تريد تسجيل الخروج؟',
                title: 'تسجيل الخروج',
                confirmBtnText: 'نعم',
                showCancelBtn: true,
                type: QuickAlertType.warning,
                onConfirmBtnTap: () async {
                  await context.read<MoreCubit>().logOut();
                  Navigator.of(context)
                      .pushReplacementNamed(SigninView.routeName);
                },
              );
            },
          ),
          const Divider(),

          // Delete Account
          CustomMoreViewListTileItem(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: Text('حذف الحساب',
                style: TextStyles.bold16.copyWith(color: Colors.red)),
            onTap: () {
              customQuickAlertView(
                context,
                text: 'هل تريد حذف الحساب؟',
                title: 'حذف الحساب',
                confirmBtnText: 'نعم',
                showCancelBtn: true,
                type: QuickAlertType.warning,
                onConfirmBtnTap: () async {
                  await context.read<MoreCubit>().logOut();
                  Navigator.of(context)
                      .pushReplacementNamed(SigninView.routeName);
                },
              );
            },
          ),
          verticalSpace(24.h)
        ],
      ),
    );
  }
}
