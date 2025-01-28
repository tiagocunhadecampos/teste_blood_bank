import 'dart:math';
import 'package:blood_bank_app/views/widgets/no_data_available.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';

Widget PossibleDonorsByBloodTypeWidget(Map<String, List<dynamic>> donorsData) {
  if (donorsData.isEmpty) {
    return NoDataAvailableWidget();
  }

  final dataMap =
      donorsData.map((key, value) => MapEntry(key, value.length.toDouble()));

  final totalDonors = dataMap.values.reduce((a, b) => a + b).toInt();

  final List<Color> colorList = List.generate(dataMap.length, (index) {
    final Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1, // Opacidade
    );
  });

  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Total de Possíveis Doadores: $totalDonors",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        PieChart(
          dataMap: dataMap,
          animationDuration: const Duration(seconds: 1),
          chartLegendSpacing: 32,
          chartRadius: MediaQuery.of(Get.context!).size.width / 2.5,
          colorList: colorList,
          chartType: ChartType.disc,
          ringStrokeWidth: 32,
          legendOptions: const LegendOptions(
            showLegends: false,
          ),
          chartValuesOptions: const ChartValuesOptions(
            showChartValueBackground: false,
            showChartValues: false,
            showChartValuesInPercentage: false,
            decimalPlaces: 0,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          children: dataMap.entries.map((entry) {
            int index = dataMap.keys.toList().indexOf(entry.key);
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: colorList[index],
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  "${entry.key}: ${entry.value.toInt()} doadores",
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    ),
  );
}
