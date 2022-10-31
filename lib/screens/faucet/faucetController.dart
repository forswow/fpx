// ignore_for_file: file_names

import 'dart:developer';

import 'package:get/state_manager.dart';

import '../../data/data.dart';
import '../../model/faucetPay.dart';

class FaucetProviderController extends GetxController
    with StateMixin<List<FaucetPay>> {
  var faucetList = <FaucetPay>[];
  var coinName = [];
  var coinInfo = [];
  var bchList = <Normal>[];
  var bnbList = <Normal>[];
  var btcList = <Normal>[];
  var dashList = <Normal>[];
  var dgbList = <Normal>[];
  var dogeList = <Normal>[];
  var ethList = <Normal>[];
  var feyList = <Normal>[];
  var ltcList = <Normal>[];
  var solList = <Normal>[];
  var usdtList = <Normal>[];
  var trxList = <Normal>[];
  var zecList = <Normal>[];
  dynamic coinKey;
  FaucetProviderController() {
    _initData();
    coinInfo = [
      bchList,
      bnbList,
      btcList,
      dashList,
      dgbList,
      dogeList,
      ethList,
      feyList,
      ltcList,
      solList,
      usdtList,
      trxList,
      zecList
    ];
  }

  keyCoin() {}

  Future<void> _initData() async {
    RxStatus.loading();
    var f = await DataJson().getFaucet();
    log("FFF: $f");

    faucetList.add(f);
    var normal = faucetList[0].listData.normal;

    normal.forEach((key, value) {
      coinName.add(key);
    });
    for (var i = 0; i < coinName.length; i++) {
      var cf = {};
      cf[coinName[i]] = normal[coinName[i]];
      coinInfo[i] = cf[coinName[i]];

      log("COININFO:${coinInfo.length}");
      log('norm: ${normal[coinName[i]]}');
    }
    if (faucetList.isNotEmpty) {
      change(faucetList, status: RxStatus.success());
    } else if (faucetList.isEmpty) {
      change(faucetList, status: RxStatus.empty());
    } else {
      change(faucetList, status: RxStatus.error('WRONG'));
    }
    update();
  }
}
