import 'package:flutter/material.dart';
import 'package:ppeu/widgets/GradientContainer.widget.dart';

class CustomScaffold extends Scaffold {
  CustomScaffold({
    Widget? body,
    PreferredSizeWidget? appBar,
    bool extendBodyBehindAppBar = true,
    Widget? bottomNavigationBar,
  }) : super(
          body: gradientContainer(
            child: Column(
              children: [
                SizedBox(
                  child: appBar,
                ),
                Expanded(
                  child: body!,
                ),
              ],
            ),
          ),
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          bottomNavigationBar: bottomNavigationBar,
        );
}
