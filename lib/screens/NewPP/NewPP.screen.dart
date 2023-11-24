import 'package:flutter/material.dart';
import 'package:ppeu/core/notifier/database.notifier.dart';
import 'package:ppeu/core/notifier/newPP.notifier.dart';
import 'package:ppeu/models/PP.model.dart';
import 'package:ppeu/screens/newPP/NewPP_A.screen.dart';
import 'package:ppeu/screens/newPP/NewPP_B.screen.dart';
import 'package:ppeu/screens/newPP/NewPP_I.screen.dart';
import 'package:ppeu/screens/newPP/NewPP_R.screen.dart';
import 'package:ppeu/screens/newPP/NewPP_S.screen.dart';
import 'package:ppeu/widgets/ViewPPNavigator.widget.dart';
import 'package:provider/provider.dart';

class NewPPScreen extends StatefulWidget {
  const NewPPScreen({Key? key}) : super(key: key);

  @override
  State<NewPPScreen> createState() => _NewPPScreenState();
}

class _NewPPScreenState extends State<NewPPScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    DatabaseNotifier databaseNotifier =
        Provider.of<DatabaseNotifier>(context, listen: false);

    NewPPNotifier newPPNotifier =
        Provider.of<NewPPNotifier>(context, listen: false);

    return ViewPPNavigator(
        title: "Cadastrar PP",
        currentIndex: _currentIndex,
        screens: const [
          NewPP_I(),
          NewPP_S(),
          NewPP_B(),
          NewPP_A(),
          NewPP_R(),
        ],
        bottomNavigationBarItems: [
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
              List<GlobalKey<FormState>> formKeys = [];
              formKeys.add(newPPNotifier.formKeyIdentificacao);
              formKeys.add(newPPNotifier.formKeySituacao);
              formKeys.add(newPPNotifier.formKeyBreveHistorico);
              formKeys.add(newPPNotifier.formKeyAvaliacao);
              formKeys.add(newPPNotifier.formKeyRecomendacoes);

              if (formKeys[_currentIndex].currentState!.validate()) {
                formKeys[_currentIndex].currentState!.save();
                _onTabTapped('next');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Preencha todos os campos obrigatórios'),
                  ),
                );
              }
            },
            color: Colors.white,
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () async {
              databaseNotifier.addPP(
                  context: context,
                  data: PPModel(
                      identificacao: newPPNotifier.identificacao,
                      situacao: newPPNotifier.situacao,
                      breveHistorico: newPPNotifier.breveHistorico,
                      avaliacao: newPPNotifier.avaliacao,
                      recomendacoes: newPPNotifier.recomendacoes));

              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title:
                          Text('Passagem de Plantão cadastrada com sucesso!'),
                      content: Text(
                          'Você está sendo redirecionado para a tela de inicial.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  }).then((value) {
                Navigator.of(context).pop();
              });
            },
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
