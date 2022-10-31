import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/bottom_bar.dart';
import 'home_tab_controller.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Get.put(HomeTabController());
    return GetBuilder<HomeTabController>(builder: (context) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: model.currentScreen,
        bottomNavigationBar: NavBar(
          items: [
            NavBarItem(
              icon: const Icon(Icons.home),
              title: const Text("Home"),
              selectedColor: Colors.green,
            ),
            NavBarItem(
              icon: const Icon(Icons.settings),
              title: const Text("Settings"),
              selectedColor: Colors.teal,
            ),
          ],
          onTap: (i) {
            model.currentIndex = i;
          },
          currentIndex: model.currentTab,
        ),
      );
    });
  }
}