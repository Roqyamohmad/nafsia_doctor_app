import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nafsia_app/features/Home/presentation/views/chats_view_widgets/support_groups_view.dart'
    show SupportGroupsView;
import 'package:nafsia_app/features/Home/presentation/views/main_view.dart'
    show MainView;
import 'package:nafsia_app/features/auth/presentation/views/reset_password_view.dart';
import 'package:nafsia_app/features/auth/presentation/views/signin_view.dart'
    show SigninView;
import 'package:nafsia_app/features/auth/presentation/views/signup_view.dart';

import '../../features/splash/presentation/views/splash_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => const SplashView());
    case SigninView.routeName:
      return MaterialPageRoute(builder: (context) => const SigninView());
    case SignupView.routeName:
      return MaterialPageRoute(builder: (context) => const SignupView());
    case ResetPasswordView.routeName:
      return MaterialPageRoute(builder: (context) => const ResetPasswordView());
    case MainView.routeName:
      return MaterialPageRoute(builder: (context) => const MainView());
    case SupportGroupsView.routename:
      return MaterialPageRoute(builder: (context) => const SupportGroupsView());
    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
