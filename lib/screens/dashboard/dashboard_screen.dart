import 'package:admin/utility/extensions.dart';

import 'components/dash_board_header.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../utility/constants.dart';
import 'components/signalement_cloture_details_section.dart';
import 'components/signalement_list_section.dart';
import 'components/signalement_summery_section.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            DashBoardHeader(),
            Gap(defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Les Signalements",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          
                          Gap(20),
                          IconButton(
                              onPressed: () {
                                context.dataProvider.getAllSignalement(showSnack: true);
                              },
                              icon: Icon(
                                Icons.refresh,
                                color: primaryColor,
                              )),
                        ],
                      ),
                      Gap(defaultPadding),
                      SignalementSummerySection(),
                      Gap(defaultPadding),
                      SignalementsListSection(),
                    ],
                  ),
                ),
                SizedBox(width: defaultPadding),
                Expanded(
                  flex: 2,
                  child: SignalementClotureDetailsSection(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
