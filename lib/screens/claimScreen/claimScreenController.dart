// ignore_for_file: file_names

import 'dart:async';
import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../data/data.dart';
import '../../model/faucetPay.dart';

class ClaimScreenController extends GetxController
    with StateMixin<List<Normal>> {
  final searchText = TextEditingController();
  final scrollController = ScrollController();
  var isBalance = false.obs;
  var isPaidToday = false.obs;
  var isActiveUsers = false.obs;
  var isTotalUsersPaid = false.obs;
  var isHealth = false.obs;
  var isActive = false.obs;
  var coinList = <Normal>[].obs;
  var listCoin = <Normal>[].obs;
  var adsList = [].obs;
  var refList = [].obs;
  var loadAds = false.obs;
  var isBannerAd = false.obs;
  NativeAd? nativeAd;
  BannerAd? bannerAd;
  var isPressedSheet = false.obs;
  var search = ''.obs;
  Timer? debouncer;
  var coinMap = {}.obs;
  int count = 50;
  var stat = RxStatus.empty();
  final box = GetStorage();
  var notifVal = 0.0.obs;

  @override
  onInit() {
    
    sortList(search.value);

    super.onInit();
  }

  @override
  Future<void> onReady() async {
    scrollController.addListener(() {
      if (listCoin.length == count) {
        if (scrollController.position.atEdge) {
          if (scrollController.position.pixels == 0) {
            log('ListView scroll at top');
          } else {
            log('ListView scroll at bottom');
            addItem(count);
          }
        }
      }
    });

    await anchoredAdaptiveBannerAdSize();
    await adaptiveBannerAdSize();

    super.onReady();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  initData() async {
    coinMap.forEach(
      (key, value) {
        coinList.add(value);
      },
    );
    if (GetStorage().read('checkNotif') == false) {
      if (coinList.isNotEmpty) {
        for (var element in coinList) {
          delAllNotif(element.name);
        }
      }
    }
    adsList(await DataJson().adBlockList());
    refList(await DataJson().refList());
  }

  searchLogic(List<Normal> normal, coinlist, String search) {
    return normal = coinList.where((el) {
      this.search.value = search;

      var name = el.name.toLowerCase().replaceAll(RegExp(r'[-]'), '');
      return name.contains(this.search.value.toLowerCase());
    }).toList();
  }

  Future<List<Normal>> initList(String search) async {
    return searchLogic(listCoin, coinList, search);
  }

  Future sortList(String search) async => debounce(() async {
        change(null, status: RxStatus.loading());
        coinList.clear();
        if (coinList.isEmpty) {
          RxStatus.loading();
          initData();
        }
        var data = <Normal>[];
        if (isPressedSheet.isTrue &&
            (isBalance.isTrue ||
                isActiveUsers.isTrue ||
                isHealth.isTrue ||
                isPaidToday.isTrue ||
                isTotalUsersPaid.isTrue)) {
          data = await sortLogic();
          data = await searchLogic(data, coinList, search);
        } else {
          data = await initList(search);
        }
        data.length - count < 50 ? count = data.length : count = 50;
        listCoin = List<Normal>.generate(count, (index) {
          var itemList = <Normal>[];
          itemList.addAll(data);
          return itemList[index];
        }, growable: true)
            .obs;

        if (listCoin.isNotEmpty) {
          change(listCoin, status: RxStatus.success());
        }
        if (listCoin.isEmpty) {
          change(listCoin, status: RxStatus.empty());
        }
        update();
      });
  Future addItem(int start) async {
    try {
      var data = await initList(search.value);
      if (data.length - count < 50) {
        var i = data.length - count;
        count = count + i;
      } else {
        count += 50;
      }
      if (data.length == count) {
        stat = RxStatus.success();
      } else {
        stat = RxStatus.loadingMore();
      }
      listCoin = List<Normal>.generate(count, (index) {
        var itemList = <Normal>[];
        itemList.addAll(data);

        return itemList[index];
      }, growable: true)
          .obs;

      update();
    } finally {
      // isAddLoading(false);
      if (listCoin.isNotEmpty) {
        change(listCoin, status: RxStatus.success());
      } else if (listCoin.isEmpty) {
        change(null, status: RxStatus.error('Something went wrong'));
      } else {
        // No products data
        change(null, status: RxStatus.empty());
      }
    }
  }

  sortLogic() {
    if (isBalance.isTrue) {
      if (isPaidToday.isTrue) {
        if (isActiveUsers.isTrue) {
          if (isTotalUsersPaid.isTrue) {
            if (isHealth.isTrue) {
              return coinList
                ..sort((a, b) => sorter(a.balance, b.balance))
                ..sort((a, b) => sorter(a.paidToday, b.paidToday))
                ..sort((a, b) => sorter(a.activeUsers, b.activeUsers))
                ..sort((a, b) => sorter(a.totalUsersPaid, b.totalUsersPaid))
                ..sort((a, b) => sorter(a.health, b.health));
            }
            return coinList
              ..sort((a, b) => sorter(a.balance, b.balance))
              ..sort((a, b) => sorter(a.paidToday, b.paidToday))
              ..sort((a, b) => sorter(a.activeUsers, b.activeUsers))
              ..sort((a, b) => sorter(a.totalUsersPaid, b.totalUsersPaid));
          }
          return coinList
            ..sort((a, b) => sorter(a.balance, b.balance))
            ..sort((a, b) => sorter(a.paidToday, b.paidToday))
            ..sort((a, b) => sorter(a.activeUsers, b.activeUsers));
        }
        return coinList
          ..sort((a, b) => sorter(a.balance, b.balance))
          ..sort((a, b) => sorter(a.paidToday, b.paidToday));
      }
      return coinList..sort((a, b) => sorter(a.balance, b.balance));
    }
    if (isPaidToday.isTrue) {
      if (isActiveUsers.isTrue) {
        if (isHealth.isTrue) {
          if (isTotalUsersPaid.isTrue) {
            return coinList
              ..sort((a, b) => sorter(a.paidToday, b.paidToday))
              ..sort((a, b) => sorter(a.activeUsers, b.activeUsers))
              ..sort((a, b) => sorter(a.health, b.health))
              ..sort((a, b) => sorter(a.totalUsersPaid, b.totalUsersPaid));
          }
          return coinList
            ..sort((a, b) => sorter(a.paidToday, b.paidToday))
            ..sort((a, b) => sorter(a.activeUsers, b.activeUsers))
            ..sort((a, b) => sorter(a.health, b.health));
        }
        return coinList
          ..sort((a, b) => sorter(a.paidToday, b.paidToday))
          ..sort((a, b) => sorter(a.activeUsers, b.activeUsers));
      }
      return coinList..sort((a, b) => sorter(a.paidToday, b.paidToday));
    }
    if (isActiveUsers.isTrue) {
      if (isHealth.isTrue) {
        if (isTotalUsersPaid.isTrue) {
          return coinList
            ..sort((a, b) => sorter(a.activeUsers, b.activeUsers))
            ..sort((a, b) => sorter(a.health, b.health))
            ..sort((a, b) => sorter(a.totalUsersPaid, b.totalUsersPaid));
        }
        return coinList
          ..sort((a, b) => sorter(a.activeUsers, b.activeUsers))
          ..sort((a, b) => sorter(a.health, b.health));
      }
      return coinList..sort((a, b) => sorter(a.activeUsers, b.activeUsers));
    }
    if (isTotalUsersPaid.isTrue) {
      if (isHealth.isTrue) {
        return coinList
          ..sort((a, b) => sorter(a.totalUsersPaid, b.totalUsersPaid))
          ..sort((a, b) => sorter(a.health, b.health));
      }
      return coinList
        ..sort((a, b) => sorter(a.totalUsersPaid, b.totalUsersPaid));
    }
    if (isHealth.isTrue) {
      return coinList..sort((a, b) => sorter(a.health, b.health));
    }
  }

  sorter(String a, String b) {
    return double.parse(b).compareTo(double.parse(a));
  }

  Future<void> sendNotif(String title, int notif, int id) async {
    box.write(title, notif);
    box.write('checkNotif', true);
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'channel key',
        title: title,
        body: 'Faucet is ready🔥\n\nGo Claim🔥',
        groupKey: "channel key",
        category: NotificationCategory.Reminder,
      ),
      schedule: NotificationInterval(
        interval: notif * 60,
        repeats: true,
      ),
    );

    if (notif == 0) {
      await AwesomeNotifications().cancelSchedule(id);
    } else {
      AwesomeNotifications().actionStream.listen((event) {
        // Get.to(() =>  ClaimScreen());
      });
    }
    update();
  }

  delAllNotif(String name) {
    box.remove(name);
    update();
  }

  loadAd() {
    if (!loadAds.value) {
      loadAds(true);
      anchoredAdaptiveBannerAdSize();
      update();
    }
  }

  Future<void> anchoredAdaptiveBannerAdSize() async {
    nativeAd = NativeAd(
        factoryId: 'listTile',
        adUnitId: 'ca-app-pub-1547624025079673/6322817226',
        request: const AdRequest(),
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            nativeAd = ad as NativeAd?;
            loadAds(true);
            log('native loaded');
            update();
          },
          onAdFailedToLoad: (ad, error) {
            loadAds(false);
            ad.dispose();
          },
        ))
      ..load();
  }

  Future<void> adaptiveBannerAdSize() async {
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getAnchoredAdaptiveBannerAdSize(
      Orientation.portrait,
      Get.width.truncate(),
    );
    if (size == null) {
      return;
    }

    bannerAd = BannerAd(
        size: size,
        adUnitId: 'ca-app-pub-1547624025079673/5939673840',
        request: const AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            bannerAd = ad as BannerAd?;
            isBannerAd(true);
            log('banner loaded');
            update();
          },
          onAdFailedToLoad: (ad, error) {
            isBannerAd(false);
            ad.dispose();
          },
        ))
      ..load();
  }

  bool isInterAd = false;
  void loadInterAd() {
    if (!isInterAd) {
      isInterAd = true;
      InterstitialAd.load(
        adUnitId: 'ca-app-pub-1547624025079673/6054104357',
        request: const AdRequest(),
        adLoadCallback:
            InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) async {
          await ad.show();
          isInterAd = false;
        }, onAdFailedToLoad: (LoadAdError error) {
          isInterAd = false;
        }),
      );
    }
    log('Inter Ad loaded');
  }

  String refLink(String url) {
    var res = refList
        .where((element) => element.toLowerCase().contains(url))
        .toString()
        .replaceAll(RegExp(r'[()]'), '');
    if (res != '' || res.isNotEmpty) {
      return res;
    } else {
      return url;
    }
  }

  @override
  void onClose() {
    searchText.dispose();
    scrollController.dispose();
    AwesomeNotifications().actionSink.close();
    nativeAd?.dispose();
    bannerAd?.dispose();
    super.onClose();
  }
}
