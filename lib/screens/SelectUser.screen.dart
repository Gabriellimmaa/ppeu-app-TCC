import 'package:flutter/material.dart';
import 'package:ppue/constants/constants.dart';
import 'package:ppue/core/notifier/authentication.notifier.dart';
import 'package:ppue/core/notifier/user.notifier.dart';
import 'package:ppue/screens/Home.screen.dart';
import 'package:ppue/widgets/CustomPageContainer.widget.dart';
import 'package:ppue/widgets/CustomScaffold.widget.dart';
import 'package:ppue/widgets/GradientButton.widget.dart';
import 'package:provider/provider.dart';

class SelectUserScreen extends StatefulWidget {
  const SelectUserScreen({Key? key}) : super(key: key);

  @override
  State<SelectUserScreen> createState() => _SelectUserScreenState();
}

class _SelectUserScreenState extends State<SelectUserScreen> {
  @override
  Widget build(BuildContext context) {
    AuthenticationNotifier authenticationNotifier =
        Provider.of<AuthenticationNotifier>(
      context,
      listen: false,
    );
    UserNotifier userNotifier = Provider.of<UserNotifier>(
      context,
      listen: false,
    );
    return CustomScaffold(
        appBar: AppBar(
          title: Text('PPEU'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                authenticationNotifier.logout(context: context);
              },
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Image.asset('assets/images/logo2.png',
                  height: 200, width: 200),
            ),
            spacingRow,
            Expanded(
                child: CustomPageContainer(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text('Estabelecimento de saúde'),
                        DropdownButton(
                            value: 'mobileHu',
                            items: const [
                              DropdownMenuItem(
                                value: 'mobileHu',
                                child: Text('Hospitalar - HU Londrina'),
                              ),
                              DropdownMenuItem(
                                value: 'hospitalHzn',
                                child: Text('Hospitalar - HZN'),
                              ),
                              DropdownMenuItem(
                                value: 'hospitalIscal',
                                child: Text('Hospitalar - ISCAL'),
                              ),
                              DropdownMenuItem(
                                value: 'samuLondrina',
                                child: Text('Móvel - SAMU/Londrina'),
                              )
                            ],
                            onChanged: (value) {}),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: GradientButton(
                                onPressed: () {
                                  userNotifier.setType(1);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()));
                                },
                                text: 'Logar como unidade móvel',
                              ),
                            ),
                            spacingRow,
                            SizedBox(
                              width: double.infinity,
                              child: GradientButton(
                                onPressed: () {
                                  userNotifier.setType(2);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()));
                                },
                                text: 'Logar como unidade hospitalar',
                              ),
                            )
                          ],
                        ))
                  ]),
            ))
          ],
        ));
  }
}
