// ignore_for_file: file_names

import 'dart:convert';

FaucetPay faucetPayFromJson(String str) => FaucetPay.fromJson(json.decode(str));

String faucetPayToJson(FaucetPay data) => json.encode(data.toJson());

class FaucetPay {
  FaucetPay({
    required this.listData,
  });

  ListData listData;

  factory FaucetPay.fromJson(Map<String, dynamic> json) => FaucetPay(
        listData: ListData.fromJson(json["list_data"]),
      );

  Map<String, dynamic> toJson() => {
        "list_data": listData.toJson(),
      };
}

class ListData {
  ListData({
    required this.normal,
  });

  Map<String, Map<String, Normal>> normal;

  factory ListData.fromJson(Map<String, dynamic> json) => ListData(
        normal: Map.from(json["normal"]).map((k, v) =>
            MapEntry<String, Map<String, Normal>>(
                k,
                Map.from(v).map((k, v) =>
                    MapEntry<String, Normal>(k, Normal.fromJson(v))))),
      );

  Map<String, dynamic> toJson() => {
        "normal": Map.from(normal).map((k, v) => MapEntry<String, dynamic>(
            k,
            Map.from(v)
                .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())))),
      };
}

class Normal {
  Normal({
    required this.id,
    required this.name,
    required this.url,
    required this.timerInMinutes,
    required this.paidToday,
    required this.totalUsersPaid,
    required this.activeUsers,
    required this.balance,
    required this.health,
  });

  String id;
  String url;
  String name;
  String timerInMinutes;
  String paidToday;
  String totalUsersPaid;
  String activeUsers;
  String balance;
  String health;

  factory Normal.fromJson(Map<String, dynamic> json) => Normal(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        timerInMinutes: json["timer_in_minutes"],
        paidToday: json["paid_today"],
        totalUsersPaid: json["total_users_paid"],
        activeUsers: json["active_users"],
        balance: json["balance"],
        health: json["health"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "timer_in_minutes": timerInMinutes,
        "paid_today": paidToday,
        "total_users_paid": totalUsersPaid,
        "active_users": activeUsers,
        "balance": balance,
        "health": health,
      };
}
