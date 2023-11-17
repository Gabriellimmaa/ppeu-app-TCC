import 'package:flutter/material.dart';
import 'package:ppeu/widgets/GradientContainer.widget.dart';

class CustomScaffold extends Scaffold {
  CustomScaffold(
      {Widget? body,
      PreferredSizeWidget? appBar,
      bool extendBodyBehindAppBar = true,
      Widget? bottomNavigationBar,
      BottomNa})
      : super(
          body: gradientContainer(
            child: Column(
              children: [
                SizedBox(height: 80),
                Expanded(
                  child: body!,
                ),
              ],
            ),
          ),
          appBar: appBar,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          bottomNavigationBar: bottomNavigationBar,
        );
}
