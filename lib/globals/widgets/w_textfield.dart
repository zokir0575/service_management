import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/globals/widgets/w_scale.dart';
import 'package:service_app/utils/stroke_paint.dart';
import 'package:service_app/utils/text_styles.dart';


class WTextField extends StatefulWidget {
  final bool? hasBorderColor;
  final AutovalidateMode? autoValidateMode;
  final String? Function(String?)? validate;
  final bool? hasClearButton;
  final String title;
  final Color? disabledBorderColor;
  final double borderRadius;
  final TextStyle? titleTextStyle;
  final TextStyle? textStyle;
  final String? hintText;
  final TextStyle? prefixStyle;
  final TextStyle? hintTextStyle;
  final String prefixText;
  final bool? hideCounterText;
  final Widget? prefix;
  final EdgeInsets? prefixPadding;
  final double? width;
  final double? height;
  final int? maxLength;
  final TextInputType? keyBoardType;
  final bool? isObscure;
  final Widget? suffix;
  final String? suffixIcon;
  final EdgeInsets? suffixPadding;
  final TextCapitalization textCapitalization;
  final ValueChanged<String> onChanged;
  final TextEditingController? controller;
  final List<TextInputFormatter>? formatters;
  final EdgeInsets? contentPadding;
  final bool hasError;
  final double sizeBetweenFieldTitle;
  final Color? errorColor;
  final Color? fillColor;
  final EdgeInsets? margin;
  final VoidCallback? onEyeTap;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final bool? bigObscure;
  final TextInputAction textInputAction;
  final Function? onObscure;
  final VoidCallback? onTapSuffix;
  final Function()? onEditCompleted;
  final Function()? onTap;
  final bool autoFocus;
  final Color? disabledColor;
  final double? suffixRightPosition;
  final double? suffixSize;
  final int? maxLines;
  final Color? borderColor;
  final Color? enabledBorderColor;
  final BorderRadius? detailedBorderRadius;
  final String? initialText;
  final bool underlinedstyle;
  final bool isMultiline;
  final bool themeAdaptive;
  final VoidCallback? onClear;

  const WTextField({
    this.controller,
    required this.onChanged,
    this.initialText,
    this.themeAdaptive=false,
    this.onClear,
    this.isMultiline = false,
    this.underlinedstyle = false,
    this.hasBorderColor,
    this.disabledColor,
    this.validate,
    this.autoValidateMode,
    this.hideCounterText,
    this.autoFocus = false,
    this.borderRadius = 8,
    this.prefixStyle,
    this.disabledBorderColor,
    this.hasClearButton,
    this.textAlign = TextAlign.start,
    this.width,
    this.fillColor,
    this.title = '',
    this.titleTextStyle,
    this.textStyle,
    this.hintText,
    this.hintTextStyle,
    this.contentPadding = const EdgeInsets.all(12),
    this.prefixText = '',
    this.prefix,
    this.prefixPadding = const EdgeInsets.all(2),
    this.suffix,
    this.suffixIcon,
    this.suffixPadding = const EdgeInsets.all(12),
    this.isObscure,
    this.onEyeTap,
    this.margin,
    this.bigObscure,
    this.sizeBetweenFieldTitle = 8,
    this.errorColor,
    this.hasError = false,
    this.formatters,
    this.textCapitalization = TextCapitalization.none,
    this.keyBoardType,
    this.maxLength,
    this.focusNode,
    this.textInputAction = TextInputAction.done,
    this.height,
    this.onObscure,
    this.onTapSuffix,
    Key? key,
    this.onEditCompleted,
    this.onTap,
    this.suffixRightPosition = 8,
    this.suffixSize,
    this.maxLines = 1,
    this.borderColor,
    this.enabledBorderColor,
    this.detailedBorderRadius,
  }) : super(key: key);

  @override
  _WTextFieldState createState() => _WTextFieldState();
}

class _WTextFieldState extends State<WTextField>
    with SingleTickerProviderStateMixin {
  late FocusNode focusNode;
  bool focused = false;
  bool hasText = false;
  bool isObscure = false;
  bool showStroke = true;
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    super.initState();
    if (widget.isObscure != null) {
      isObscure = widget.isObscure!;
    }
    focusNode = FocusNode();

    focusNode.addListener(
      () => setState(() => focused = !focused),
    );
  }

  InputBorder underlinedStyleBorder({bool focused = false}) {
    return UnderlineInputBorder(
        borderSide: BorderSide(
            color: focused ? primaryColor : const Color(0xffE0DEDA), width: 1));
  }

  @override
  void dispose() {
    focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        margin: widget.margin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.title.isNotEmpty)
              Text(
                widget.title,
                style: widget.titleTextStyle ??
                    darkStyle(context).copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        )
              )
            else
              const SizedBox(),
            SizedBox(
              height:
                  widget.title.isNotEmpty ? widget.sizeBetweenFieldTitle : null,
            ),
            Container(
              height: widget.height,
              width: widget.width,
              decoration: BoxDecoration(
                borderRadius:
                    widget.detailedBorderRadius ?? BorderRadius.circular(6),
                color: widget.fillColor ?? whiteSmoke,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: widget.detailedBorderRadius ??
                        BorderRadius.circular(widget.borderRadius),
                    child: TextFormField(
                      initialValue: widget.initialText,
                      autovalidateMode: widget.autoValidateMode,
                      validator: widget.validate,
                      maxLines: widget.isMultiline ? null : widget.maxLines,
                      onTap: widget.onTap,
                      textAlign: widget.textAlign,
                      inputFormatters: widget.formatters,
                      textInputAction: widget.textInputAction,
                      textCapitalization: widget.textCapitalization,
                      obscureText: isObscure,
                      keyboardType: widget.keyBoardType,
                      maxLength: widget.maxLength,
                      controller: widget.controller,
                      autofocus: widget.autoFocus,
                      cursorColor: primaryColor,
                      obscuringCharacter: '●',
                      cursorHeight: 16,
                      onEditingComplete: widget.onEditCompleted,
                      onChanged: (s) {
                        setState(() => hasText = s.isNotEmpty);
                        widget.onChanged(s);
                      },
                      focusNode: widget.focusNode ?? focusNode,
                      style: widget.textStyle ??
                          darkStyle(context).copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        counter:
                            widget.maxLength != null ? const SizedBox() : null,
                        suffix: widget.suffix != null
                            ? SizedBox(width: widget.suffixSize)
                            : null,
                        border: widget.underlinedstyle
                            ? underlinedStyleBorder()
                            : OutlineInputBorder(
                                borderRadius: widget.detailedBorderRadius ??
                                    BorderRadius.circular(widget.borderRadius),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: widget.hasError
                                      ? Theme.of(context).colorScheme.error
                                      : widget.enabledBorderColor ??
                                          Colors.transparent,
                                ),
                              ),
                        counterText: widget.hideCounterText != null &&
                                widget.hideCounterText!
                            ? ''
                            : null,
                        hintText: widget.hintText,
                        hintStyle: widget.hintTextStyle ??
                            greyStyle(context).copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                        filled: true,
                        prefixIcon: widget.prefix,
                        fillColor: widget.underlinedstyle
                            ? Colors.transparent
                            : widget.disabledColor != null
                                ? widget.controller!.text.isNotEmpty
                                    ? widget.fillColor
                                    : widget.disabledColor
                                : whiteSmoke,
                        contentPadding: widget.contentPadding,
                        disabledBorder: widget.underlinedstyle
                            ? underlinedStyleBorder()
                            : OutlineInputBorder(
                                borderRadius: widget.detailedBorderRadius ??
                                    BorderRadius.circular(widget.borderRadius),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: widget.hasBorderColor != null &&
                                          !widget.hasBorderColor!
                                      ? Colors.transparent
                                      : widget.hasError
                                          ? Theme.of(context).colorScheme.error
                                          : widget.disabledBorderColor ??
                                              widget.borderColor ??
                                              Colors.transparent,
                                ),
                              ),
                        enabledBorder: widget.underlinedstyle
                            ? underlinedStyleBorder()
                            : OutlineInputBorder(
                                borderRadius: widget.detailedBorderRadius ??
                                    BorderRadius.circular(widget.borderRadius),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: widget.hasBorderColor != null &&
                                          !widget.hasBorderColor!
                                      ? Colors.transparent
                                      : widget.hasError
                                          ? Theme.of(context).colorScheme.error
                                          : widget.disabledBorderColor ??
                                              widget.enabledBorderColor ??
                                              Colors.transparent,
                                ),
                              ),
                        focusedBorder: widget.underlinedstyle
                            ? underlinedStyleBorder()
                            : OutlineInputBorder(
                                borderRadius: widget.detailedBorderRadius ??
                                    BorderRadius.circular(widget.borderRadius),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: widget.hasBorderColor != null &&
                                          !widget.hasBorderColor!
                                      ? Colors.transparent
                                      : widget.hasError
                                          ? Theme.of(context).colorScheme.error
                                          : widget.borderColor ?? primaryColor,
                                ),
                              ),
                      ),
                    ),
                  ),
                  if (widget.prefixText.isNotEmpty)
                    Positioned(
                      top: widget.height != null
                          ? 12 - (widget.height! / 35)
                          : 11,
                      left: 12,
                      child: Padding(
                        padding: widget.prefixPadding ?? EdgeInsets.zero,
                        child: Text(
                          widget.prefixText,
                          style: widget.prefixStyle ??
                              darkStyle(context).copyWith(
                                  fontSize: 16,
                                   ),
                        ),
                      ),
                    )
                  else
                    const SizedBox(),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    right: widget.suffixRightPosition,
                    child:
                        widget.hasClearButton != null && widget.hasClearButton!
                            ? widget.controller!.text.isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {});
                                      if (widget.onClear != null) {
                                        widget.onClear!();
                                      }

                                      widget.controller?.clear();
                                    },
                                    child: SvgPicture.asset(
                                      'AppIcons.close',
                                      width: 20,
                                      height: 20,
                                      color: Colors.black,
                                    ),
                                  )
                                : const SizedBox()
                            : Padding(
                                padding: widget.suffixPadding ??
                                    const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                    onTap: widget.onTapSuffix ?? () {},
                                    child: widget.suffix ?? const SizedBox()),
                              ),
                  ),
                  Positioned(
                    top: 0,
                    right: 8,
                    bottom: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.isObscure == null)
                          widget.suffixIcon != null
                              ? WScaleAnimation(
                                  onTap: widget.onTapSuffix ?? () {},
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 6, 2, 6),
                                    child: SvgPicture.asset(
                                      widget.suffixIcon!,
                                    ),
                                  ),
                                )
                              : const SizedBox()
                        else
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isObscure = !isObscure;
                              });
                              if (showStroke) {
                                showStroke = false;
                                animationController.forward();
                              } else {
                                showStroke = true;
                                animationController.reverse();
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 0),
                              width: 24,
                              height: 24,
                              child: Center(
                                child: AnimatedBuilder(
                                  animation: animationController,
                                  child: SvgPicture.asset(
                                    'AppIcons.close',
                                  ),
                                  builder: (context, child) => SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CustomPaint(
                                        foregroundPainter: StrokePaint(
                                            animationController.value),
                                        child: child),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
