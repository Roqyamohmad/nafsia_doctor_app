import 'package:flutter/material.dart';
import 'package:nafsia_app/features/Home/presentation/views/widget/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const String route = '/home';

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: HomeViewBody(),
    );
  }
}
