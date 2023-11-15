import 'package:flutter/material.dart';
import 'package:ppue/models/PP.model.dart';
import 'package:ppue/models/PPStatus.model.dart';
import 'package:ppue/screens/ViewPP.screen.dart';
import 'package:ppue/widgets/CustomPageContainer.widget.dart';
import 'package:ppue/widgets/CustomScaffold.widget.dart';

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
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewPPScreen(data: item),
                    ),
                  );
                },
                child: SizedBox(
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                        // leading: Image.network(
                        //   item.imageUrl,
                        //   width: 50,
                        //   height: 50,
                        //   fit: BoxFit.cover,
                        // ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.list_alt),
                            if (item.status == PPStatus.CONFIRMED)
                              Icon(Icons.check_box, color: Colors.green),
                            if (item.status == PPStatus.WAITING_CONFIRMATION)
                              Icon(Icons.access_time_filled,
                                  color: Colors.yellow.shade900),
                          ],
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.identificacao.nome,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              item.createdAt.toString(),
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        subtitle: Column(children: [
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text('DN: ${item.identificacao.dataNascimento}'),
                              Text(' - Sexo: ${item.identificacao.sexo}'),
                            ],
                          ),
                          Row(
                            children: [
                              Text('UH: $hospitalUnit'),
                              Text(
                                  ' - UM: ${item.identificacao.formaEncaminhamento}'),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Resp. Enc: ${item.situacao.enfermeiroResponsavelTransferencia}',
                              ),
                            ],
                          ),
                        ]),
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
