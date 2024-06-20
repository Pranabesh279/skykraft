import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skycraft/app/constants/decorations.dart';
import 'package:skycraft/app/constants/theme_data.dart';

class EmailTextField extends StatelessWidget {
  final String name;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final VoidCallback onTap;
  final TextInputType? keyboardType;
  final bool? enabled;
  const EmailTextField({
    super.key,
    required this.name,
    this.hintText,
    this.controller,
    required this.onTap,
    this.keyboardType,
    this.validator,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      validator: validator ??
          (value) {
            if (value!.isEmpty) {
              return 'Email is required';
            }
            if (!value.contains('@')) {
              return 'Please enter a valid email address';
            }
            return null;
          },
      inputFormatters: [
        // FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(120),
      ],
      style: const TextStyle(fontSize: 12, color: kPrimaryColor),
      onTap: onTap,
      keyboardType: keyboardType ?? TextInputType.emailAddress,
      decoration: FieldDecoration(
        hintText: hintText ?? 'Enter Your Email Id',
      ).kInputDecoration,
    );
  }
}
