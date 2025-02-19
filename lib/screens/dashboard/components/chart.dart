import '../../../core/data/data_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';

class Chart extends StatelessWidget {
  const Chart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signalementCounts = context.watch<DataProvider>().getSignalementCounts();
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: _buildPieChartSelectionData(context),
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: defaultPadding),
                Consumer<DataProvider>(
                  builder: (context, dataProvider, child) {
                    return Text(
                      '${signalementCounts["Tous les signalements"] ?? 0}',
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                    );
                  },
                ),
                SizedBox(height: defaultPadding),
                Text("Signalements")
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSelectionData(BuildContext context) {
    final DataProvider dataProvider = Provider.of<DataProvider>(context);
    final pieChartData = dataProvider.getPieChartData();

    int totalSignalement = pieChartData["totalSignalement"] ?? 0;;
    int totalCloture = pieChartData["totalCloture"] ?? 0;
  int totalNonCloture = pieChartData["totalNonCloture"] ?? 0;

    List<PieChartSectionData> pieChartSelectionData = [

      PieChartSectionData(
        color: Color(0xFFEE2727),
        value: totalNonCloture.toDouble(),
        showTitle: false,
        radius: 20,
      ),

      PieChartSectionData(
        color: Color(0xFF26FF31),
        value: totalCloture.toDouble(),
        showTitle: false,
        radius: 20,
      ),
    ];

    return pieChartSelectionData;
  }
}

