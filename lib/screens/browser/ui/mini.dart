import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/const.dart';
import '../web/webController.dart';
import 'custom_image.dart';

class Mini extends StatelessWidget {
  const Mini({
    Key? key,
    required this.miniatureProvider,
  }) : super(key: key);

  final MiniatureProvider miniatureProvider;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MiniatureProvider>(
      builder: (_) {
        return SizedBox(
          width: 42,
          height: 42,
          child: Material(
              clipBehavior: Clip.hardEdge,
              elevation: 2,
              color: const Color(0x2F000000),
              shape: const CircleBorder(),
              child: Container(
                padding: kP4,
                // margin: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: CustomImage(
                  url: miniatureProvider.favicon?.url,
                ),
              )),
        );
      },
    );
  }
}