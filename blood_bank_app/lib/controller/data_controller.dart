import 'dart:io';

import 'package:blood_bank_app/models/donor_model.dart';
import 'package:blood_bank_app/utils/snackbar.util.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../repository/api_repository.dart';

class DataController extends GetxController {
  final ApiRepository apiRepository;

  DataController(this.apiRepository);

  final pageController = PageController();
  final isLoading = false.obs;
  final selectedOption = Rx<String?>(null);
  final analysisData = <Donor>[].obs;
  final donorByState = <String, int>{}.obs;
  final obesityPercentage = <String, double>{}.obs;
  final averageImcByAgeGroup = <String, double>{}.obs;
  final averageAgeByBloodTypeWidget = <String, double>{}.obs;
  final possibleDonorsByBloodType = <String, List<dynamic>>{}.obs;
  final messageInit = ''.obs;
  final Map<String, String> options = {
    '0': "Total por Estados do Brasil",
    '1': "IMC médio em cada faixa de idade de dez em dez anos",
    '2': "Percentual de obesos entre os homens e mulheres",
    '3': "Média de idade para cada tipo sanguíneo",
    '4': "Quantidade de possíveis doadores para cada tipo sanguíneo receptor",
  };

  @override
  void onInit() {
    super.onInit();

    checkIfDataExists();
  }

  Future<void> checkIfDataExists() async {
    isLoading.value = true;
    try {
      final bool hasData = await apiRepository.hasData();
      if (!hasData) {
        messageInit.value =
            'Por favor, clique no botão de upload no menu para enviar os dados (json).';
      } else {
        messageInit.value = 'Por favor, selecione uma opção no menu acima.';
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getData(int index) async {
    switch (index) {
      case 0:
        await countDonorsByState();
        break;
      case 1:
        await fetchAverageImcByAgeGroup();
        break;
      case 2:
        await fetchObesityPercentage();
        break;
      case 3:
        await fetchAverageAgeByBloodType();
        break;
      case 4:
        await fetchPossibleDonorsByBloodType();
        break;
    }
  }

  Future<void> countDonorsByState() async {
    try {
      isLoading.value = true;
      donorByState.clear();
      final result = await apiRepository.countDonorsByState();
      donorByState.addAll(result);
      donorByState.refresh();
    } catch (e) {
      messageSnackBar("Erro ao buscar dados", SnackBarType.error);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAverageImcByAgeGroup() async {
    try {
      isLoading.value = true;
      averageImcByAgeGroup.clear();
      final result = await apiRepository.averageImcByAgeGroup();
      averageImcByAgeGroup.addAll(result);
      averageImcByAgeGroup.refresh();
    } catch (e) {
      messageSnackBar("Erro ao buscar IMC médio", SnackBarType.error);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchObesityPercentage() async {
    try {
      isLoading.value = true;
      obesityPercentage.clear();
      final result = await apiRepository.obesityPercentage();
      obesityPercentage.addAll(result);
      obesityPercentage.refresh();
    } catch (e) {
      messageSnackBar(
          "Erro ao buscar percentual de obesidade", SnackBarType.error);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAverageAgeByBloodType() async {
    try {
      isLoading.value = true;
      averageAgeByBloodTypeWidget.clear();
      final result = await apiRepository.averageAgeByBloodType();
      averageAgeByBloodTypeWidget.addAll(result);
      averageAgeByBloodTypeWidget.refresh();
    } catch (e) {
      messageSnackBar("Erro ao buscar média de idade por tipo sanguíneo",
          SnackBarType.error);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchPossibleDonorsByBloodType() async {
    try {
      isLoading.value = true;
      possibleDonorsByBloodType.clear();
      final result = await apiRepository.possibleDonorsByBloodType();
      possibleDonorsByBloodType.addAll(result);
      possibleDonorsByBloodType.refresh();
    } catch (e) {
      messageSnackBar("Erro ao buscar possíveis doadores por tipo sanguíneo",
          SnackBarType.error);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendData() async {
    final result = await FilePicker.platform.pickFiles(
      dialogTitle: "Selecione um arquivo JSON",
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result == null ||
        result.files.isEmpty ||
        result.files.single.path == null) {
      return;
    }
    try {
      isLoading.value = true;
      final file = File(result.files.single.path!);
      final content = await file.readAsString();

      await apiRepository.sendDonors(content);
    } finally {
      isLoading.value = false;
    }
  }
}
