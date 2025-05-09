import 'package:flutter/material.dart';
import 'package:nafsia_app/features/Home/presentation/views/change_appointment_view.dart';
import 'package:nafsia_app/features/Home/presentation/views/change_password_view.dart';

import 'package:nafsia_app/features/Home/presentation/views/main_view.dart'
    show MainView;
import 'package:nafsia_app/features/Home/presentation/views/profile_view.dart';
import 'package:nafsia_app/features/auth/presentation/views/forget_password_view.dart';
import 'package:nafsia_app/features/auth/presentation/views/signin_view.dart'
    show SigninView;
import 'package:nafsia_app/features/auth/presentation/views/signup_view.dart';

import '../../features/auth/presentation/views/Verify_otp_view.dart';
import '../../features/auth/presentation/views/reset_password_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => const SplashView());
    case SigninView.routeName:
      return MaterialPageRoute(builder: (context) => const SigninView());
    case SignupView.routeName:
      return MaterialPageRoute(builder: (context) => const SignupView());
    case MainView.routeName:
      return MaterialPageRoute(builder: (context) => const MainView());
    case ForgetPasswordView.route:
      return MaterialPageRoute(
          builder: (context) => const ForgetPasswordView());
    case VerifyOtpView.route:
      final email = settings.arguments as String;
      return MaterialPageRoute(
          builder: (context) => VerifyOtpView(email: email));
    case ResetPasswordView.routeName:
      final opt = settings.arguments as String;
      return MaterialPageRoute(
          builder: (context) => ResetPasswordView(
                otp: opt,
              ));
    case ProfileView.routename:
      return MaterialPageRoute(builder: (context) => const ProfileView());
    case ChangeAppointmentView.routeName:
      return MaterialPageRoute(
          builder: (context) => const ChangeAppointmentView());

    case ChangePasswordView.routename:
      return MaterialPageRoute(
          builder: (context) => const ChangePasswordView());
    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
