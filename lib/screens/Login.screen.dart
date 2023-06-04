import 'package:flutter/material.dart';
import 'package:ppue/screens/selectUser.screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    return Scaffold(
        appBar: AppBar(
          title: Text('PPEU'),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'E-mail'),
              ),
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
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('Avançar'),
                  onPressed: () {
                    // Acesso aos valores digitados
                    String nome = _emailController.text;
                    String email = _passwordController.text;

                    // Realizar ações com os valores (exemplo)
                    print('Nome: $nome');
                    print('E-mail: $email');

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
