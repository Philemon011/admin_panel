import 'package:admin/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../utility/constants.dart';
import 'components/add_typeSignalement_form.dart';
import 'components/typeSignalement_header.dart';
import 'components/typeSignalement_list_section.dart';

class TypeSignalementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            CategoryHeader(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text(
                              "Les Types de Signalement",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          ElevatedButton.icon(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: defaultPadding * 1.5,
                                vertical: defaultPadding,
                              ),
                            ),
                            onPressed: () {
                              showAddTypeSignalementForm(context, null);
                            },
                            icon: Icon(
                              Icons.add,
                              color: primaryColor,
                            ),
                            label: Text(
                              "Nouveau",
                              style: TextStyle(color: primaryColor),
                            ),
                          ),
                          Gap(20),
                          IconButton(
                              onPressed: () {
                                context.dataProvider.getAllTypeSignalement(showSnack: true);
                              },
                              icon: Icon(
                                Icons.refresh,
                                color: primaryColor,
                              )),
                        ],
                      ),
                      Gap(defaultPadding),
                      TypeSignalementListSection(),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
