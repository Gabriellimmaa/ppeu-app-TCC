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
  final int? notificationCount;

  const GradientButton({
    Key? key,
    required this.onPressed,
    this.text,
    this.child,
    this.gradientColors,
    this.borderRadius = 6.0,
    this.width = double.infinity,
    this.height = 50.0,
    this.textStyle = const TextStyle(color: Colors.white),
    this.notificationCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
              foregroundColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
            child: child ??
                Text(
                  text ?? '',
                  style: textStyle,
                ),
          ),
        ),
        if (notificationCount != null && notificationCount! > 0)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(4.0),
                color: Colors.redAccent,
              ),
              child: Text(
                '$notificationCount',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
