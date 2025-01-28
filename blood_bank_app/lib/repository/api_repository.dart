import 'package:blood_bank_app/models/donor_model.dart';

abstract class ApiRepository {
  Future<bool> hasData();
  Future<void> sendDonors(String donors);
  Future<Map<String, int>> countDonorsByState();
  Future<Map<String, double>> averageImcByAgeGroup();
  Future<Map<String, double>> obesityPercentage();
  Future<Map<String, double>> averageAgeByBloodType();
  Future<Map<String, List<Donor>>> possibleDonorsByBloodType();
}
