// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/themes.dart';

class SettingsController extends GetxController {
  final bitcoinController = TextEditingController();
  final ethController = TextEditingController();
  final litecoinController = TextEditingController();
  final bitcoincashController = TextEditingController();
  final dogecoinController = TextEditingController();
  final bnbController = TextEditingController();
  final dashController = TextEditingController();
  final digibyteController = TextEditingController();
  final feyorraController = TextEditingController();
  final solanaController = TextEditingController();
  final tetherController = TextEditingController();
  final tronController = TextEditingController();
  final zcashController = TextEditingController();
  final box = GetStorage();
  late List<TextEditingController> coinAdress = [];
  var coin = ''.obs;

  var isTap = <RxBool>[
    RxBool(false),
    RxBool(false),
    RxBool(false),
    RxBool(false),
    RxBool(false),
    RxBool(false),
    RxBool(false),
    RxBool(false),
    RxBool(false),
    RxBool(false),
    RxBool(false),
    RxBool(false),
    RxBool(false),
    RxBool(false),
    RxBool(false),
  ];
  var coinValue = ''.obs;
  var isWidthRaw = false.obs;
  var checkValidAddressList = <RxBool>[
    RxBool(true),
    RxBool(true),
    RxBool(true),
    RxBool(true),
    RxBool(true),
    RxBool(true),
    RxBool(true),
    RxBool(true),
    RxBool(true),
    RxBool(true),
    RxBool(true),
    RxBool(true),
    RxBool(true),
    RxBool(true),
    RxBool(true),
  ];

  var btcAddress = true.obs;
  var ethAddress = true.obs;
  var ltcAddress = true.obs;
  var bchAddress = true.obs;
  var dogeAddress = true.obs;
  var bnbAddress = true.obs;
  var dashAddress = true.obs;
  var dgbAddress = true.obs;
  var feyAddress = true.obs;
  var solAddress = true.obs;
  var usdtAddress = true.obs;
  var trxAddress = true.obs;
  var zecAddress = true.obs;
  late InAppReview inAppReview;
  @override
  void onInit() {
    coinAdress = [
      bitcoinController,
      ethController,
      litecoinController,
      bitcoincashController,
      dogecoinController,
      bnbController,
      dashController,
      digibyteController,
      feyorraController,
      solanaController,
      tetherController,
      tronController,
      zcashController,
    ];
    checkValidAddressList;

    inAppReview = InAppReview.instance;
    super.onInit();
  }

  Future widthRaw(coin, coinValue) async {
    box.write(coin, coinValue);
    update();
  }

  errorLog(TextEditingController text, bool checker, String errorText) =>
      text.text.isEmpty
          ? null
          : checker
              ? null
              : errorText;

  ctrlText(TextEditingController ctrl, cryptoName) {
    return ctrl.text = box.read(cryptoName) ?? '';
  }

  checkValidAddress(TextEditingController coinController, index) {
    if (coinController.text.isNotEmpty) {
      checkValidAddressList[index](coinController.text.length >= 26);
    }
    update();
  }

  readAddress(String coin) => box.read(coin) ?? "";
  String titleHintText(String crypto) {
    return readAddress(crypto) == ""
        ? "Widthraw address ${crypto.toUpperCase()}"
        : readAddress(crypto);
  }

  void launcher(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  Future<String> priv() async {
    return await rootBundle.loadString('assets/privacy.md');
  }

  Future<String> terms() async {
    return await rootBundle.loadString('assets/terms.md');
  }

  bool get isDark => box.read('darkmode') ?? false;
  ThemeData get theme => isDark ? Themes.darkTheme : Themes.lightTheme;

  ThemeMode get themeMode => isDark ? ThemeMode.dark : ThemeMode.light;
  void changeTheme(bool val) => box.write('darkmode', val);

  @override
  void onClose() {
    bitcoinController.dispose();
    ethController.dispose();
    litecoinController.dispose();
    bitcoincashController.dispose();
    dogecoinController.dispose();
    bnbController.dispose();
    dashController.dispose();
    digibyteController.dispose();
    feyorraController.dispose();
    solanaController.dispose();
    tetherController.dispose();
    tronController.dispose();
    zcashController.dispose();

    super.onClose();
  }
}
