import 'package:flutter/material.dart';

class NewPPNavigator extends StatelessWidget {
  final int currentIndex;
  final List<Widget> screens;
  final List<Widget> bottomNavigationBarItems;

  const NewPPNavigator({
    Key? key,
    required this.currentIndex,
    required this.screens,
    required this.bottomNavigationBarItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showExitConfirmationDialog(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cadastrar PP'),
          centerTitle: true,
        ),
        body: Theme(
          data: ThemeData(
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          child: IndexedStack(
            index: currentIndex,
            children: screens,
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.blue[100],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [...bottomNavigationBarItems],
          ),
        ),
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
