import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/globals/widgets/w_scale.dart';
import 'package:service_app/utils/text_styles.dart';

class WButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String text;
  final Color? color;
  final Color textColor;
  final TextStyle? textStyle;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final GestureTapCallback onTap;
  final BoxBorder? border;
  final double borderRadius;
  final Widget? child;
  final Color disabledColor;
  final bool isDisabled;
  final bool isLoading;
  final double? scaleValue;
  final List<BoxShadow>? shadow;
  final bool hasError;
  final Widget? loader;
  final Alignment alignment;
  const WButton({
    required this.onTap,
    this.text = '',
    this.alignment = Alignment.center,
    this.color = primaryColor,
    this.hasError = false,
    this.loader,
    this.textColor = white,
    this.borderRadius = 8,
    this.disabledColor = grey,
    this.isDisabled = false,
    this.isLoading = false,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.textStyle,
    this.border,
    this.child,
    this.scaleValue,
    this.shadow,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => WScaleAnimation(
        scaleValue: scaleValue ?? 0.95,
        onTap: () {
          if (!(isLoading || isDisabled)) {
            onTap();
          }
        },
        isDisabled: isDisabled,
        child: Container(
          width: width,
          height: height ?? 44,
          margin: margin,
          padding: padding ?? EdgeInsets.zero,
          alignment: alignment,
          decoration: BoxDecoration(
            color: isDisabled ? disabledColor : color,
            borderRadius: BorderRadius.circular(borderRadius),
            border: hasError ? Border.all(color: Colors.red, width: 1) : border,
            boxShadow: shadow,
          ),
          child: isLoading
              ? Center(
                  child: loader ??
                      const CupertinoActivityIndicator(
                        color: Colors.white,
                      ))
              : child ??
                  Text(
                    text,
                    style: isDisabled
                        ? greyStyle(context)
                        : textStyle ??
                            whiteStyle(context).copyWith(
                                fontSize: 16, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
        ),
      );
}
