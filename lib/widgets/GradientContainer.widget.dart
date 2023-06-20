import 'package:flutter/material.dart';

Container gradientContainer({required Widget child}) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: const [
          Color.fromARGB(255, 2, 189, 189),
          Colors.blue,
          Colors.blue,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    child: child,
  );
}
