import 'package:flutter/material.dart';

class CustomPageContainer extends Container {
  CustomPageContainer(
      {Widget? child, double? height, EdgeInsetsGeometry? padding})
      : super(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            height: height,
            child: child,
            padding: padding,
            margin: EdgeInsets.only(top: 5));
}
