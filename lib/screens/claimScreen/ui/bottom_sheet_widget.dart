import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/const.dart';
import '../../../utils/custom_colors.dart';
import '../claimScreenController.dart';
import 'switch_tile.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ClaimScreenController controller;

  @override
  Widget build(BuildContext context) {
    final CustomColors color = Theme.of(context).extension<CustomColors>()!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            padding: kP8,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: kBRT25,
              color: color.headerBackground,
            ),
            height: 48,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: const Padding(
              padding: kPH8,
              child: Text('Sorting', style: kS18Wb),
            )),
        Column(
          children: [
            SwitchTile(
              title: 'Sorting by Balance',
              boolean: controller.isBalance,
            ),
            SwitchTile(
              title: 'Sorting by Paid today',
              boolean: controller.isPaidToday,
            ),
            SwitchTile(
              title: 'Sorting by Active Users',
              boolean: controller.isActiveUsers,
            ),
            SwitchTile(
              title: 'Sorting by Total Users Paid',
              boolean: controller.isTotalUsersPaid,
            ),
            SwitchTile(
              title: 'Sorting by Health',
              boolean: controller.isHealth,
            ),
          ],
        ),
        Padding(
          padding: kP8,
          child: GetBuilder<ClaimScreenController>(
            builder: (_) {
              return ElevatedButton(
                  onPressed: () {
                    controller.isPressedSheet(true);
                    controller.sortList(controller.search.value);
                    Get.back();
                  },
                  child: const Text('OK'));
            },
          ),
        )
      ],
    );
  }
}






