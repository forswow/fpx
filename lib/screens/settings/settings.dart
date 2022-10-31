import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/const.dart';
import '../../utils/sliver_app_bar_widget.dart';
import '../../utils/textfield_widget.dart';
import 'settingsController.dart';
import 'ui/settings_card_item.dart';
import 'ui/settings_markdown_card.dart';

class SettingScreen extends GetView<SettingsController> {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: NestedScrollView(
          headerSliverBuilder: (context, _) => [
                const SliverrAppBarWidget(
                  colorStart: Colors.teal,
                  colorEnd: Colors.greenAccent,
                  text: 'FaucetPay X',
                )
              ],
          body: GestureDetector(
            onTap: () => Get.focusScope?.unfocus(),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AutoSizeText(
                          'Settings',
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              color: context.theme.appBarTheme.backgroundColor),
                        ),
                        kSB40,
                        Card(
                          child: ListTile(
                            title: context.isDarkMode
                                ? const Text('Dark theme', style: kS16W600)
                                : const Text('Ligth theme', style: kS16W600),
                            trailing: DayNightSwitcher(
                                isDarkModeEnabled: controller.isDark,
                                onStateChanged: (isDarkModeEnabled) {
                                  controller.changeTheme(isDarkModeEnabled);
                                }),
                          ),
                        ),
                        kPDiv,
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Card(
                          elevation: 2,
                          clipBehavior: Clip.hardEdge,
                          child: ExpansionTile(
                            title: const Text(
                              'Withdraw addresses',
                              style: kS16W600,
                            ),
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: faucetList.length,
                                itemBuilder: (context, index) {
                                  controller.ctrlText(
                                      controller.coinAdress[index],
                                      cryptoName[index]);
                                  return Obx(
                                    () => Card(
                                      elevation: 2,
                                      child: ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            backgroundImage:
                                                AssetImage(faucetList[index]),
                                          ),
                                          title: GestureDetector(
                                            onTap: () {
                                              controller.isTap[index].toggle();
                                            },
                                            child: controller
                                                    .isTap[index].isFalse
                                                ? Text(
                                                    controller.titleHintText(
                                                        cryptoName[index]),
                                                    style: kS14W600,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )
                                                : TextFieldWidget(
                                                    controller: controller
                                                        .coinAdress[index],
                                                    hintText: controller
                                                        .titleHintText(
                                                            cryptoName[index]),
                                                    onTap: () {
                                                      controller.isTap[index]
                                                          .toggle();
                                                    },
                                                    onSubmitted: (value) {
                                                      controller
                                                          .checkValidAddress(
                                                              controller
                                                                      .coinAdress[
                                                                  index],
                                                              index);
                                                      if (controller
                                                          .checkValidAddressList[
                                                              index]
                                                          .isTrue) {
                                                        controller.widthRaw(
                                                            cryptoName[index],
                                                            value);
                                                      }
                                                    },
                                                  ),
                                          ),
                                          trailing:
                                              GetBuilder<SettingsController>(
                                            builder: (_) => InkWell(
                                                onTap: () async {
                                                  controller.checkValidAddress(
                                                      controller
                                                          .coinAdress[index],
                                                      index);
                                                  if (controller
                                                      .checkValidAddressList[
                                                          index]
                                                      .isTrue) {
                                                    controller.widthRaw(
                                                        cryptoName[index],
                                                        controller
                                                            .coinAdress[index]
                                                            .text);
                                                  }
                                                },
                                                child: checkIcon(
                                                    controller.readAddress(
                                                        cryptoName[index]))),
                                          )),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        kPDiv,
                        SettingsCardItem(
                          title: 'Create FaucetPay account',
                          onTap: () =>
                              controller.launcher('https://faucetpay.io/'),
                        ),
                        kPDiv,
                        SettingsCardItem(
                          title: 'Disable all notifications',
                          onTap: () async {
                            await AwesomeNotifications().cancelAllSchedules();
                            GetStorage().write('checkNotif', false);
                            Get.rawSnackbar(
                                message: "All notifications are disabled",
                                snackPosition: SnackPosition.TOP,
                                borderRadius: 4,
                                dismissDirection: DismissDirection.horizontal,
                                animationDuration:
                                    const Duration(microseconds: 300),
                                isDismissible: true,
                                icon: const Icon(Icons.notifications_off));
                          },
                        ),
                        kPDiv,
                        SettingsCardItem(
                          onTap: () async {
                            if (await controller.inAppReview.isAvailable()) {
                              controller.inAppReview.openStoreListing();
                            }
                          },
                          title: 'Rate App',
                        ),
                        kPDiv,
                        SettingsMarkdownCard(
                          title: 'Privacy police',
                          markdown: controller.priv(),
                        ),
                        kPDiv,
                        SettingsMarkdownCard(
                          title: 'Terms & Conditions',
                          markdown: controller.terms(),
                        ),
                        Padding(
                          padding: kP8,
                          child: Text(
                            'Version: 1.0.4',
                            style: kS12W600.copyWith(
                                color: Get.theme.textTheme.bodySmall?.color
                                    ?.withOpacity(0.2)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  checkIcon(String val) {
    return val != ''
        ? const Icon(
            Icons.done,
            color: Colors.green,
            size: 24,
          )
        : const Icon(
            Icons.close,
            color: Colors.red,
            size: 24,
          );
  }
}
