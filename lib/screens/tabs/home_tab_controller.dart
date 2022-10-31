import 'package:get/get.dart';

import '../faucet/faucet.dart';
import '../settings/settings.dart';

class HomeTabController extends GetxController {
  final _currentIndex = 0.obs;
  final List _screens = [const Faucet(), const SettingScreen()];

  set currentIndex(int tab) {
    _currentIndex(tab);
    update();
  }

  get currentTab => _currentIndex.value;
  get currentScreen => _screens[_currentIndex.value];
}
