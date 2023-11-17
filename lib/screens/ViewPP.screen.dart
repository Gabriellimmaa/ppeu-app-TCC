import 'package:flutter/material.dart';
import 'package:ppeu/models/PP.model.dart';
import 'package:ppeu/screens/newPP/NewPP_A.screen.dart';
import 'package:ppeu/screens/newPP/NewPP_B.screen.dart';
import 'package:ppeu/screens/newPP/NewPP_I.screen.dart';
import 'package:ppeu/screens/newPP/NewPP_R.screen.dart';
import 'package:ppeu/screens/newPP/NewPP_S.screen.dart';
import 'package:ppeu/widgets/ViewPPNavigator.widget.dart';

class ViewPPScreen extends StatefulWidget {
  final PPModel data;
  final bool canEditStatus;
  const ViewPPScreen({Key? key, required this.data, this.canEditStatus = false})
      : super(key: key);

  @override
  State<ViewPPScreen> createState() => _ViewPPScreenState();
}

class _ViewPPScreenState extends State<ViewPPScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ViewPPNavigator(
        title: "Detalhes PP",
        willPopScope: false,
        currentIndex: _currentIndex,
        pp: widget.data,
        canEditStatus: widget.canEditStatus,
        screens: [
          NewPP_I(data: widget.data),
          NewPP_S(data: widget.data),
          NewPP_B(data: widget.data),
          NewPP_A(data: widget.data),
          NewPP_R(data: widget.data),
        ],
        bottomNavigationBarItems: [
          IconButton(
            icon: Icon(Icons.file_copy),
            onPressed: () {
              showCancelConfirmationDialog(context);
            },
            color: Colors.white,
          ),
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              _onTabTapped('previous');
            },
            color: Colors.white,
          ),
          Text(
            'I',
            style: TextStyle(
              fontSize: _currentIndex == 0 ? 24 : 16,
              color: _currentIndex == 0 ? Colors.white : Colors.black,
              fontWeight:
                  _currentIndex == 0 ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            'S',
            style: TextStyle(
              fontSize: _currentIndex == 1 ? 24 : 16,
              color: _currentIndex == 1 ? Colors.white : Colors.black,
              fontWeight:
                  _currentIndex == 1 ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            'B',
            style: TextStyle(
              fontSize: _currentIndex == 2 ? 24 : 16,
              color: _currentIndex == 2 ? Colors.white : Colors.black,
              fontWeight:
                  _currentIndex == 2 ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            'A',
            style: TextStyle(
              fontSize: _currentIndex == 3 ? 24 : 16,
              color: _currentIndex == 3 ? Colors.white : Colors.black,
              fontWeight:
                  _currentIndex == 3 ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            'R',
            style: TextStyle(
              fontSize: _currentIndex == 4 ? 24 : 16,
              color: _currentIndex == 4 ? Colors.white : Colors.black,
              fontWeight:
                  _currentIndex == 4 ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () {
              _onTabTapped('next');
            },
            color: Colors.white,
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
            color: Colors.white,
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
