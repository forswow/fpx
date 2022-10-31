import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'app_clip.dart';
import 'const.dart';

class SliverrAppBarWidget extends StatelessWidget {
  const SliverrAppBarWidget({
    Key? key,
    required this.text,
    this.text2,
    required this.colorStart,
    required this.colorEnd,
    this.actions,
    this.back = false,
  }) : super(key: key);

  final String text;
  final String? text2;
  final Color colorStart, colorEnd;
  final List<Widget>? actions;
  final bool? back;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,

      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: AutoSizeText(
              text,
              style: kH1TextStyle,
              maxLines: 1,
              presetFontSizes: const [42, 36, 26, 22, 18, 16, 12],
            ),
          ),
          if (text2 != null) ...[
            Flexible(
              child: AutoSizeText(
                text2!,
                style: kH1TextStyle.copyWith(color: Colors.red),
                maxLines: 1,
                presetFontSizes: const [36, 26, 22, 18, 16, 12],
              ),
            )
          ],
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      excludeHeaderSemantics: true,
      expandedHeight: 150,
      pinned: true,
      // centerTitle: true,

      flexibleSpace: FlexibleSpaceBarSettings(
        toolbarOpacity: 1,
        maxExtent: 120,
        minExtent: 80,
        currentExtent: 120,
        child: AppClip(
          colorStart: colorStart,
          colorEnd: colorEnd,
        ),
      ),
      actions: actions,
      leading: back!
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : null,
    );
  }
}
