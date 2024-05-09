import 'package:flutter/material.dart';
import 'package:skycraft/app/constants/theme_data.dart';

class FieldDecoration {
  final String? labelText;
  final String? hintText;
  final String? prefixText;
  final String? suffixText;
  final String? helperText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Widget? suffix;

  FieldDecoration({
    this.labelText,
    this.hintText,
    this.prefixText,
    this.suffixText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,
  });

  InputDecoration get kInputDecoration => InputDecoration(
        // fillColor: kSecondaryColor,
        // filled: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        labelStyle: const TextStyle(
          color: kPrimaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: TextStyle(
          color: kPrimaryColor.withOpacity(0.35),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        prefixStyle: const TextStyle(
          color: kPrimaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        suffixStyle: const TextStyle(
          color: kPrimaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        helperStyle: const TextStyle(
          color: kPrimaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        errorStyle: const TextStyle(
          color: kTextColor,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        prefix: prefix,
        suffix: suffix,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        label: labelText != null ? Text(labelText!) : null,
        hintText: hintText,
        helperText: helperText,
        errorText: errorText,
        prefixText: prefixText,
        suffixText: suffixText,
      );
}
