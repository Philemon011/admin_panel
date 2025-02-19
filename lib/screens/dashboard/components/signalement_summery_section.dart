import 'package:admin/models/signalement_summery_info.dart';
import 'package:admin/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/data/data_provider.dart';
import '../../../utility/constants.dart';
import 'signamement_summery_card.dart';

class SignalementSummerySection extends StatelessWidget {
  const SignalementSummerySection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Consumer<DataProvider>(
      builder: (context, dataProvider, _) {
        final signalementCounts =
        context.watch<DataProvider>().getSignalementCounts();

        List<SignalementSummeryInfo> signalementSummeryItems = [
          SignalementSummeryInfo(
            signalementsCount: signalementCounts["Tous les signalements"] ?? 0,
            title: "Tous les signalements",
            svgSrc: "assets/icons/Product.svg",
            color: primaryColor,
          ),
          SignalementSummeryInfo(
            signalementsCount: signalementCounts["Non traité"] ?? 0,
            title: "Non traité",
            svgSrc: "assets/icons/Product2.svg",
            color: Color(0xFFEA3829),
          ),
          SignalementSummeryInfo(
            signalementsCount: signalementCounts["En cours"] ?? 0,
            title: "En cours",
            svgSrc: "assets/icons/Product3.svg",
            color: Color.fromARGB(255, 17, 0, 255),
          ),
          SignalementSummeryInfo(
            signalementsCount: signalementCounts["Autres"] ?? 0,
            title: "Autres",
            svgSrc: "assets/icons/Product4.svg",
            color: Color.fromARGB(255, 255, 123, 0),
          ),
        ];

        return Column(
          children: [
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: signalementSummeryItems.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: defaultPadding,
                mainAxisSpacing: defaultPadding,
                childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
              ),
              itemBuilder: (context, index) => SignalementSummeryCard(
                info: signalementSummeryItems[index],
                onTap: (signalementType) {
                  context.dataProvider
                      .filterSignalementByStatus(signalementType ?? "");
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
