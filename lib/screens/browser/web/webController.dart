

import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class WebProvider extends GetxController {
  InAppWebViewController? webViewController;
  final _title = ''.obs;
  final _tabIndex = 0.obs;
  final _url = ''.obs;
  final _progress = 0.0.obs;
  final _windowId = 0.obs;

  WebProvider({
    String? title,
    int? tabIndex,
    String? url,
    double progress = 0.0,
    int? windowId,
    this.webViewController,
  }) {
    _title(title);
    _tabIndex(tabIndex);
    _windowId(windowId);
    _url(url);
    _progress(progress);
  }

  String? get title => _title.value;
  set title(String? value) {
    if (value != _title.value) {
      _title(value);
      update();
    }
  }

  String get url => _url.value;
  set url(String value) {
    if (value != _url.value) {
      _url.value = value;
      update();
    }
  }

  int? get windowId => _windowId.value;
  set windowId(int? value) {
    if (value != _windowId.value) {
      _windowId(value);
      update();
    }
  }

  int? get tabIndex => _tabIndex.value;
  set tabIndex(int? value) {
    if (value != _tabIndex.value) {
      _tabIndex(value);
      update();
    }
  }

  double get progress => _progress.value;

  set progress(double value) {
    if (value != _progress.value) {
      _progress(value);
      update();
    }
  }

  void updateWithValue(WebProvider webViewModel) {
    tabIndex = webViewModel.tabIndex;
    url = webViewModel.url;
    title = webViewModel.title;
    webViewController = webViewModel.webViewController;
    progress = webViewModel.progress;
  }

  Future<void> dontBlockAds() async {
    var scr2 = """
var el=document.body.classList;
el.remove(el[2]);
el.remove(el[2]);

el.remove("storefront-full-width-content");
el.remove("pjvasfw-show");
el.remove("pjvasfw-disable-scroll");
""";
    var scr3 = """
document.body.style.overflow ='auto';
document.getElementById('arlinablock').remove();
document.querySelector('.step1').remove();
document.querySelector('.btn-more').style.zIndex=1000;

""";
    String script = await rootBundle.loadString('assets/anti-adblock.js');

    webViewController?.callAsyncJavaScript(functionBody: script);
    webViewController?.callAsyncJavaScript(functionBody: scr2);
    webViewController?.callAsyncJavaScript(functionBody: scr3);
  }

  Future<void> dellAds() async {
    String script = await rootBundle.loadString('assets/ads-block.js');
    webViewController?.callAsyncJavaScript(functionBody: script);
    webViewController?.callAsyncJavaScript(
        functionBody: "document.getElementById('captcha-adspace').remove()");

    webViewController?.callAsyncJavaScript(
        functionBody:
            "document.querySelectorAll('.g-recaptcha iframe')[0].style.display='block'");

    webViewController?.callAsyncJavaScript(
        functionBody:
            """document.querySelectorAll('.h-captcha iframe')[0].style.display='block';
            document.querySelectorAll('.h-captcha iframe')[0].style.zIndex=1000;
            """);
    webViewController?.callAsyncJavaScript(
        functionBody:
            "document.querySelector('[title=\"Main content of the hCaptcha challenge\"]').style.display='block'");
    webViewController?.callAsyncJavaScript(
        functionBody:
            "document.querySelector('[title=\"текущую проверку reCAPTCHA можно пройти в течение ещё двух минут\"]').style.display='block'");
    webViewController?.callAsyncJavaScript(
        functionBody:
            "document.querySelector('#solvemedia').style.display='block'");
  }

  Future setAddress(String address) async {
    webViewController?.callAsyncJavaScript(functionBody: """

if(document.getElementsByName('address')[0]){
  document.getElementsByName('address')[0].value='$address';
  }
else if(document.querySelector('input')){
  document.querySelector('input').value ='$address';
  }
""");
  }
}

