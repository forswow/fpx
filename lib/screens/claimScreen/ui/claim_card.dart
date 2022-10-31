import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../browser/webViewScreen.dart';
import '../../../model/faucetPay.dart';
import '../../../utils/const.dart';
import '../../../utils/custom_colors.dart';
import '../../../utils/painter.dart';

import '../../settings/settingsController.dart';

import '../claimScreenController.dart';
import 'info_bar.dart';

class ClaimCard extends StatelessWidget {
  const ClaimCard({
    Key? key,
    required this.coinModel,
    required this.coinName,
    required this.controller,
    required this.index,
  }) : super(key: key);

  final Normal coinModel;
  final String coinName;
  final ClaimScreenController controller;
  final int index;
  @override
  Widget build(BuildContext context) {
    var time = controller.box.read(coinModel.name);
    final CustomColors color = Theme.of(context).extension<CustomColors>()!;
    return GestureDetector(
      onTap: () {
        controller.loadInterAd();
        Get.to(
          () => WebViewScreen(
            coinAdress: GetStorage().read(cryptoName[index]) ?? '',
            // url: coinModel.url + ref[index],
            url: controller.refLink(coinModel.url),
            adsList: controller.adsList,
          ),
        );
      },
      child: Card(
        color: color.bodyBackground,
        child: SafeArea(
            child: Column(
          children: [
            Container(
                width: Get.size.width,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5)),
                    color: color.headerBackground),
                child: Padding(
                  padding: kP4,
                  child: Text(
                    coinModel.name,
                    style: kS12W600,
                  ),
                )),
            Padding(
              padding: kPH10V4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Balance: ${coinModel.balance} $coinName',
                        style: kS14W600,
                      ),
                      kSB4,
                      Text(
                        'Paid Today: ${coinModel.paidToday}\$',
                        style: kS14W600,
                      ),
                      kSB4,
                      Text(
                        'Total Users Paid Today: ${coinModel.totalUsersPaid}',
                        style: kS12W400,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: CustomPaint(
                      painter: HealthBar(
                          percent: double.parse(coinModel.health) / 100),
                      child: Center(
                        child: Text(
                          '${coinModel.health}%',
                          style: kS12W600.copyWith(
                              color: SettingsController().isDark
                                  ? Colors.white70
                                  : Colors.black54),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: kPH10V4,
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InfoBar(
                      widgetL: const Icon(Icons.people),
                      widgetR: Padding(
                        padding: kPH4,
                        child: Text(
                          coinModel.activeUsers,
                          style: kS12W600,
                        ),
                      ),
                    ),
                    const VerticalDivider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    Obx(() => InfoBar(
                                          widgetL: Text(
                                            '${coinModel.timerInMinutes} min',
                                            style: kS12W600,
                                          ),
                                          widgetR: GestureDetector(
                                              onTap: () {
                                                if (time == 0 || time == null) {
                                                  controller.sendNotif(coinModel.name,
                                                      int.parse(coinModel.timerInMinutes), index);
                                                  rawSnackBar(
                                                      message:
                                                          'Notification created every ${coinModel.timerInMinutes} min',
                                                      time: time);
                                                } else {
                                                  controller.sendNotif(coinModel.name, 0, index);
                                                  rawSnackBar(
                                                      message: 'Notification deleted', time: time);
                                                }
                                              },
                                              child: Icon(
                                                Icons.timer,
                                                color: (time == 0 || time == null)
                                                    ? Colors.red
                                                    : Colors.green,
                                              )),
                                        )),
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }

  SnackbarController rawSnackBar(
      {required String message, required dynamic time}) {
    return Get.rawSnackbar(
      message: message,
      snackPosition: SnackPosition.TOP,
      borderRadius: 4,
      dismissDirection: DismissDirection.horizontal,
      animationDuration: const Duration(microseconds: 300),
      isDismissible: true,
      icon: time == 0 || time == null
          ? const Icon(
              Icons.notification_add,
              color: Colors.green,
              size: 24,
            )
          : const Icon(
              Icons.notification_important,
              color: Colors.red,
              size: 24,
            ),
    );
  }
}
