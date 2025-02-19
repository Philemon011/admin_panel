import 'package:admin/models/signalement.dart';
import 'package:admin/screens/signalements/components/view_signalements_form.dart';
import '../../../core/data/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';

class SignalementsListSection extends StatelessWidget {
  const SignalementsListSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tous les Signalements",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            width: double.infinity,
            child: Consumer<DataProvider>(
              builder: (context, dataProvider, child) {
                return DataTable(
                  columnSpacing: defaultPadding,
                  // minWidth: 600,
                  columns: [
                    DataColumn(
                      label: Text("Status"),
                    ),
                    DataColumn(
                      label: Text("N° de suivie"),
                    ),
                    DataColumn(
                      label: Text("Description"),
                    ),
                    // DataColumn(
                    //   label: Text("Type de Signalement"),
                    // ),
                    DataColumn(
                      label: Text("Date de creation"),
                    ),
                    // DataColumn(
                    //   label: Text("Clôturé"),
                    // ),
                    DataColumn(
                      label: Text("Voir Plus"),
                    ),
                  ],
                  rows: List.generate(
                    dataProvider.signalements.length,
                    (index) => SignalementDataRow(
                        dataProvider.signalements[index], index + 1,
                        viewMore: () {
                      showSignalementInfo(
                          context, dataProvider.signalements[index]);
                    }, edit: () {}),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

DataRow SignalementDataRow(Signalement signalementInfo, int index,
    {Function? edit, Function? viewMore}) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: getColorForStatus(signalementInfo.nomStatus ?? ''),
                shape: BoxShape.circle,
              ),
              child: Text("", textAlign: TextAlign.center),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(''),
            ),
          ],
        ),
      ),
      DataCell(Text(signalementInfo.codeDeSuivi ?? '')),
      DataCell(
        Text(
          (signalementInfo.description != null &&
                  signalementInfo.description!.length > 40)
              ? "${signalementInfo.description!.substring(0, 40)}..."
              : signalementInfo.description ?? '',
        ),
      ),
      DataCell(Text(signalementInfo.createdAt ?? '')),
      DataCell(IconButton(
          onPressed: () {
            if (viewMore != null) viewMore();
          },
          icon: Icon(
            Icons.remove_red_eye_sharp,
            color: Colors.white,
          ))),
    ],
  );
}

// Méthode pour obtenir la couleur en fonction du statut
Color getColorForStatus(String status) {
  switch (status) {
    case 'Non traité':
      return Color(0xFFFF3B30); // Rouge
    case 'En cours':
      return Color(0xFF007BFF); // Bleu clair
    case 'Résolu':
      return Color(0xFF28A745); // Vert
    case 'Rejeté':
      return Color(0xFFFFC107); // Orange
    default:
      return Colors.grey; // Couleur par défaut si le statut est inconnu
  }
}
