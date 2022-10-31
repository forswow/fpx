// ignore_for_file: file_names

import 'dart:developer';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/const.dart';

import '../../utils/sliver_app_bar_widget.dart';


import 'claimScreenController.dart';
import 'ui/ads_container.dart';
import 'ui/bottom_sheet_widget.dart';
import 'ui/claim_card.dart';

class ClaimScreen extends GetView<ClaimScreenController> {
  const ClaimScreen(
      {Key? key,
      required this.coinMap,
      required this.length,
      required this.coinName,
      required this.refIndex})
      : super(key: key);
  final String coinName;
  final Map coinMap;
  final int length, refIndex;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClaimScreenController());

    controller.coinMap.value = coinMap;

    return GestureDetector(
      onTap: () {
        Get.focusScope?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                controller: controller.scrollController,
                slivers: [
                  SliverrAppBarWidget(
                    colorStart: const Color(0xFF009688),
                    colorEnd: const Color(0xFF69F0AE),
                    text: '$coinName Faucet',
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: kPH8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 36,
                              child: Material(
                                borderRadius: kBR8,
                                elevation: 2,
                                child: Padding(
                                  padding: kPH4,
                                  child: TextField(
                                    controller: controller.searchText,
                                    decoration: const InputDecoration(
                                        hintText: 'Search...',
                                        border: InputBorder.none,
                                        suffixIcon: Icon(Icons.search)),
                                    onChanged: (val) async {
                                      if (val.isNotEmpty) {
                                        return controller.sortList(val);
                                      }
                                      if (val.isEmpty || val == '') {
                                        return controller.sortList('');
                                      }
                                      // controller.search.value=val;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              controller.isPressedSheet(false);

                              showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: kBRT25),
                                  context: context,
                                  builder: (_) => BottomSheetWidget(
                                      controller: controller));
                              log('${controller.isActive}');
                            },
                            icon: const Icon(Icons.filter_list),
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: controller.obx(
                        (state) => GetBuilder<ClaimScreenController>(
                            builder: (controller) => Padding(
                                  padding: kP8,
                                  child: Stack(
                                    children: [
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: state?.length,
                                        itemBuilder: (context, index) {
                                          if (controller.loadAds.value &&
                                              index == 5) {
                                            return Padding(
                                              padding: kPV8,
                                              child: Card(
                                                child: Container(
                                                    height: 170,
                                                    alignment: Alignment.center,
                                                    child: AdWidget(
                                                      ad: controller.nativeAd!,
                                                    )),
                                              ),
                                            );
                                          } else {
                                            var model =
                                                state![_getItemIndex(index)];

                                            return ClaimCard(
                                              coinModel: model,
                                              coinName: coinName,
                                              controller: controller,
                                              index: refIndex,
                                            );
                                          }
                                        },
                                      ),
                                      if (controller.stat.isLoadingMore) ...[
                                        Positioned(
                                          bottom: 120,
                                          left: (context.width * 0.5) * 0.85,
                                          child: kCircularIndicator,
                                        )
                                      ]
                                    ],
                                  ),
                                )),
                        onLoading: kCircularIndicator),
                  )
                ],
              ),
            ),
            if (controller.isBannerAd.isTrue) ...[AdsContainer(ads: controller)]
          ],
        ),
      ),
    );
  }

  int _getItemIndex(int rawIndex) {
    if (rawIndex >= 10 && controller.loadAds.isTrue) {
      return rawIndex - 1;
    }
    return rawIndex;
  }
}
