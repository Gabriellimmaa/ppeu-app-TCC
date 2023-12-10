import 'package:flutter/material.dart';
import 'package:ppeu/core/notifier/mobileUnit.notifier.dart';
import 'package:ppeu/models/MobileUnit.model.dart';
import 'package:ppeu/models/PP.model.dart';
import 'package:ppeu/models/PPStatus.model.dart';
import 'package:ppeu/screens/ViewPP.screen.dart';
import 'package:ppeu/widgets/CustomPageContainer.widget.dart';
import 'package:ppeu/widgets/CustomScaffold.widget.dart';
import 'package:provider/provider.dart';

class SearchPPListScreen extends StatefulWidget {
  final List<dynamic> ppModels;

  final String hospitalUnit;

  const SearchPPListScreen({
    Key? key,
    required this.ppModels,
    required this.hospitalUnit,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<SearchPPListScreen> createState() => _SearchPPListScreenState(
        items: ppModels,
        hospitalUnit: hospitalUnit,
      );
}

class _SearchPPListScreenState extends State<SearchPPListScreen> {
  final List<dynamic> items;

  final String hospitalUnit;

  _SearchPPListScreenState({
    required this.items,
    required this.hospitalUnit,
  });

  @override
  Widget build(BuildContext context) {
    MobileUnitNotifier mobileUnitNotifier =
        Provider.of<MobileUnitNotifier>(context, listen: false);

    return CustomScaffold(
      appBar: AppBar(
        title: Text('Localizar PPs'),
        centerTitle: true,
      ),
      body: CustomPageContainer(
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              PPModel item = items[index];

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
                      child: Column(
                        children: [
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
                                        item.recomendacoes.encaminhamento.image,
                                        width: 35,
                                        height: 35,
                                        fit: BoxFit.cover,
                                      )
                                    ]),
                              ),
                              Expanded(
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 16),
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
                                        item.createdAt.toString(),
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
                              Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.list_alt, size: 24),
                                    if (item.status == PPStatus.CONFIRMED)
                                      Icon(Icons.check_box,
                                          color: Colors.green, size: 24),
                                    if (item.status ==
                                        PPStatus.WAITING_CONFIRMATION)
                                      Icon(Icons.access_time_filled,
                                          color: Colors.yellow.shade900,
                                          size: 24),
                                  ],
                                ),
                              ),
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
                        ],
                      ),
                    );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
