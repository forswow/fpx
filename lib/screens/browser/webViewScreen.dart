// ignore_for_file: file_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'browserSettings.dart';
import 'ui/miniature.dart';
import 'ui/pops.dart';
import 'web/webController.dart';
import 'web/webTab.dart';

class WebViewScreen extends StatelessWidget {
  const WebViewScreen({
    Key? key,
    required this.coinAdress,
    required this.url,
    required this.adsList,
  }) : super(key: key);

  final String? coinAdress;
  final String url;
  final List adsList;
  @override
  Widget build(BuildContext context) {
    final browser = Get.put(Browser());

    browser.addTab(
      WebTab(
        webProvider: WebProvider(
          url: url,
          // windowId: 0
        ),
        adsList: adsList,
      ),
    );

    return WillPopScope(
      onWillPop: () async {
        var item =
            browser.webViewTabs[browser.getCurrentTabIndex()].webProvider;
        if (item.webViewController != null) {
          if (await item.webViewController!.canGoBack()) {
            item.webViewController!.goBack();
          } else {
            Get.back();
          }
        }
        return false;
      },
      child: GetX<Browser>(
        builder: (context) {
          var item =
              browser.webViewTabs[browser.getCurrentTabIndex()].webProvider;
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Get.theme.backgroundColor,
              title: Text(
                // webTab[0].title ??
                item.title ?? '',
                style: TextStyle(color: Get.theme.appBarTheme.backgroundColor),
              ),
              leading: IconButton(
                onPressed: () async => Get.back(),
                icon: const Icon(Icons.home),
              ),
              actions: [
                PopupMenuButton(
                    padding: EdgeInsets.zero,
                    position: PopupMenuPosition.under,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    itemBuilder: (_) {
                      var items = [
                        pops(
                          icons: Icons.forward,
                          title: 'Forward',
                          onTap: () async {
                            Get.back();
                            if (item.webViewController != null) {
                              if (await item.webViewController!
                                  .canGoForward()) {
                                await item.webViewController!.goForward();
                              }
                            }
                          },
                        ),
                        pops(
                          icons: Icons.visibility_off,
                          title: 'Remove ADS',
                          onTap: () async {
                            Get.back();
                            await item.dellAds();
                          },
                        ),
                        pops(
                          icons: Icons.ads_click_sharp,
                          title: 'Anti Adblock Killer',
                          onTap: () async {
                            Get.back();
                            await item.dontBlockAds();
                          },
                        ),
                        pops(
                          icons: Icons.insert_link,
                          title: 'Insert address',
                          onTap: () async {
                            Get.back();
                            if (coinAdress == null || coinAdress == '') {
                              await defaultDialog(
                                  title: 'No Wallet Address',
                                  content:
                                      'Wallet address not added.\n\nTo add a wallet address go to Settings');
                            } else {
                              item.setAddress(coinAdress!);
                            }
                          },
                        ),
                        pops(
                          icons: Icons.refresh,
                          title: 'Reload',
                          onTap: () async {
                            Get.back();
                            await item.webViewController?.reload();
                          },
                        ),
                      ];
                      return items;
                    })
              ],
            ),
            body: Stack(
              children: [
                if (item.progress >= 1) ...[
                  Container()
                ] else ...[
                  PreferredSize(
                    preferredSize: const Size(double.infinity, 4.0),
                    child: SizedBox(
                      height: 4.0,
                      child: LinearProgressIndicator(
                          value: item.progress,
                          backgroundColor: const Color(0xFFE4E4E4),
                          color: const Color(0xFF087924)),
                    ),
                  )
                ],
                IndexedStack(
                  index: browser.getCurrentTabIndex(),
                  children: browser.webViewTabs.map((e) {
                    // var isCurrentTab =
                    //     e.webProvider.tabIndex == browser.getCurrentTabIndex();
                    // var b = browser.getCurrentTab();

                    // if (isCurrentTab) {
                    //   log('isCurrent');
                    // } else {
                    //   log('isNotCurrent');
                    // }
                    return e;
                  }).toList(),
                ),
                Positioned(
                  bottom: 0,
                  child: browser.miniatureTabs.length > 1
                      ? Container(
                          height: 50,
                          width: Get.size.width,
                          color: Get.theme.scaffoldBackgroundColor,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Miniature(
                              currentIndex: browser.getCurrentTabIndex(),
                              items: browser.miniatureTabs,
                              onTap: (i) {
                                browser.currentTabIndex = i;
                                log(i.toString());
                                log('add length:${browser.miniatureTabs.length} ');
                              },
                              onDel: (i) {
                                log(i.toString());
                                // browser.delMiniature(i);
                                browser.delMiniature(i);
                                log('led length:${browser.miniatureTabs.length} ');
                              },
                            ),
                          ),
                        )
                      : Container(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> defaultDialog(
      {required String title, required String content}) {
    return Future.delayed(
        const Duration(milliseconds: 200),
        () => Get.defaultDialog(
              title: title,
              middleText: content,
              actions: [
                ElevatedButton(
                  onPressed: () => Get.back(),
                  child: const Text('OK'),
                )
              ],
            ));
  }
}
