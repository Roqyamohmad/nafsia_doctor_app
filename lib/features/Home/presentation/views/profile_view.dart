import 'package:flutter/material.dart';
import 'package:nafsia_app/features/Home/presentation/views/profile_view_widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: ProfileViewBody(),
    );
  }
}
