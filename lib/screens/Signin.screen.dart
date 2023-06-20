import 'package:flutter/material.dart';
import 'package:ppue/constants/constants.dart';
import 'package:ppue/providers/UserProvider.provider.dart';
import 'package:ppue/screens/selectUser.screen.dart';
import 'package:ppue/widgets/CustomPageContainer.widget.dart';
import 'package:ppue/widgets/CustomScaffold.widget.dart';
import 'package:ppue/widgets/GradientButton.widget.dart';
import 'package:provider/provider.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _passwordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: AppBar(
          title: Text('LOGIN'),
          centerTitle: true,
        ),
        body: CustomPageContainer(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              spacingRow,
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'E-mail'),
              ),
              spacingRow,
              TextField(
                  controller: _passwordController,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  )),
              spacingRow,
              SizedBox(
                width: double.infinity,
                child: GradientButton(
                  text: 'Avançar',
                  onPressed: () {
                    // Acesso aos valores digitados
                    String nome = _emailController.text;
                    String email = _passwordController.text;

                    final userProvider =
                        Provider.of<UserProvider>(context, listen: false);
                    userProvider.setUser('Gabriel Lima', 'token');

                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/select_user',
                      (route) => false,
                    );
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary:
                        Colors.transparent, // Define o background transparente
                    elevation: 0, // Remove a sombra
                  ),
                  child: Text('Esqueci minha senha',
                      style: TextStyle(
                        color: Colors.grey, // Define a cor do texto como preto
                      )),
                  onPressed: () {
                    // Acesso aos valores digitados
                    String nome = _emailController.text;
                    String email = _passwordController.text;

                    // Realizar ações com os valores (exemplo)
                    print('Nome: $nome');
                    print('E-mail: $email');
                  },
                ),
              )
            ],
          ),
        ));
  }
}
