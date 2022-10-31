import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../claimScreenController.dart';

class AdsContainer extends StatelessWidget {
  const AdsContainer({
    Key? key,
    required this.ads,
  }) : super(key: key);

  final ClaimScreenController ads;

  @override
  Widget build(BuildContext context) {
    if (!ads.isBannerAd.value) {
      ads.isBannerAd(true);
      ads.adaptiveBannerAdSize();
    }
    if (ads.bannerAd != null) {
      return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        height: ads.bannerAd?.size.height.toDouble(),
        width: ads.bannerAd?.size.width.toDouble(),
        child: AdWidget(
          ad: ads.bannerAd!,
        ),
      );
    } else {
      return Container();
    }
  }
}

