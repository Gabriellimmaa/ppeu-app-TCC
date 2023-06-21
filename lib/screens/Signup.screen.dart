import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:ppue/constants/constants.dart';
import 'package:ppue/core/notifier/authentication.notifier.dart';
import 'package:ppue/screens/Signin.screen.dart';
import 'package:ppue/utils/inputMask/cpf.mask.dart';
import 'package:ppue/utils/validation/cpf.validation.dart';
import 'package:ppue/utils/validation/email.validation.dart';
import 'package:ppue/widgets/CustomPageContainer.widget.dart';
import 'package:ppue/widgets/CustomScaffold.widget.dart';
import 'package:ppue/widgets/GradientButton.widget.dart';
import 'package:provider/provider.dart';

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
  final _passwordConfirmController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _passwordConfirmFocusNode = FocusNode();

  bool _passwordVisible = false;
  bool _passwordConfirmVisible = false;

  final MaskTextInputFormatter _cpfFormatter = CPFMask.maskFormatter();

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: Text('Criar conta'),
        centerTitle: true,
      ),
      body: CustomPageContainer(child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return constraints.maxHeight >= MediaQuery.of(context).size.height
              ? SingleChildScrollView(
                  child: buildForm(),
                )
              : buildForm();
        },
      )),
    );
  }

  Widget buildForm() {
    final AuthenticationNotifier authenticationNotifier =
        Provider.of<AuthenticationNotifier>(
      context,
      listen: false,
    );

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    spacingRow,
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Nome'),
                      validator: (value) =>
                          value!.isEmpty ? 'Campo obrigatório' : null,
                      textInputAction: TextInputAction.next,
                    ),
                    spacingRow,
                    TextFormField(
                      controller: _cpfController,
                      inputFormatters: [_cpfFormatter],
                      decoration: InputDecoration(labelText: 'CPF'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo obrigatório';
                        } else if (!validateCPF(value)) {
                          return 'CPF inválido';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    spacingRow,
                    TextFormField(
                      focusNode: _emailFocusNode,
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
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      },
                    ),
                    spacingRow,
                    TextFormField(
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      validator: (value) => value!.isEmpty
                          ? 'Campo obrigatório'
                          : value != _passwordConfirmController.text
                              ? 'As senhas não coincidem'
                              : null,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        labelText: 'Crie uma senha',
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
                      ),
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => FocusScope.of(context)
                          .requestFocus(_passwordConfirmFocusNode),
                    ),
                    spacingRow,
                    TextFormField(
                      controller: _passwordConfirmController,
                      focusNode: _passwordConfirmFocusNode,
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
                              _passwordConfirmVisible =
                                  !_passwordConfirmVisible;
                            });
                          },
                        ),
                      ),
                      textInputAction: TextInputAction.done,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: double.infinity,
                child: GradientButton(
                  text: 'Confirmar cadastro',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String email = _emailController.text;
                      String password = _passwordController.text;

                      await authenticationNotifier.singup(
                          context: context, email: email, password: password);
                    }
                  },
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SigninScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
