// Flutter imports:

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skycraft/app/constants/theme_data.dart';

class Screen extends StatelessWidget {
  final Widget? header;
  final Widget body;
  final bool createSafeArea;
  final EdgeInsets padding;
  final bool scroll;
  final SystemUiOverlayStyle overlayStyle;
  final Color? backgroundColor;
  final Widget? leading;
  final Widget? headerWidget;

  Screen({
    super.key,
    SystemUiOverlayStyle? overlayStyle,
    EdgeInsets? padding,
    this.header,
    required this.body,
    this.createSafeArea = true,
    this.scroll = false,
    this.backgroundColor,
    this.headerWidget,
    this.leading,
  })  : padding = padding ?? const EdgeInsets.symmetric(horizontal: 16),
        overlayStyle = overlayStyle ??
            SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: kBackgroundColor,
            );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // uniqueKey: key every time,
      key: UniqueKey(),
      backgroundColor: backgroundColor,
      body: Container(
        // padding: padding,
        decoration: const BoxDecoration(),
        child: body,
      ),
    );
  }
}
