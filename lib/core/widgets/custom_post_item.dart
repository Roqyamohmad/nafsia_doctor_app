import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafsia_app/core/utils/app_text_styles.dart';
import 'package:nafsia_app/core/utils/spacing.dart' show verticalSpace;
import 'package:nafsia_app/core/widgets/custom_doctor_post_details.dart';
import 'package:nafsia_app/core/widgets/custom_post_image.dart'
    show CustomPostImage;
import 'package:nafsia_app/features/Home/data/model/post_model.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/home_cubit/home_cubit.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/home_cubit/home_state.dart';
import 'package:nafsia_app/features/Home/presentation/views/widget/add_post_view.dart';

import '../helper_functions/get_user_data.dart';
import 'custom_box_decoration.dart';

class CustomPostItem extends StatelessWidget {
  final PostModel postModel;
  const CustomPostItem({
    super.key,
    required this.postModel,
  });

  @override
  Widget build(BuildContext context) {
    final currentUserId =
        getUserData().data?.user?.id; // لازم تتأكد دي موجودة عندك ✅
    final isMyPost = currentUserId == postModel.doctor.id;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: customBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomDoctorPostDetails(
                    doctorData: postModel.doctor,
                    createdAt: postModel.createdAt,
                  ),
                ),
                // أزرار تعديل/حذف تظهر فقط إذا كان المستخدم هو صاحب البوست
                if (isMyPost)
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddPostView(
                                  existingPost: postModel,
                                  homeCubit: context.read<HomeCubit>()),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          confirmdelete(context);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            verticalSpace(12),
            Text(
              postModel.title,
              style: TextStyles.bold16,
            ),
            verticalSpace(8),
            Text(
              postModel.content,
              style: TextStyles.regular16,
            ),
            verticalSpace(16),
            if (postModel.images.isNotEmpty)
              CustomPostImage(
                imagePath: postModel.images.first.secureUrl,
              ),
            verticalSpace(12),
            /*
            CustomPostActions(postModel: postModel),
            */
          ],
        ),
      ),
    );
  }

  Future<dynamic> confirmdelete(BuildContext context) {
    return showDialog(
      context: context,
      builder: (dialogContext) => BlocListener<HomeCubit, HomeState>(
        bloc: context.read<HomeCubit>(), // هنا السر 👈
        listener: (context, state) {
          if (state is DeletePostSuccessState) {
            Navigator.pop(
                dialogContext); // نستخدم dialogContext مش context الأصلي
            ScaffoldMessenger.of(dialogContext).showSnackBar(
              const SnackBar(content: Text('تم حذف المنشور بنجاح')),
            );
          } else if (state is DeletePostFailureState) {
            ScaffoldMessenger.of(dialogContext).showSnackBar(
              SnackBar(content: Text('فشل حذف المنشور')),
            );
          }
        },
        child: AlertDialog(
          title: const Text('تأكيد الحذف'),
          content: const Text('هل أنت متأكد من حذف المنشور؟'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                context.read<HomeCubit>().deletePost(postId: postModel.id);
              },
              child: const Text('حذف'),
            ),
          ],
        ),
      ),
    );
  }
}
