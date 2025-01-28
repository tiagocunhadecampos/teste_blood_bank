import 'package:blood_bank_app/controller/data_controller.dart';
import 'package:blood_bank_app/views/widgets/analysis_menu.widget.dart';
import 'package:blood_bank_app/views/widgets/average_age_by_blood_type.widget.dart';
import 'package:blood_bank_app/views/widgets/count_by_state.widget.dart';
import 'package:blood_bank_app/views/widgets/average_imc_by_age_group.widget.dart';
import 'package:blood_bank_app/views/widgets/obesity.percentage.widget.dart';
import 'package:blood_bank_app/views/widgets/possible_donors_by_blood_type.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<DataController> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text(
              "Banco de Sangue",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.red,
            iconTheme: const IconThemeData(color: Colors.white),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.file_upload),
                onPressed: () async {
                  await controller.sendData();
                },
              ),
            ],
          ),
          body: Obx(() {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      "Análise de Candidatos a Doadores de Sansgue",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: AnalysisMenu(
                      value: controller.selectedOption.value != null &&
                              controller.options.values
                                  .contains(controller.selectedOption.value)
                          ? controller.selectedOption.value
                          : null,
                      onChanged: (String? newValue) async {
                        if (newValue != null) {
                          final index = int.parse(newValue);
                          await controller.getData(index);
                          controller.selectedOption.value = newValue;
                          controller.pageController.jumpToPage(index);
                        }
                      },
                      items: controller.options.entries.map((entry) {
                        return DropdownMenuItem<String>(
                          value: entry.key,
                          child: Text(entry.value),
                        );
                      }).toList(),
                    ),
                  ),
                  Expanded(
                    child: PageView(
                        controller: controller.pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: controller.selectedOption.value != null
                            ? [
                                CountByStateWidget(controller.donorByState),
                                AverageImcByAgeGroupWidget(
                                    controller.averageImcByAgeGroup),
                                ObesityPercentageWidget(
                                    controller.obesityPercentage),
                                AverageAgeByBloodTypeWidget(
                                    controller.averageAgeByBloodTypeWidget),
                                PossibleDonorsByBloodTypeWidget(
                                    controller.possibleDonorsByBloodType),
                              ]
                            : [
                                Center(
                                  child: Text(
                                    controller.messageInit.value,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey),
                                  ),
                                ),
                              ]),
                  )
                ],
              ),
            );
          }),
        ),
        Obx(() {
          return Visibility(
            visible: controller.isLoading.value,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              ),
            ),
          );
        })
      ],
    );
  }
}
