import 'package:blood_bank_app/utils/snackbar.util.dart';
import 'package:dio/dio.dart';

import '../models/donor_model.dart';
import 'api_repository.dart';

class ApiRepositoryImpl implements ApiRepository {
  final Dio dio;

  ApiRepositoryImpl(this.dio) {
    dio.options.baseUrl = 'http://192.168.1.178:8080/api';
    dio.options.headers = {'Content-Type': 'application/json'};
  }

  @override
  Future<bool> hasData() async {
    try {
      final response = await dio.get('/donors/has-data');

      if (response.statusCode == 200 && response.data == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      messageSnackBar("Error occurred: $e", SnackBarType.error);
      return false;
    }
  }

  @override
  Future<void> sendDonors(String donors) async {
    try {
      final response = await dio.post('/donors', data: donors);

      if (response.statusCode == 200) {
        if (response.data is String) {
          messageSnackBar(response.data, SnackBarType.success);
        } else {
          messageSnackBar("Unexpected response format!", SnackBarType.error);
        }
      } else {
        messageSnackBar("Failed to send data!", SnackBarType.error);
      }
    } catch (e) {
      messageSnackBar("Error occurred: $e", SnackBarType.error);
    }
  }

  @override
  Future<Map<String, int>> countDonorsByState() async {
    try {
      final response = await dio.get('/donors/count-by-state');
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        final convertedData =
            data.map((key, value) => MapEntry(key, (value as num).toInt()));

        return convertedData;
      } else {
        throw Exception("Failed to fetch data.");
      }
    } catch (e) {
      throw Exception("Error occurred: $e");
    }
  }

  @override
  Future<Map<String, double>> averageImcByAgeGroup() async {
    try {
      final response = await dio.get('/donors/average-imc-by-age');

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return data
            .map((key, value) => MapEntry(key, (value as num).toDouble()));
      } else {
        throw Exception("Failed to fetch data.");
      }
    } catch (e) {
      throw Exception("Error occurred: $e");
    }
  }

  @override
  Future<Map<String, double>> obesityPercentage() async {
    try {
      final response = await dio.get('/donors/obesity-percentage');

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return data
            .map((key, value) => MapEntry(key, (value as num).toDouble()));
      } else {
        throw Exception("Failed to fetch data.");
      }
    } catch (e) {
      throw Exception("Error occurred: $e");
    }
  }

  @override
  Future<Map<String, double>> averageAgeByBloodType() async {
    try {
      final response = await dio.get('/donors/average-age-by-blood-type');

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return data
            .map((key, value) => MapEntry(key, (value as num).toDouble()));
      } else {
        throw Exception("Failed to fetch data.");
      }
    } catch (e) {
      throw Exception("Error occurred: $e");
    }
  }

  @override
  Future<Map<String, List<Donor>>> possibleDonorsByBloodType() async {
    try {
      final response = await dio.get('/donors/possible-donors-by-blood-type');

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return data.map((key, value) => MapEntry(
              key,
              (value as List)
                  .map((donorJson) => Donor.fromJson(donorJson))
                  .toList(),
            ));
      } else {
        throw Exception("Failed to fetch data.");
      }
    } catch (e) {
      throw Exception("Error occurred: $e");
    }
  }
}
