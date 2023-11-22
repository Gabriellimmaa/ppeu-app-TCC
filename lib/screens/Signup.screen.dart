import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:ppeu/constants/constants.dart';
import 'package:ppeu/core/notifier/authentication.notifier.dart';
import 'package:ppeu/core/notifier/hospitalUnit.notifier.dart';
import 'package:ppeu/models/HospitalUnit.model.dart';
import 'package:ppeu/screens/Signin.screen.dart';
import 'package:ppeu/utils/inputMask/cpf.mask.dart';
import 'package:ppeu/utils/validation/cpf.validation.dart';
import 'package:ppeu/utils/validation/email.validation.dart';
import 'package:ppeu/widgets/CustomPageContainer.widget.dart';
import 'package:ppeu/widgets/CustomScaffold.widget.dart';
import 'package:ppeu/widgets/GradientButton.widget.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isLoading = true;
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _cpfController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  List<HospitalUnitModel> _hospitalUnitList = [];
  List<HospitalUnitModel> selectedHospitalUnits = [];

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _passwordConfirmFocusNode = FocusNode();

  bool _passwordVisible = false;
  bool _passwordConfirmVisible = false;

  final MaskTextInputFormatter _cpfFormatter = CPFMask.maskFormatter();

  Future<void> fetchData() async {
    HospitalUnitNotifier hospitalUnitNotifier =
        Provider.of<HospitalUnitNotifier>(context, listen: false);
    List<HospitalUnitModel> data = await hospitalUnitNotifier.fetchAll();
    setState(() {
      _hospitalUnitList = data;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

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
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          spacingRow,
                          TextFormField(
                            controller: _firstNameController,
                            decoration: InputDecoration(labelText: 'Nome'),
                            validator: (value) =>
                                value!.isEmpty ? 'Campo obrigatório' : null,
                            textInputAction: TextInputAction.next,
                          ),
                          spacingRow,
                          TextFormField(
                            controller: _lastNameController,
                            decoration: InputDecoration(labelText: 'Sobrenome'),
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
                              FocusScope.of(context)
                                  .requestFocus(_passwordFocusNode);
                            },
                          ),
                          spacingRow,
                          Text(
                            'Selecione o hospital que você trabalha:',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          spacingRow,
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: List.generate(_hospitalUnitList.length,
                                (index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (selectedHospitalUnits
                                        .contains(_hospitalUnitList[index])) {
                                      selectedHospitalUnits
                                          .remove(_hospitalUnitList[index]);
                                    } else {
                                      selectedHospitalUnits
                                          .add(_hospitalUnitList[index]);
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: selectedHospitalUnits.contains(
                                              _hospitalUnitList[index])
                                          ? Colors.blue
                                          : Colors.grey,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    _hospitalUnitList[index].surname,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: selectedHospitalUnits.contains(
                                              _hospitalUnitList[index])
                                          ? Colors.blue
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            }),
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
                                context: context,
                                email: email,
                                password: password,
                                firstName: _firstNameController.text,
                                lastName: _lastNameController.text,
                                taxId: _cpfController.text,
                                hospitalUnits: selectedHospitalUnits);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
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
