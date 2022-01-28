import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputText extends StatelessWidget {
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final Function(String value)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final String? initialValue;
  final String? label;
  final int? maxLength;
  final int? maxLines;
  final bool? isEnabled;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final IconData? sufixIcon;
  final bool? isPassword;
  final Color? borderColor;
  final Color? textColor;
  final Color? labelColor;
  final Color? focusedBorderColor;
  final GestureTapCallback? sufixIconTap;
  final GestureTapCallback? prefixIconTap;
  final bool? isAutoFocus;
  final bool? isAutoCorrect;
  final double? elevation;
  final TextInputAction? textInputAction;
  final double? borderRadius;
  final double? borderWidth;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;
  final TextCapitalization? textCapitalization;

  const CustomInputText({
    Key? key,
    this.elevation,
    this.validator,
    this.initialValue,
    this.onFieldSubmitted,
    this.focusedBorderColor,
    this.labelColor,
    this.maxLines,
    this.textColor,
    this.textInputAction = TextInputAction.done,
    this.onChanged,
    this.label,
    this.maxLength,
    this.isEnabled = true,
    this.isAutoCorrect = true,
    this.inputType,
    this.controller,
    this.prefixIcon,
    this.sufixIcon,
    this.isPassword = false,
    this.borderColor,
    this.sufixIconTap,
    this.prefixIconTap,
    this.isAutoFocus = false,
    this.borderRadius,
    this.errorText,
    this.borderWidth,
    this.inputFormatters,
    this.textCapitalization,
    this.fillColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      maxLines: maxLines ?? 1,
      validator: validator,
      initialValue: initialValue,
      cursorColor: Theme.of(context).highlightColor,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      autofocus: isAutoFocus!,
      obscureText: isPassword!,
      controller: controller,
      autocorrect: true,
      maxLength: maxLength,
      textAlign: TextAlign.left,
      keyboardType: inputType,
      textCapitalization: textCapitalization ?? TextCapitalization.sentences,
      inputFormatters: inputFormatters,
      style: TextStyle(
        color: textColor ?? Colors.white,
        fontWeight: FontWeight.w400,
      ),
      textInputAction: textInputAction,
      decoration: InputDecoration(
        errorMaxLines: 3,
        counterText: '',
        errorStyle: TextStyle(color: Theme.of(context).errorColor),
        errorText: errorText,
        focusColor: errorText != null
            ? Theme.of(context).errorColor
            : Theme.of(context).highlightColor,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: sufixIcon != null
            ? GestureDetector(
          onTap: sufixIconTap,
          child: Icon(
            sufixIcon,
            color:
            errorText != null ? Theme.of(context).errorColor : Colors.white,
          ),
        )
            : null,
        prefixIcon: prefixIcon != null
            ? GestureDetector(
          onTap: prefixIconTap,
          child: Icon(
            prefixIcon,
            color:
            errorText != null ? Theme.of(context).errorColor : Colors.white,
          ),
        )
            : null,
        labelText: label,
        labelStyle: TextStyle(color: labelColor ?? Colors.white),
        hintStyle: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: textColor ?? Colors.white),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            // style: BorderStyle.solid,
            // width: borderWidth != null ? borderWidth : 2,
            color: borderColor != null ? borderColor! : Colors.grey[300]!,
          ),
          borderRadius: borderRadius != null
              ? BorderRadius.all(Radius.circular(borderRadius!))
              : BorderRadius.zero,
        ),
        filled: true,
        fillColor:
        isEnabled! ? fillColor ?? Colors.white : const Color(0xFFF1F1F1),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: borderWidth != null ? borderWidth! : 1,
            color: focusedBorderColor != null ? borderColor! : Colors.grey[300]!,
          ),
          borderRadius: borderRadius != null
              ? BorderRadius.all(Radius.circular(borderRadius!))
              : const BorderRadius.all(Radius.circular(0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: borderWidth != null ? borderWidth! : 1,
            color: Colors.grey[300]!,
          ),
          borderRadius: borderRadius != null
              ? BorderRadius.all(Radius.circular(borderRadius!))
              : const BorderRadius.all(Radius.circular(0)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: borderWidth != null ? borderWidth! : 1,
            color: Theme.of(context).errorColor,
          ),
          borderRadius: borderRadius != null
              ? BorderRadius.all(Radius.circular(borderRadius!))
              : const BorderRadius.all(Radius.circular(0)),
        ),
        enabled: isEnabled!,
      ),
    );
  }
}
