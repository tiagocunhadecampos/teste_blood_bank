import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Definindo o tipo de mensagem
enum SnackBarType { success, error }

void messageSnackBar(String message, SnackBarType type) {
  String title;
  Color backgroundColor;
  Color textColor;

  switch (type) {
    case SnackBarType.success:
      title = "Sucesso";
      backgroundColor = Colors.white;
      textColor = Colors.green;
      break;
    case SnackBarType.error:
      title = "Atenção";
      backgroundColor = Colors.white;
      textColor = Colors.red;
      break;
  }

  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.TOP,
    backgroundColor: backgroundColor,
    colorText: textColor,
    duration: const Duration(seconds: 3),
  );
}
