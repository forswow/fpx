import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../utils/const.dart';

class GridCard extends StatelessWidget {
  const GridCard({
    Key? key,
    required this.cryptoName,
    required this.faucetLength,
    required this.onTap,
    required this.image,
  }) : super(key: key);

  final String cryptoName;
  final String faucetLength;
  final Function() onTap;
  final String image;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
            borderRadius: kBR14,
            gradient:
                LinearGradient(colors: [Colors.teal, Colors.greenAccent])),
        child: Card(
          elevation: 2,
          clipBehavior: Clip.hardEdge,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListTile(
                dense: true,
                contentPadding: kPH8,
                leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 20,
                    child: Image.asset(
                      image,
                      cacheHeight: 256,
                      cacheWidth: 256,
                    )),
                title: AutoSizeText(
                  cryptoName.toUpperCase(),
                  maxLines: 1,
                  minFontSize: 10,
                  maxFontSize: 20,
                  style: kS18Wb.copyWith(fontFamily: kFontFamily),
                ),
                subtitle: Text(
                  'Faucets: $faucetLength',
                  style: kS12W700,
                ),
              ),
              IconButton(
                onPressed: onTap,
                icon: const Icon(Icons.chevron_right),
              )
            ],
          ),
        ),
      ),
    );
  }
}