// ignore_for_file: file_names

import 'dart:developer';

import 'package:get/state_manager.dart';

import 'ui/mini.dart';
import 'web/webController.dart';
import 'web/webTab.dart';

class Browser extends GetxController {
  final _webTabs = <WebTab>[].obs;
  final _miniature = <Mini>[].obs;
  final _currentIndex = 0.obs;

  late WebProvider webProvider;
  late MiniatureProvider miniatureProvider;
  Browser() {
    webProvider = WebProvider();
    miniatureProvider = MiniatureProvider();
  }

  @override
  void onInit() {
    webProvider = WebProvider();
    miniatureProvider = MiniatureProvider();
    super.onInit();
  }

  WebTab? getCurrentTab() {
    return _currentIndex >= 0 ? _webTabs[_currentIndex.value] : null;
  }

  int getCurrentTabIndex() {
    return _currentIndex.value;
  }

  set currentTabIndex(int i) {
    _currentIndex(i);
    update();
  }

  List<WebTab> get webViewTabs => _webTabs;

  List<Mini> get miniatureTabs => _miniature;

  void addTab(WebTab webTab) {
    _webTabs.add(webTab);

    _currentIndex(_webTabs.length - 1);

    webTab.webProvider.tabIndex = _currentIndex.value;

    webProvider.updateWithValue(webTab.webProvider);

    update();
  }

  Future<void> addMiniature(Mini mini) async {
    _miniature.add(mini);
    _currentIndex(_miniature.length - 1);

    miniatureProvider.updateMiniature(mini.miniatureProvider);
    update();
  }

  void delMiniature(int index) {
    _miniature.removeAt(index);
    _webTabs.removeAt(index);

    if (_currentIndex.value != index) {
      if (index < _currentIndex.value) {
        currentTabIndex = _currentIndex.value - 1;
        log('newTab index: $_currentIndex');
      }
      currentTabIndex = _currentIndex.value;
      log('new Index: $_currentIndex');
    } else {
      currentTabIndex = index - 1;
    }

    update();
  }
}
