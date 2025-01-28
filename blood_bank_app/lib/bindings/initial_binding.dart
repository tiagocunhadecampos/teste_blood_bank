import 'package:blood_bank_app/controller/data_controller.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../repository/api_repository_impl.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    final dio = Dio();
    final repository = ApiRepositoryImpl(dio);
    Get.put<DataController>(DataController(repository));
  }
}
