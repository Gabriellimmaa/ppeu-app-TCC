import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:ppue/utils/inputMask/cpf.mask.dart';
import 'package:ppue/utils/validation/cpf.validation.dart';
import 'package:ppue/utils/validation/email.validation.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cpfController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _passwordVisible = false;
  bool _passwordConfirmVisible = false;

  final MaskTextInputFormatter _cpfFormatter = CPFMask.maskFormatter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PPEU'),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return constraints.maxHeight >= MediaQuery.of(context).size.height
              ? SingleChildScrollView(
                  child: buildForm(),
                )
              : buildForm();
        },
      ),
    );
  }

  Widget buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nome'),
              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              controller: _cpfController,
              inputFormatters: [_cpfFormatter],
              decoration: InputDecoration(labelText: 'CPF'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Campo obrigatório';
                } else if (!validateCPF(value)) {
                  return 'CPF inválido';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-mail'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Campo obrigatório';
                } else if (!validateEmail(value)) {
                  return 'E-mail inválido';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              controller: _confirmPasswordController,
              validator: (value) => value!.isEmpty
                  ? 'Campo obrigatório'
                  : value != _passwordController.text
                      ? 'As senhas não coincidem'
                      : null,
              obscureText: !_passwordVisible,
              decoration: InputDecoration(
                labelText: 'Crie uma senha',
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              controller: _confirmPasswordController,
              obscureText: !_passwordConfirmVisible,
              validator: (value) => value!.isEmpty
                  ? 'Campo obrigatório'
                  : value != _passwordController.text
                      ? 'As senhas não coincidem'
                      : null,
              decoration: InputDecoration(
                labelText: 'Confirme sua senha',
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordConfirmVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordConfirmVisible = !_passwordConfirmVisible;
                    });
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text('Confirmar cadastro'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text('Utilize uma conta Google'),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      elevation: 0,
                    ),
                    child: Text(
                      'Já possui uma conta? Faça login!',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
