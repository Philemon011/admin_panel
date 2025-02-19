import 'package:admin/main.dart';
import 'package:admin/models/typeSignalement.dart';
import 'package:admin/models/user.dart';

import '../../../core/data/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';
import '../../../utility/extensions.dart';
import '../../../models/category.dart';
import 'update_user_form.dart';

class ListuserListSection extends StatelessWidget {
  const ListuserListSection({
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
            "Tous les Admins et Super Admins",
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
                      label: Text("Nom"),
                    ),
                    DataColumn(
                      label: Text("Email"),
                    ),
                    DataColumn(
                      label: Text("Role"),
                    ),
                    DataColumn(
                      label: Text("Modifier Rôle"),
                    ),
                    // DataColumn(
                    //   label: Text("Supprimer"),
                    // ),
                  ],
                  rows: List.generate(
                    dataProvider.users.length,
                    (index) => listUserDataRow(
                        dataProvider.users[index],  edit: () {
                      showUpdateUserRoleForm(context, 
                          dataProvider.users[index]);
                    }, delete: () {
                      // context.typeSignalementProvider.deleteTypeSignalement(dataProvider.typeSignalements[index]);
                    }
                    ),
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

DataRow listUserDataRow(User userInfo,
    {Function? edit, Function? delete}) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Text(userInfo.name ?? ''),
            ),
          ],
        ),
      ),
      DataCell(Text(userInfo.email ?? '')),
      DataCell(Text(userInfo.lib ?? '')),
      DataCell(IconButton(
          onPressed: () {
            if (edit != null) edit();
          },
          icon: Icon(
            Icons.edit,
            color: Colors.white,
          ))),
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
