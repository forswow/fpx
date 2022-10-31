import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const kFontFamily = "Signika";
const kBR14 = BorderRadius.all(Radius.circular(14));
const kBR12 = BorderRadius.all(Radius.circular(12));
const kBR8 = BorderRadius.all(Radius.circular(8));
const kBRT25 = BorderRadius.vertical(top: Radius.circular(25.0));
const kP16 = EdgeInsets.all(16.0);
const kP10 = EdgeInsets.all(10.0);
const kP8 = EdgeInsets.all(8.0);
const kP4 = EdgeInsets.all(4);
const kP2 = EdgeInsets.all(2);
const kPH16 = EdgeInsets.symmetric(horizontal: 16);
const kPH4 = EdgeInsets.symmetric(horizontal: 4);
const kPV8 = EdgeInsets.symmetric(vertical: 8);
const kPH8 = EdgeInsets.symmetric(horizontal: 8);
const kPH10V4 = EdgeInsets.symmetric(horizontal: 10, vertical: 4);
const kPH16V8 = EdgeInsets.symmetric(horizontal: 16, vertical: 8);
const kPL8 = EdgeInsets.only(left: 8);
const kH1TextStyle = TextStyle(
    fontSize: 36, fontWeight: FontWeight.bold, fontFamily: kFontFamily);

const kCircularIndicator = Center(
  child: CircularProgressIndicator(
    backgroundColor: Color(0xFFE4E4E4),
    color: Color(0xFF087924),
  ),
);
const kPDiv = Padding(padding: kPH16, child: Divider(thickness: 2));
const kFaucetStyle = TextStyle(fontWeight: FontWeight.w900);
const kS16W600 = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
const kS14W600 = TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
const kS14W500 = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
const kS12W400 = TextStyle(fontSize: 12, fontWeight: FontWeight.w400);
const kS12W600 = TextStyle(fontSize: 12, fontWeight: FontWeight.w600);
const kTitleList = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
const kS18Wb = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
const kS12W700 = TextStyle(fontSize: 12, fontWeight: FontWeight.w700);
const kSB4 = SizedBox(height: 4);
const kSB40 = SizedBox(height: 40);
List<String> ref = [
  '?r=qz9rj2q5eew3890tynkec6c0dppxf6sw6svcfqjm4f',
  '?r=0xfe2c0F9F8A322197bBc52938c0947b7aF89ec755',
  '?r=1PyCwg9DWxxrQQbJ1k5WUkAcGgdUTwc3xE',
  '?r=Xfm8CCPGrRQadRh89qF3HmDj351UVV4mRy',
  '?r=DPvQ7BSdnggK3mdb3wUeSTwnsim8WWcefy',
  '?r=D8MyDKASW6C8jQYzVqGP8J5TQ8P43pS5hL',
  '?r=0xA709bb74d76a0DA0C918DD050a2Ec76389898862',
  '?r=0xA709bb74d76a0DA0C918DD050a2Ec76389898862',
  '?r=MSCqArfs1iwoQASgpiV3ocZBCkG4DMCnaL',
  '?r=5K7p5GD6MySdPFXguTSuUJ2AdoSy2GmrvWrTJ9t3GMV3',
  '?r=TX6Wz6omqzm7xhdBdYfDZ1jYiVNEpkjjLu',
  '?r=TX6Wz6omqzm7xhdBdYfDZ1jYiVNEpkjjLu',
  '?r=t1WkDRWkmTbpcxAgwFmhYLyNFNshZqr8pc8'
];

final List faucetList = [
  bitcoincash,
  bnb,
  bitcoin,
  dash,
  digibyte,
  dogecoin,
  eth,
  feyorra,
  litecoin,
  solana,
  tron,
  tether,
  zcash,
];
final List<String> cryptoName = [
  "BCH",
  "bnb",
  "bitcoin",
  "dash",
  "dgb",
  "doge",
  "eth",
  "feyorra",
  "ltc",
  "solana",
  "tron",
  "tether",
  "zcash",
];
const bitcoincash = "assets/bitcoin_cash.png";
const bitcoin = "assets/bitcoin.png";
const bnb = "assets/bnb.png";
const dash = "assets/dash.png";
const digibyte = "assets/digibyte.png";
const dogecoin = "assets/dogecoin.png";
const eth = "assets/eth.png";
const feyorra = "assets/feyorra.png";
const litecoin = "assets/litecoin.png";
const solana = "assets/solana.png";
const tether = "assets/tether.png";
const tron = "assets/tron.png";
const zcash = "assets/zcash.png";

