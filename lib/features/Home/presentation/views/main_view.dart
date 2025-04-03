import 'package:flutter/material.dart';
import 'package:nafsia_app/features/Home/presentation/views/chats_view.dart'
    show ChatsView;
import 'package:nafsia_app/features/Home/presentation/views/home_view.dart'
    show HomeView;
import 'package:nafsia_app/features/Home/presentation/views/widget/custom_buttom_navigation_bar.dart';

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
            Center(
              child: Text('Notifications'),
            ),
            Center(
              child: Text('Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
