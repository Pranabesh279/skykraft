import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skycraft/app/constants/decorations.dart';
import 'package:skycraft/app/constants/theme_data.dart';

class PassWordField extends StatefulWidget {
  final String name;
  final String? hintText;
  final TextEditingController? controller;
  final VoidCallback onTap;
  final String? Function(String?)? validator;
  const PassWordField({
    super.key,
    required this.name,
    this.hintText,
    this.controller,
    required this.onTap,
    this.validator,
  });

  @override
  State<PassWordField> createState() => _PassWordFieldState();
}

class _PassWordFieldState extends State<PassWordField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      validator: widget.validator ??
          (value) {
            if (value!.isEmpty) {
              return 'Password is required';
            }
            if (value.length < 8) {
              return 'Password must be at least 8 characters long';
            }
            return null;
          },
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r'[ ]')),
        LengthLimitingTextInputFormatter(16),
      ],
      style: const TextStyle(fontSize: 16, color: kPrimaryColor),
      keyboardType: TextInputType.visiblePassword,
      onTap: widget.onTap,
      decoration: FieldDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          icon: Icon(
            !_obscureText
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: Colors.grey,
            size: 24,
          ),
        ),
        hintText: widget.hintText ?? 'Enter your password',
      ).kInputDecoration,
      controller: widget.controller,
    );
  }
}
