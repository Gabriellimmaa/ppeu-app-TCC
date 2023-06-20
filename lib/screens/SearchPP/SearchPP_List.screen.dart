import 'package:flutter/material.dart';
import 'package:ppue/constants/constants.dart';
import 'package:ppue/models/PP.model.dart';
import 'package:ppue/screens/ViewPP.screen.dart';
import 'package:ppue/utils/formater/DateFormatter.util.dart';
import 'package:ppue/widgets/CustomPageContainer.widget.dart';
import 'package:ppue/widgets/CustomScaffold.widget.dart';

class SearchPPListScreen extends StatefulWidget {
  const SearchPPListScreen({Key? key}) : super(key: key);

  @override
  State<SearchPPListScreen> createState() => _SearchPPListScreenState();
}

class _SearchPPListScreenState extends State<SearchPPListScreen> {
  final List<PPModel> items = [
    examplePP,
    examplePP,
    examplePP,
    examplePP,
    examplePP,
    examplePP,
    examplePP
  ];

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
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.identificacao.nome,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              formatDate(
                                DateTime.parse(
                                    item.identificacao.dataNascimento),
                                format: FormatDate.diaMesNomeAno,
                              ),
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        subtitle: Column(children: [
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text('DN: ${item.identificacao.dataNascimento}'),
                              Text(
                                  '- Unidade/hospital: ${item.identificacao.formaEncaminhamento}'),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Reponsável pelo encaminhamento: ${item.situacao.enfermeiroResponsavelTransferencia}',
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
