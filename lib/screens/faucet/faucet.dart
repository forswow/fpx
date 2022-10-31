import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../../utils/const.dart';
import '../../utils/sliver_app_bar_widget.dart';
import '../claimScreen/claimScreen.dart';
import 'faucetController.dart';
import 'ui/grid_card.dart';

class Faucet extends GetView<FaucetProviderController> {
  const Faucet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Get.put(FaucetProviderController());
    return NestedScrollView(
        headerSliverBuilder: (context, _) {
          return [
            const SliverrAppBarWidget(
              colorStart: Color(0xFF009688),
              colorEnd: Colors.greenAccent,
              text: 'FaucetPay X',
            )
          ];
        },
        body: Scaffold(
          body: controller.obx(
            (state) => AnimationLimiter(
              child: Padding(
                padding: kP8,
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: model.coinName.length,
                  itemBuilder: (context, index) {
                    var cryptoName = model.coinName[index];
                    var cInf = model.coinInfo[index];
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      columnCount: 2,
                      duration: const Duration(milliseconds: 400),
                      child: ScaleAnimation(
                        duration: const Duration(milliseconds: 600),
                        child: FadeInAnimation(
                          child: GridCard(
                              onTap: () {
                                Get.to(() => ClaimScreen(
                                      coinName: cryptoName,
                                      coinMap: cInf,
                                      length: cInf.length,
                                      refIndex: index,
                                    ));

                                log('TAP');
                              },
                              image: faucetList[index],
                              cryptoName: cryptoName,
                              faucetLength: cInf.length.toString()),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            onLoading: kCircularIndicator,
            onError: ((error) => Center(
                  child: Text('Oops...$error'),
                )),
          ),
        ));
  }
}
