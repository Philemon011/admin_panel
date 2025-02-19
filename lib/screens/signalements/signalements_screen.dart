import 'package:admin/screens/signalements/provider/signalements_provider.dart';
import 'package:admin/utility/extensions.dart';
import 'package:provider/provider.dart';

import 'components/signalements_header.dart';
import 'components/signalements_list_section.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../utility/constants.dart';
import '../../widgets/custom_dropdown.dart';

class SignalementsScreen extends StatefulWidget {
  @override
  State<SignalementsScreen> createState() => _SignalementsScreenState();
}

class _SignalementsScreenState extends State<SignalementsScreen> {

  // @override
  // void initState() {
  //   super.initState();
  //   // Charger les statuts au démarrage
  //   Future.microtask(() {
  //     context.read<SignalementsProvider>().fetchStatuses();
  //   });
  // }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            SignalementsHeader(),
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
                            child: Row(
                              children: [
                                Text(
                                  "Liste des Signalements",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                SizedBox(width: defaultPadding),
                                SizedBox(width: defaultPadding),
                                SizedBox(width: defaultPadding),
                                SizedBox(width: defaultPadding),
                                legende(
                                    nomLegende: "Non traité",
                                    couleurLegende: Color(0xFFFF3B30)),
                                legende(
                                    nomLegende: "En cours",
                                    couleurLegende: Color(0xFF007BFF)),
                                legende(
                                    nomLegende: "Résolu",
                                    couleurLegende: Color(0xFF28A745)),
                                legende(
                                    nomLegende: "Rejeté",
                                    couleurLegende: Color(0xFFFFC107)),
                              ],
                            ),
                          ),
                          Gap(20),
                          SizedBox(
                            width: 280,
                            child: CustomDropdown(
                              hintText: 'Filtrer les signalements',
                              initialValue: 'Tous les signalements',
                              items: [
                                'Tous les signalements',
                                'Non traité',
                                'En cours',
                                'Résolu',
                                'Rejeté',
                              ],
                              displayItem: (val) => val,
                              onChanged: (newValue) {
                                if (newValue?.toLowerCase() ==
                                    'tous les signalements') {
                                  context.dataProvider.getAllSignalement();
                                } else {
                                  context.dataProvider
                                      .filterSignalements(newValue ?? '');
                                }
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Veuillez sélectionner le status';
                                }
                                return null;
                              },
                            ),
                          ),
                          Gap(40),
                          IconButton(
                              onPressed: () {
                                //TODO: should complete call getAllSignalement
                                context.dataProvider.getAllSignalement(showSnack: true);
                              },
                              icon: Icon(Icons.refresh)),
                        ],
                      ),
                      Gap(defaultPadding),
                      SignalementsListSection(),
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

  Row legende({required String nomLegende, required Color couleurLegende}) {
    return Row(
      children: [
        Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
            color: couleurLegende, 
            shape: BoxShape.circle,
          ),
          child: Text('', textAlign: TextAlign.center),
        ),
        SizedBox(width: 4.0),
        Text(nomLegende, textAlign: TextAlign.center),
        SizedBox(width: 4.0),
      ],
    );
  }
}
