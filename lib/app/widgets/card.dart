import 'package:flutter/material.dart';
import 'package:skycraft/app/constants/theme_data.dart';

class CustomCard extends StatelessWidget {
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Decoration? foregroundDecoration;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? margin;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;
  final Widget? child;
  final BoxShape? shape;
  const CustomCard({
    super.key,
    this.alignment,
    this.padding,
    this.color,
    this.foregroundDecoration,
    this.width,
    this.height,
    this.constraints,
    this.margin,
    this.transform,
    this.shape,
    this.transformAlignment,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? kBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: kSecondaryColor.withOpacity(0.1),
            blurRadius: 1.5,
            offset: const Offset(0, 0.5),
          ),
        ],
        shape: shape ?? BoxShape.rectangle,
        border: Border.all(
          color: const Color(0xff565479).withOpacity(0.1),
        ),
        borderRadius: shape == null ? BorderRadius.circular(10) : null,
      ),
      alignment: alignment,
      padding: padding,
      color: color,
      foregroundDecoration: foregroundDecoration,
      width: width,
      height: height,
      constraints: constraints,
      margin: margin,
      transform: transform,
      transformAlignment: transformAlignment,
      child: child,
    );
  }
}
