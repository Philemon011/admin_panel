import 'package:admin/main.dart';
import 'package:admin/models/status.dart';
import 'package:admin/models/typeSignalement.dart';

import '../../../core/data/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';
import '../../../utility/extensions.dart';
import '../../../models/category.dart';

class TypeSignalementListSection extends StatelessWidget {
  const TypeSignalementListSection({
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
            "Tous les types de Status",
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
                      label: Text("Libelle"),
                    ),
                    DataColumn(
                      label: Text("Crée le "),
                    ),
                    // DataColumn(
                    //   label: Text("Modifier"),
                    // ),
                    // DataColumn(
                    //   label: Text("Supprimer"),
                    // ),
                  ],
                  rows: List.generate(
                    dataProvider.status.length,
                    (index) => statusDataRow(
                        dataProvider.status[index],  edit: () {

                    }, delete: () {
                    }),
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

DataRow statusDataRow(Status statusInfo,
    {Function? edit, Function? delete}) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            // Image.network(
            //   CatInfo.image ?? '',
            //   height: 30,
            //   width: 30,
            //   errorBuilder: (BuildContext context, Object exception,
            //       StackTrace? stackTrace) {
            //     return Icon(Icons.error);
            //   },
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Text(statusInfo.nom_status ?? ''),
            ),
          ],
        ),
      ),
      DataCell(Text(statusInfo.createdAt ?? '')),
      // DataCell(IconButton(
      //     onPressed: () {
      //       if (edit != null) edit();
      //     },
      //     icon: Icon(
      //       Icons.edit,
      //       color: Colors.white,
      //     ))),
      // DataCell(IconButton(
      //     onPressed: () {
      //       if (delete != null) delete();
      //       // print("object");
      //     },
      //     icon: Icon(
      //       Icons.delete,
      //       color: Colors.red,
      //     ))),
    ],
  );
}
