import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/const.dart';

class CustomPopupMenuItem<T> extends PopupMenuEntry<T> {
  const CustomPopupMenuItem({
    Key? key,
    this.value,
    this.onTap,
    this.height = kMinInteractiveDimension,
    this.textStyle,
    required this.child,
  }) : super(key: key);

  final T? value;

  @override
  final double height;

  final TextStyle? textStyle;

  final Widget child;

  final Function()? onTap;

  @override
  bool represents(T? value) => value == this.value;

  @override
  CustomPopupMenuItemState<T, CustomPopupMenuItem<T>> createState() =>
      CustomPopupMenuItemState<T, CustomPopupMenuItem<T>>();
}

class CustomPopupMenuItemState<T, W extends CustomPopupMenuItem<T>>
    extends State<W> {
  @protected
  Widget buildChild() => widget.child;

  @protected
  void handleTap() {
    Navigator.pop<T>(context, widget.value);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final PopupMenuThemeData popupMenuTheme = PopupMenuTheme.of(context);
    TextStyle style = (widget.textStyle ??
        popupMenuTheme.textStyle ??
        theme.textTheme.subtitle1)!;

    Widget item = AnimatedDefaultTextStyle(
      style: style,
      duration: kThemeChangeDuration,
      child: Container(
        alignment: AlignmentDirectional.center,
        constraints: BoxConstraints(minHeight: widget.height, maxWidth: 80),
        // padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: buildChild(),
      ),
    );

    return InkWell(
      onTap: widget.onTap,
      child: item,
    );
  }
}

CustomPopupMenuItem<dynamic> pops({
  required IconData icons,
  required String title,
  required Function() onTap,
}) {
  return CustomPopupMenuItem<dynamic>(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icons),
          kSB4,
          Text(
            title,
            style: Get.theme.textTheme.bodySmall!
                .copyWith(fontWeight: FontWeight.w700, fontSize: 10),
          ),
          const Divider()
        ],
      ));
}
