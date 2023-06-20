import 'package:flutter/material.dart';
import 'package:ppue/constants/constants.dart';
import 'package:ppue/screens/SearchPP/SearchPP_List.screen.dart';
import 'package:ppue/widgets/CustomPageContainer.widget.dart';
import 'package:ppue/widgets/CustomScaffold.widget.dart';
import 'package:ppue/widgets/GradientButton.widget.dart';
import 'package:ppue/widgets/inputs/DatePickerTextField.widget.dart';
import 'package:ppue/widgets/inputs/DropdownTextField.widget.dart';

class SearchPPScreen extends StatefulWidget {
  const SearchPPScreen({Key? key}) : super(key: key);

  @override
  State<SearchPPScreen> createState() => _SearchPPScreenState();
}

class _SearchPPScreenState extends State<SearchPPScreen> {
  DateTime selectedDate = DateTime.now();
  String? _selectedItem;
  String buttonText = 'Selecione';
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: AppBar(
          title: Text('Localizar PPs'),
          centerTitle: true,
        ),
        body: CustomPageContainer(
            child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: 25),
                  DropdownTextField(
                    labelText: 'Unidade hospitalar',
                    options: [
                      DropdownOption(displayText: 'ISCAL', value: 'ISCAL'),
                      DropdownOption(displayText: 'HU', value: 'HU'),
                      DropdownOption(displayText: 'HZN', value: 'HZN')
                    ],
                    onChanged: (value) => print(value),
                  ),
                  spacingRow,
                  DropdownTextField(
                    labelText: 'Responsável pelo recebimento',
                    options: [
                      DropdownOption(
                          displayText: 'Gabriel Lima', value: 'lima'),
                      DropdownOption(
                          displayText: 'Andre Menolli', value: 'menolli')
                    ],
                    onChanged: (value) => print(value),
                  ),
                  spacingRow,
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Nome do paciente',
                      suffixIcon: Icon(Icons.person),
                    ),
                  ),
                  spacingRow,
                  DatePickerTextField(
                    controller: _dateController,
                  ),
                ],
              ),
              GradientButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchPPListScreen(),
                      ),
                    );
                  },
                  text: 'Pesquisar')
            ],
          ),
        )));
  }
}
