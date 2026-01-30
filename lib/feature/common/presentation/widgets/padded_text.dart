import 'package:flutter/material.dart';

class PaddedText extends StatelessWidget {
  const PaddedText({
    required this.text,
    required this.style,
    super.key,
    this.padding = .zero,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final TextStyle style;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        text,
        style: color != null ? style.copyWith(color: color) : style,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      ),
    );
  }
}
