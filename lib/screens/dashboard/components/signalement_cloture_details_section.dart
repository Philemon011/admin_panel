import 'package:admin/core/routes/app_pages.dart';
import 'package:admin/screens/Login/login_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/data/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';
import 'chart.dart';
import 'signalement_info_card.dart';

class SignalementClotureDetailsSection extends StatelessWidget {
  const SignalementClotureDetailsSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) {
        final signalementCounts =
            context.watch<DataProvider>().getPieChartData();

        int totalSignalement = signalementCounts["totalSignalement"] ?? 0;
        int totalCloture = signalementCounts["totalCloture"] ?? 0;
        int totalNonCloture = signalementCounts["totalNonCloture"] ?? 0;

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
                "Détail Clôture des Signalements",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: defaultPadding),
              Chart(),
              SignalementInfoCard(
                couleur: Color(0xFFEE2727),
                title: "Signalement Non Clôturé",
                totalSignalement: totalNonCloture,
              ),
              SignalementInfoCard(
                couleur: Color(0xFF26FF31),
                title: "Signalement Clôturés",
                totalSignalement: totalCloture,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Spacer(),
                  TextButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {
                        box.erase();
                        Get.toNamed(AppPages.LOGIN);
                        // print(box.read('name'));
                      },
                      child: Row(
                        children: [
                          Text(
                            "Déconnexion",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.logout,
                            color: Colors.white,
                          )
                        ],
                      )),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
