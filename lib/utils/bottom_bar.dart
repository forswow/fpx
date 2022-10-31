import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    Key? key,
    required this.items,
    this.currentIndex = 0,
    this.onTap,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedColorOpacity,
    this.itemShape = const StadiumBorder(),
  }) : super(key: key);

  final List<NavBarItem> items;
  final int currentIndex;
  final Function(int)? onTap;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double? selectedColorOpacity;
  final ShapeBorder itemShape;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const itemPadding = EdgeInsets.symmetric(horizontal: 8, vertical: 6);
    return SafeArea(
      minimum: const EdgeInsets.only(bottom: 4),
      child: SizedBox(
        height: 36,
        child: Row(
          mainAxisAlignment: items.length <= 2
              ? MainAxisAlignment.spaceEvenly
              : MainAxisAlignment.spaceBetween,
          children: [
            for (final item in items)
              AnimatedContainer(
                width: items.indexOf(item) == currentIndex ? 120 : 50,
                height: 36,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutQuint,
                child: TweenAnimationBuilder<double>(
                  tween: Tween(
                    end: items.indexOf(item) == currentIndex ? 1.0 : 0.0,
                  ),
                  curve: Curves.easeOutQuint,
                  duration: const Duration(milliseconds: 500),
                  builder: (context, t, _) {
                    final selectedColor = item.selectedColor ??
                        selectedItemColor ??
                        theme.primaryColor;

                    final unselectedColor = item.unselectedColor ??
                        unselectedItemColor ??
                        theme.iconTheme.color;

                    return Material(
                      color: Color.lerp(
                          selectedColor.withOpacity(0.0),
                          selectedColor.withOpacity(selectedColorOpacity ?? 0.1),
                          t),
                      shape: itemShape,
                      child: InkWell(
                        onTap: () => onTap?.call(items.indexOf(item)),
                        customBorder: itemShape,
                        focusColor: selectedColor.withOpacity(0.1),
                        highlightColor: selectedColor.withOpacity(0.1),
                        splashColor: selectedColor.withOpacity(0.1),
                        hoverColor: selectedColor.withOpacity(0.1),
                        child: Padding(
                          padding: itemPadding -
                              (Directionality.of(context) == TextDirection.ltr
                                  ? EdgeInsets.only(right: itemPadding.right * t)
                                  : EdgeInsets.only(left: itemPadding.left * t)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconTheme(
                                data: IconThemeData(
                                  color: Color.lerp(
                                      unselectedColor, selectedColor, t),
                                  size: 24,
                                ),
                                child: items.indexOf(item) == currentIndex
                                    ? item.activeIcon ?? item.icon
                                    : item.icon,
                              ),
                              ClipRect(
                                clipBehavior: Clip.antiAlias,
                                child: Align(
                                  alignment: const Alignment(-0.2, 0.0),
                                  widthFactor: t,
                                  child: Padding(
                                    padding: Directionality.of(context) ==
                                            TextDirection.ltr
                                        ? EdgeInsets.only(
                                            left: itemPadding.left / 2,
                                            right: itemPadding.right)
                                        : EdgeInsets.only(
                                            left: itemPadding.left,
                                            right: itemPadding.right / 2),
                                    child: DefaultTextStyle(
                                      style: TextStyle(
                                        color: Color.lerp(
                                            selectedColor.withOpacity(0.0),
                                            selectedColor,
                                            t),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14
                                      ),
                                      child: item.title,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class NavBarItem {
  final Widget icon;
  final Widget? activeIcon;
  final Widget title;
  final Color? selectedColor;
  final Color? unselectedColor;

  NavBarItem({
    required this.icon,
    required this.title,
    this.selectedColor,
    this.unselectedColor,
    this.activeIcon,
  });
}
