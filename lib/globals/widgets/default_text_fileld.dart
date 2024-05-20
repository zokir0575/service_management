import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/utils/text_styles.dart';

class DefaultTextField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final EdgeInsets contentPadding;
  final Widget? prefix;
  final Color? fillColor;
  final Color? disabledColor;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffix;
  final double prefixMaxWidth;
  final double suffixMaxWidth;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final String? hintText;
  final bool hasError;
  final bool isObscure;
  final InputDecoration? inputDecoration;
  final TextInputType? keyboardType;
  final String title;
  final double? height;
  final int? maxLines;
  final int? maxLength;
  final bool autoFocus;
  final FocusNode? focusNode;
  final TextAlignVertical? textAlignVertical;
  final bool? expands;
  final double borderRadius;
  final BorderRadius? detailedBorderRadius;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final bool showCount;
  final Color? enabledBorderColor;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final bool readOnly;
  final bool underlinedstyle;
  final bool themeAdaptiveTitle;
  final Function()? onTap;

  const DefaultTextField({
    this.autoFocus = false,
    this.showCount = false,
    this.disabledColor,
    this.onTap,
    this.fillColor,
    this.focusNode,
    this.textCapitalization = TextCapitalization.none,
    this.borderRadius = 6,
    this.detailedBorderRadius,
    this.underlinedstyle = false,
    this.readOnly = false,
    this.textInputAction,
    this.maxLengthEnforcement,
    required this.controller,
    required this.onChanged,
    this.prefix,
    this.title = '',
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.inputFormatters,
    this.suffix,
    this.prefixMaxWidth = 40,
    this.suffixMaxWidth = 40,
    this.hintStyle,
    this.hintText,
    this.enabledBorderColor,
    this.style,
    this.isObscure = false,
    this.hasError = false,
    this.inputDecoration,
    this.keyboardType,
    this.height,
    this.maxLines,
    this.maxLength,
    this.textAlignVertical,
    this.expands,
    this.themeAdaptiveTitle = false,
    Key? key,
  }) : super(key: key);

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  InputBorder underlinedStyleBorder({bool focused = false}) {
    return UnderlineInputBorder(
        borderSide: BorderSide(
            color: focused ? primaryColor : const Color(0xffE0DEDA), width: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title.isNotEmpty) ...[
          Text(widget.title,
              style: darkStyle(context).copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,)),
          const SizedBox(height: 8),
        ],
        SizedBox(
          height: widget.height ?? 40,
          child: TextFormField(
            textCapitalization: widget.textCapitalization,
             onTap: widget.onTap,
            readOnly: widget.readOnly,
            expands: widget.expands ?? false,
            maxLengthEnforcement: widget.maxLengthEnforcement,
            textAlignVertical: widget.textAlignVertical,
            focusNode: widget.focusNode,
            autofocus: widget.autoFocus,
            controller: widget.controller,
            onChanged: widget.onChanged,
            textInputAction: widget.textInputAction,
            style: widget.style ??
                darkStyle(context)
                    .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
            inputFormatters: widget.inputFormatters,
            obscureText: widget.isObscure,
            keyboardType: widget.keyboardType,
            maxLength: widget.maxLength,
            maxLines: widget.isObscure ? 1 : widget.maxLines,
            cursorColor: primaryColor,
            decoration: widget.inputDecoration ??
                InputDecoration(
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
                  enabledBorder: widget.underlinedstyle
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
                  focusedBorder: widget.underlinedstyle
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
                  hintText: widget.hintText,
                  hintStyle: widget.hintStyle ??
                      greyStyle(context).copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                  contentPadding: widget.contentPadding,
                  suffixIcon: widget.suffix,
                  suffixIconConstraints:
                      BoxConstraints(maxWidth: widget.suffixMaxWidth),
                  fillColor: widget.underlinedstyle
                      ? Colors.transparent
                      : widget.disabledColor != null
                          ? widget.controller.text.isNotEmpty
                              ? widget.fillColor
                              : widget.disabledColor
                          : whiteSmoke,
                  filled: true,
                  prefixIconConstraints:
                      BoxConstraints(maxWidth: widget.prefixMaxWidth),
                  prefixIcon: widget.prefix,
                  counterText: '',
                ),
          ),
        ),
      ],
    );
  }
}
