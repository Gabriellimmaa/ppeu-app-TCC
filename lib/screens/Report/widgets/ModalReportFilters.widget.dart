import 'package:flutter/material.dart';
import 'package:ppue/constants/constants.dart';
import 'package:ppue/core/notifier/hospitalUnit.notifier.dart';
import 'package:ppue/core/notifier/mobileUnit.notifier.dart';
import 'package:ppue/models/PPStatus.model.dart';
import 'package:ppue/widgets/GradientButton.widget.dart';
import 'package:ppue/widgets/inputs/DatePickerTextField.widget.dart';
import 'package:provider/provider.dart';

class ReportFilters {
  DateTime? startDate;
  DateTime? endDate;
  String? mobileUnit;
  String? hospitalUnit;
  String? status;

  ReportFilters({
    required this.startDate,
    required this.endDate,
    required this.mobileUnit,
    required this.hospitalUnit,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'startDate': startDate,
      'endDate': endDate,
      'mobileUnit': mobileUnit,
      'hospitalUnit': hospitalUnit,
      'status': status,
    };
  }
}

class ModalReportFilters extends StatefulWidget {
  final Function(ReportFilters) onSubmit;
  final int indexPage;
  final ReportFilters? filters;

  const ModalReportFilters({
    Key? key,
    required this.onSubmit,
    required this.indexPage,
    required this.filters,
  }) : super(key: key);

  @override
  State<ModalReportFilters> createState() => _ModalReportFiltersState();
}

class _ModalReportFiltersState extends State<ModalReportFilters> {
  bool _isLoading = true;
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final List<DropdownMenuItem<String>> _mobileUnitList = [
    DropdownMenuItem(
      value: '',
      child: Text('Todos'),
    ),
  ];
  final List<DropdownMenuItem<String>> _hospitalUnitList = [
    DropdownMenuItem(
      value: '',
      child: Text('Todos'),
    ),
  ];
  DateTime? _endDateSelected;
  DateTime? _startDateSelected;
  String _unMovel = '';
  String _unEnc = '';
  String _stRecep = '';

  Future<void> fetchMobileUnits(BuildContext context) async {
    MobileUnitNotifier mobileUnitNotifier =
        Provider.of<MobileUnitNotifier>(context, listen: false);
    var data = await mobileUnitNotifier.fetchAll();
    for (var element in data) {
      _mobileUnitList.add(DropdownMenuItem(
        value: element.name,
        child: Text(element.name),
      ));
    }
  }

  Future<void> fetchHospitalUnits(BuildContext context) async {
    HospitalUnitNotifier hospitalUnitNotifier =
        Provider.of<HospitalUnitNotifier>(context, listen: false);
    var data = await hospitalUnitNotifier.fetchAll();
    for (var element in data) {
      _hospitalUnitList.add(DropdownMenuItem(
        value: element.name,
        child: Text(element.surname),
      ));
    }
  }

  Future<void> fetchData(BuildContext context) async {
    await Future.wait([
      fetchMobileUnits(context),
      fetchHospitalUnits(context),
    ]);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.indexPage == 0
        ? fetchData(context)
        : setState(() {
            _isLoading = false;
          });
    _startDateSelected = widget.filters?.startDate;
    _endDateSelected = widget.filters?.endDate;
    _unMovel = widget.filters?.mobileUnit ?? '';
    _unEnc = widget.filters?.hospitalUnit ?? '';
    _stRecep = widget.filters?.status ?? '';
  }

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(16),
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Form(
                      key: _formKey,
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Filtrar Relatórios',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.close,
                                  ),
                                  splashRadius: 20,
                                )
                              ],
                            ),
                            spacingRow,
                            SizedBox(
                              height: 50,
                              child: DatePickerTextField(
                                value: _startDateSelected,
                                onChanged: (value) => {
                                  setState(() {
                                    _startDateSelected = value;
                                  })
                                },
                                decoration: InputDecoration(
                                  labelText: 'Data Inicial',
                                  suffixIcon: Icon(Icons.calendar_today),
                                ),
                              ),
                            ),
                            spacingRow,
                            SizedBox(
                              height: 50,
                              child: DatePickerTextField(
                                value: _endDateSelected,
                                onChanged: (value) => {
                                  setState(() {
                                    _endDateSelected = value;
                                  })
                                },
                                decoration: InputDecoration(
                                  labelText: 'Data Final',
                                  suffixIcon: Icon(Icons.calendar_today),
                                ),
                              ),
                            ),
                            spacingRow,
                            widget.indexPage == 0
                                ? Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: const [
                                              Icon(Icons.car_crash),
                                              SizedBox(width: 8),
                                              Text('Un. Móvel'),
                                              SizedBox(width: 16),
                                            ],
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            child: DropdownButton(
                                              isExpanded: true,
                                              onChanged: (value) {
                                                setState(() {
                                                  _unMovel = value.toString();
                                                });
                                              },
                                              value: _unMovel,
                                              itemHeight: 50,
                                              items: _mobileUnitList,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: const [
                                              Icon(Icons.local_hospital),
                                              SizedBox(width: 8),
                                              Text('Un. Enc.'),
                                              SizedBox(width: 16),
                                            ],
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            child: DropdownButton<String>(
                                              isExpanded: true,
                                              onChanged: (value) {
                                                setState(() {
                                                  _unEnc = value.toString();
                                                });
                                              },
                                              value: _unEnc,
                                              itemHeight: 50,
                                              items: _hospitalUnitList,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: const [
                                              Icon(Icons.remove_red_eye),
                                              SizedBox(width: 8),
                                              Text('St. Recep.'),
                                              SizedBox(width: 16),
                                            ],
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            child: DropdownButton(
                                              isExpanded: true,
                                              onChanged: (value) {
                                                setState(() {
                                                  _stRecep = value.toString();
                                                });
                                              },
                                              itemHeight: 50,
                                              value: _stRecep,
                                              items: const [
                                                DropdownMenuItem(
                                                  value: '',
                                                  child: Text('Todos'),
                                                ),
                                                DropdownMenuItem(
                                                  value: PPStatus.CONFIRMED,
                                                  child: Text('Recepcionado'),
                                                ),
                                                DropdownMenuItem(
                                                  value: PPStatus
                                                      .WAITING_CONFIRMATION,
                                                  child: Text('Aguardando'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      spacingRow,
                                    ],
                                  )
                                : Container(),
                            SizedBox(
                                width: double.infinity,
                                child: GradientButton(
                                  height: 40,
                                  onPressed: () {
                                    widget.onSubmit(ReportFilters(
                                        startDate: _startDateSelected,
                                        endDate: _endDateSelected,
                                        mobileUnit:
                                            _unMovel == '' ? null : _unMovel,
                                        hospitalUnit:
                                            _unEnc == '' ? null : _unEnc,
                                        status:
                                            _stRecep == '' ? null : _stRecep));
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Filtrar',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                          ]),
                    )),
        ));
  }
}
