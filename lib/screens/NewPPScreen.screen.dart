import 'package:flutter/material.dart';
import 'package:ppue/screens/newPP/NewPP_A.screen.dart';
import 'package:ppue/screens/newPP/NewPP_B.screen.dart';
import 'package:ppue/screens/newPP/NewPP_I.screen.dart';
import 'package:ppue/screens/newPP/NewPP_R.screen.dart';
import 'package:ppue/screens/newPP/NewPP_S.screen.dart';
import 'package:ppue/widgets/NewPPNavigator.widget.dart';

class NewPPScreen extends StatefulWidget {
  const NewPPScreen({Key? key}) : super(key: key);

  @override
  State<NewPPScreen> createState() => _NewPPScreenState();
}

class _NewPPScreenState extends State<NewPPScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NewPPNavigator(currentIndex: _currentIndex, screens: const [
      NewPP_I(),
      NewPP_S(),
      NewPP_B(),
      NewPP_A(),
      NewPP_R(),
    ], bottomNavigationBarItems: [
      IconButton(
        icon: Icon(Icons.cancel),
        onPressed: () {
          showCancelConfirmationDialog(context);
        },
        color: Colors.red,
      ),
      IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          _onTabTapped('previous');
        },
        color: Colors.blue,
      ),
      Text(
        'I',
        style: TextStyle(
          fontSize: _currentIndex == 0 ? 20 : 16,
          fontWeight: _currentIndex == 0 ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      Text(
        'S',
        style: TextStyle(
          fontSize: _currentIndex == 1 ? 20 : 16,
          fontWeight: _currentIndex == 1 ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      Text(
        'B',
        style: TextStyle(
          fontSize: _currentIndex == 2 ? 20 : 16,
          fontWeight: _currentIndex == 2 ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      Text(
        'A',
        style: TextStyle(
          fontSize: _currentIndex == 3 ? 20 : 16,
          fontWeight: _currentIndex == 3 ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      Text(
        'R',
        style: TextStyle(
          fontSize: _currentIndex == 4 ? 20 : 16,
          fontWeight: _currentIndex == 4 ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      IconButton(
        icon: Icon(Icons.arrow_forward_ios),
        onPressed: () {
          _onTabTapped('next');
        },
        color: Colors.blue,
      ),
      IconButton(
        icon: Icon(Icons.save),
        onPressed: () {},
        color: Colors.blue,
      ),
    ]);
  }

  Future<void> showCancelConfirmationDialog(BuildContext context) async {
    final confirmed = await showDialog<bool>(
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
    );

    if (confirmed ?? false) {
      // Realizar as ações necessárias para descartar a nova PP e voltar para a tela anterior
      Navigator.of(context).pop();
    }
  }

  void _onTabTapped(String action) {
    int newIndex = _currentIndex;

    if (action == 'next') {
      newIndex++;
    } else if (action == 'previous') {
      newIndex--;
    }

    if (newIndex < 0) newIndex = 0;
    if (newIndex > 4) newIndex = 4;

    setState(() {
      _currentIndex = newIndex;
    });
  }
}
