import 'package:flutter/material.dart';
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

  void _onItemTapped(int index) {
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
