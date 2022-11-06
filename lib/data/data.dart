import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get_connect/connect.dart';
import 'package:http/http.dart' as http;

import '../model/faucetPay.dart';

class DataJson extends GetConnect {
  static const String _url = 'https://faucetpay.io/api/listv1/faucetlist';
  final List _adList = [];
  Future getFaucet() async {
    try {
      final response = await http.get(Uri.parse(_url));
      if (response.statusCode == 200) {
        return faucetPayFromJson(response.body);
      } else {
        throw Future.error(Exception().toString());
      }
    } finally {}
  }

  Future adBlockList() async {
    final resp = await get('https://api.npoint.io/6c0ef9f61fa33918fba7');
    if (resp.statusCode == 200) {
      final List adsList = resp.body;
      _adList.add(adsList);
      return _adList[0];
    } else {
      log('LOCAL JSON LIST ACTIVE');
      _adList
          .add(jsonDecode(await rootBundle.loadString('assets/adBlock.json')));
      return _adList[0];
    }
  }

  

  Future<List<FaucetPay>> fetchData() async {
    final response = await http.get(Uri.parse(_url));
    return compute(parse, response.body);
  }

  List<FaucetPay> parse(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<FaucetPay>((json) => FaucetPay.fromJson(json)).toList();
  }
}
