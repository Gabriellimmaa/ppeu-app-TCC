import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? text;
  final List<Color>? gradientColors;
  final double borderRadius;
  final double width;
  final double height;
  final TextStyle textStyle;
  final Widget? child;

  const GradientButton({
    required this.onPressed,
    this.text,
    this.child,
    this.gradientColors,
    this.borderRadius = 6.0,
    this.width = double.infinity,
    this.height = 50.0,
    this.textStyle = const TextStyle(color: Colors.white),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(
          colors: gradientColors ??
              [
                Color.fromARGB(255, 5, 179, 179),
                Colors.blue,
              ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            onPrimary: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          child: child ??
              Text(
                text ?? '',
                style: textStyle,
              )),
    );
  }
}
