import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class MiniatureProvider extends GetxController {
  int? _faviconIndex;

  Favicon? _favicon;
  MiniatureProvider({
    int? faviconIndex,
    Favicon? favicon,
  }) {
    faviconIndex = _faviconIndex;
    _favicon = favicon;
  }

  int? get faviconIndex => _faviconIndex;
  set faviconIndex(int? index) {
    if (index != _faviconIndex) {
      _faviconIndex = index;
      update();
    }
  }

  Favicon? get favicon => _favicon;
  set favicon(Favicon? value) {
    if (value != _favicon) {
      _favicon = value;
      update();
    }
  }

  void updateMiniature(MiniatureProvider miniatureProvider) {
    favicon = miniatureProvider.favicon;
  }
}
