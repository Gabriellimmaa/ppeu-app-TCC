import 'package:flutter/material.dart';
import 'package:ppeu/core/notifier/database.notifier.dart';
import 'package:ppeu/models/PP.model.dart';
import 'package:ppeu/widgets/CustomPageContainer.widget.dart';
import 'package:ppeu/widgets/CustomScaffold.widget.dart';
import 'package:provider/provider.dart';

class ViewPPNavigator extends StatelessWidget {
  final int currentIndex;
  final List<Widget> screens;
  final List<Widget> bottomNavigationBarItems;
  final bool willPopScope;
  final bool canEditStatus;
  final String title;
  final PPModel? pp;

  const ViewPPNavigator(
      {Key? key,
      required this.title,
      required this.currentIndex,
      required this.screens,
      required this.bottomNavigationBarItems,
      this.canEditStatus = false,
      this.pp,
      this.willPopScope = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DatabaseNotifier databaseNotifier =
        Provider.of<DatabaseNotifier>(context, listen: false);

    if (willPopScope == false) {
      return buildScaffold(
          databaseNotifier: databaseNotifier, context: context, id: pp?.id);
    } else {
      return WillPopScope(
        onWillPop: () async {
          return await showExitConfirmationDialog(context);
        },
        child: buildScaffold(
            databaseNotifier: databaseNotifier, context: context, id: pp?.id),
      );
    }
  }

  Scaffold buildScaffold(
      {required DatabaseNotifier databaseNotifier,
      required BuildContext context,
      int? id}) {
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
                Color.fromARGB(255, 87, 167, 233),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (canEditStatus)
                InkWell(
                  onTap: () async {
                    var response = await databaseNotifier
                        .changeStatusToConfirmed(context: context, id: id!);
                    if (response) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: const [
                          Color.fromARGB(255, 224, 224, 224),
                          Color.fromRGBO(168, 255, 176, 1),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      border: Border(
                        top: BorderSide(color: Colors.grey, width: 0.5),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.check_box, color: Colors.green),
                          SizedBox(width: 8),
                          Text(
                            'Recepcionar PP',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [...bottomNavigationBarItems],
              ),
            ],
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
