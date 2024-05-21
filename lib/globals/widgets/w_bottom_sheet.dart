import 'package:flutter/material.dart';
import 'package:service_app/assets/color/colors.dart';

class WBottomSheet extends StatelessWidget {
  final double borderRadius;
  final bool scrollable;
  final List<Widget> children;
  final Widget? bottomNavigation;
  final double? height;
  final EdgeInsets? contentPadding;
  final bool isLight;
  const WBottomSheet({
    required this.children,
    this.borderRadius = 16,
    this.height,
    this.isLight = true,
    this.bottomNavigation,
    this.contentPadding,
    this.scrollable = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color:white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(borderRadius),
            ),
          ),
          padding: contentPadding ??
              EdgeInsets.fromLTRB(
                16,
                16,
                16,
                bottomNavigation == null
                    ? MediaQuery.of(context).padding.bottom + 16
                    : 16,
              ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
        if (bottomNavigation != null) ...{
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom + 20,
            ),
            child: bottomNavigation,
          ),
        }
      ],
    );
    return SizedBox(
      height: height,
      child: scrollable
          ? SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: child,
            )
          : child,
    );
  }
}
