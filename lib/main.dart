import 'package:awesome_notifications/awesome_notifications.dart';
import 'screens/tabs/home_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'screens/settings/settingsController.dart';

Future<void> main() async {
  await initServices();
  runApp(const MyApp());
}

Future<void> initServices() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
          channelKey: "channel key",
          channelName: "channelName",
          channelDescription: "channelDescription",
          channelGroupKey: 'channelGroup',
          groupKey: 'channelGroup',
          importance: NotificationImportance.High),
    ],
    channelGroups: [
      NotificationChannelGroup(
        channelGroupkey: "channel key",
        channelGroupName: "channelName",
      )
    ],
  );
  await GetStorage.init();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());
    return SimpleBuilder(builder: (_) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FaucetPay X',
        theme: controller.theme,
        home: const HomeTab(),
      );
    });
  }
}
