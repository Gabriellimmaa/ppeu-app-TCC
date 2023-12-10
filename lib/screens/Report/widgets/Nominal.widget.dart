import 'package:flutter/material.dart';
import 'package:ppeu/core/notifier/authentication.notifier.dart';
import 'package:ppeu/core/notifier/database.notifier.dart';
import 'package:ppeu/core/notifier/mobileUnit.notifier.dart';
import 'package:ppeu/models/MobileUnit.model.dart';
import 'package:ppeu/models/PP.model.dart';
import 'package:ppeu/models/PPStatus.model.dart';
import 'package:ppeu/screens/Report/widgets/ModalReportFilters.widget.dart';
import 'package:ppeu/screens/ViewPP.screen.dart';
import 'package:provider/provider.dart';

class Nominal extends StatefulWidget {
  final ReportFilters? filter;
  final AuthenticationNotifier authentication;
  const Nominal({Key? key, required this.filter, required this.authentication})
      : super(key: key);

  @override
  NominalState createState() => NominalState();
}

class NominalState extends State<Nominal> {
  bool isLoading = true;
  List<PPModel> data = [];
  Future<void> fetchData(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    DatabaseNotifier databasePP =
        Provider.of<DatabaseNotifier>(context, listen: false);

    var responsePP = await databasePP.filterPP(
      startDate: widget.filter?.startDate ??
          DateTime.now().subtract(Duration(days: 10)),
      endDate: widget.filter?.endDate ?? DateTime.now().add(Duration(days: 1)),
      hospitalUnit: widget.filter?.hospitalUnit,
      mobileUnit: widget.filter?.mobileUnit,
      hospitalUnitsOptions:
          widget.authentication.hospitalUnits?.map((e) => e.id).toList(),
      mobileUnitsOptions:
          widget.authentication.mobileUnits?.map((e) => e.name).toList(),
      status: widget.filter?.status,
    );

    setState(() {
      data = responsePP;
      isLoading = false;
    });
  }

  @override
  void didUpdateWidget(Nominal oldWidget) {
    if (widget.filter != oldWidget.filter) {
      fetchData(context);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    fetchData(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MobileUnitNotifier mobileUnitNotifier =
        Provider.of<MobileUnitNotifier>(context, listen: false);

    return isLoading
        ? Center(child: CircularProgressIndicator())
        : data.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Nenhuma PP econtrada.",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Por favor, reveja e ajuste seus critérios de busca.",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              )
            : ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  PPModel item = data[index];

                  return FutureBuilder(
                    future: mobileUnitNotifier
                        .findByName(item.identificacao.formaEncaminhamento),
                    builder: (BuildContext context,
                        AsyncSnapshot<MobileUnitModel> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Padding(
                          padding: EdgeInsets.all(16),
                          child: SizedBox(
                            height: 50,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        MobileUnitModel? mobileUnit = snapshot.data;
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewPPScreen(data: item),
                              ),
                            );
                          },
                          child: Column(children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 50,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.network(
                                          mobileUnit!.image,
                                          width: 35,
                                          height: 35,
                                          fit: BoxFit.cover,
                                        ),
                                        if (item.status == PPStatus.CONFIRMED)
                                          Icon(Icons.arrow_circle_down,
                                              color: Colors.green),
                                        if (item.status ==
                                            PPStatus.WAITING_CONFIRMATION)
                                          Icon(Icons.arrow_circle_down,
                                              color: Colors.yellow.shade900),
                                        Image.network(
                                          item.recomendacoes.encaminhamento
                                              .image,
                                          width: 35,
                                          height: 35,
                                          fit: BoxFit.cover,
                                        )
                                      ]),
                                ),
                                Expanded(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 16),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          item.identificacao.nome,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          item.createdAt
                                              .toString()
                                              .substring(0, 10),
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    subtitle: Column(children: [
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Flexible(
                                              child: Text(
                                            'DN: ${item.identificacao.dataNascimento}',
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                          Flexible(
                                              child: Text(
                                            ' - Sexo: ${item.identificacao.sexo}',
                                            overflow: TextOverflow.ellipsis,
                                          ))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              'UH: ${item.recomendacoes.encaminhamento.surname}',
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              ' - UM: ${item.identificacao.formaEncaminhamento}',
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              'Resp. UH: ${item.recomendacoes.responsavelRecebimento.nome}',
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              'Resp. UM: ${item.situacao.enfermeiroResponsavelTransferencia}',
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        ],
                                      ),
                                    ]),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ViewPPScreen(data: item),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.list_alt,
                                    size: 32,
                                  ),
                                )
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        );
                      }
                    },
                  );
                },
              );
  }
}
