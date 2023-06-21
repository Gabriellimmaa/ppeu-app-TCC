import 'package:flutter/material.dart';
import 'package:ppue/constants/constants.dart';
import 'package:ppue/routes/app.routes.dart';
import 'package:ppue/screens/Signin.screen.dart';
import 'package:ppue/screens/Signup.screen.dart';
import 'package:ppue/widgets/CustomPageContainer.widget.dart';
import 'package:ppue/widgets/CustomScaffold.widget.dart';
import 'package:ppue/widgets/GradientButton.widget.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  var counter = 0;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: Text('PPEU'),
        centerTitle: true,
      ),
      body:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Center(
          child:
              Image.asset('assets/images/logo2.png', height: 200, width: 200),
        ),
        spacingRow,
        Expanded(
            child: CustomPageContainer(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Bem-vindo profissional de saúde!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Para iniciar, faça login caso já tenha uma conta ou inicie um novo cadastro de usuário',
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GradientButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.SingupRoute);
                      },
                      text: 'Novo cadastro',
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: GradientButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.SinginRoute);
                      },
                      text: 'Login',
                    ),
                  ),
                ],
              ),
            ),
          ],
        )))
      ]),
    );
  }
}
