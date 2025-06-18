import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nafsia_app/core/helper_functions/on_generate_routes.dart';
import 'package:nafsia_app/core/services/get_it_service.dart';
import 'package:nafsia_app/core/widgets/timezone_helper.dart';
import 'package:nafsia_app/features/splash/presentation/views/splash_view.dart'
    show SplashView;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'core/helper_functions/cache_helper.dart';
import 'core/utils/app_colors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/utils/bloc_observer.dart';
import 'core/utils/constants.dart';
import 'generated/l10n.dart' show S;
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);
  OneSignal.initialize(kOneSignalAppId);
  OneSignal.Notifications.requestPermission(true);

  await TimezoneHelper.initialize();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  setupGetIt();
  ZegoUIKit().initLog().then((value) {
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );

    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: false,
      child: MaterialApp(
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(1),
            ),
            child: child!,
          );
        },
        navigatorKey: navigatorKey,
        title: 'Nafsia',
        theme: ThemeData(
          fontFamily: 'Cairo',
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
          useMaterial3: true,
        ),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: const Locale('ar'),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: onGenerateRoute,
        initialRoute: SplashView.routeName,
/*,
            CacheHelper.getData(key: kSaveUserDataKey) != null
                ? MainView.routeName
                : SplashView.routeName,
                */
      ),
    );
  }
}
