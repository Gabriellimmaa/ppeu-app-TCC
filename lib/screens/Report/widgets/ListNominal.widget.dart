import 'package:flutter/material.dart';
import 'package:ppue/models/PP.model.dart';
import 'package:ppue/screens/ViewPP.screen.dart';
import 'package:ppue/utils/formater/DateFormatter.util.dart';

class ListNominal extends StatelessWidget {
  final List<PPModel> items;
  const ListNominal({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        PPModel item = items[index];
        return GestureDetector(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => ViewPPScreen(data: item),
            //   ),
            // );
          },
          child: Column(children: [
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          'https://cdn.discordapp.com/attachments/825790215556825099/1120708884374507630/924e5ac2f7dee4f2c6cf0b2db36f389e.jpg',
                          width: 35,
                          height: 35,
                          fit: BoxFit.cover,
                        ),
                        Icon(
                          Icons.arrow_circle_down,
                          color: Colors.orange,
                        ),
                        Image.network(
                          'https://cdn.discordapp.com/attachments/825790215556825099/1120708884663894107/b4c80f34cc40fa34545eaecc86ac992c.png',
                          width: 35,
                          height: 35,
                          fit: BoxFit.cover,
                        )
                      ]),
                ),
                Expanded(
                    child: Column(
                  children: [
                    ListTile(
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewPPScreen(data: item),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.list_alt,
                          size: 32,
                        ),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.identificacao.nome,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            formatDate(
                              DateTime.parse(item.identificacao.dataNascimento),
                              format: FormatDate.diaMesNomeAno,
                            ),
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
                                '- UM/UH: ${item.identificacao.formaEncaminhamento}->${item.recomendacoes.encaminhamento}',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                'Resp. encamin. UM: ${item.situacao.enfermeiroResponsavelTransferencia}',
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                'Resp. recepção UH: ${item.situacao.enfermeiroResponsavelTransferencia}',
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ]),
                    ),
                  ],
                ))
              ],
            ),
            SizedBox(
              height: 8,
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
      },
    );
  }
}
