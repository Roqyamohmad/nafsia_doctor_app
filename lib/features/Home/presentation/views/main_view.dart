import 'package:flutter/material.dart';
import 'package:nafsia_app/core/helper_functions/get_user_data.dart';
import 'package:nafsia_app/core/services/zego_service.dart';
import 'package:nafsia_app/features/Home/presentation/views/appointments_view.dart';
import 'package:nafsia_app/features/Home/presentation/views/chats_view.dart'
    show ChatsView;
import 'package:nafsia_app/features/Home/presentation/views/group_chat_view.dart';
import 'package:nafsia_app/features/Home/presentation/views/home_view.dart'
    show HomeView;
import 'package:nafsia_app/features/Home/presentation/views/more_view.dart';
import 'package:nafsia_app/features/Home/presentation/views/widget/custom_buttom_navigation_bar.dart';

//import 'profile_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});
  static const routeName = 'mainView';

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int selectedIndex = 0;
  @override
  initState() {
    initializeZego(
      getUserData().data!.user!.id!,
      getUserData().data!.user!.name!,
    );
    super.initState();
  }

  bool isZegoInitialized = false;

  void _onItemTapped(int index) async {
    // If user is navigating to the Chats tab (index 1)
    if (index == 1 && !isZegoInitialized) {
      final user = getUserData().data!.user!;

      try {
        await initializeZego(user.id!, user.name!);
        isZegoInitialized = true; // Mark as initialized
      } catch (e) {
        debugPrint("Zego Initialization failed: $e");
        // Optionally show a dialog or snack bar
        return; // prevent navigation if init failed
      }
    }

    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          bottomNavigationBar: CustomButtonNavigationBar(
            onItemTapped: _onItemTapped,
            selectedIndex: selectedIndex,
          ),
          body: IndexedStack(
            index: selectedIndex,
            children: const [
              HomeView(),
              ChatsView(),
              AppointmentsView(),
              GroupChatView(),
              MoreView(),
            ],
          ),
        ),
      ),
    );
  }
}
