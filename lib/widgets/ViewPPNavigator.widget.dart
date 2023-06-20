import 'package:flutter/material.dart';
import 'package:ppue/widgets/CustomPageContainer.widget.dart';
import 'package:ppue/widgets/CustomScaffold.widget.dart';
import 'package:ppue/widgets/GradientContainer.widget.dart';

class ViewPPNavigator extends StatelessWidget {
  final int currentIndex;
  final List<Widget> screens;
  final List<Widget> bottomNavigationBarItems;
  final bool willPopScope;
  final String title;

  const ViewPPNavigator(
      {Key? key,
      required this.title,
      required this.currentIndex,
      required this.screens,
      required this.bottomNavigationBarItems,
      this.willPopScope = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (willPopScope == false) {
      return buildScaffold();
    } else {
      return WillPopScope(
        onWillPop: () async {
          return await showExitConfirmationDialog(context);
        },
        child: buildScaffold(),
      );
    }
  }

  Scaffold buildScaffold() {
    return CustomScaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: CustomPageContainer(
          child: IndexedStack(
        index: currentIndex,
        children: screens,
      )),
      bottomNavigationBar: BottomAppBar(
        child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: const [
                  Color.fromARGB(255, 2, 189, 189),
                  Colors.blue,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [...bottomNavigationBarItems],
            )),
      ),
    );
  }

  Future<bool> showExitConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Deseja cancelar/descartar nova PP?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Não'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Sim'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
