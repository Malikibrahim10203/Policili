import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;
import 'package:policili_apps/generate_page.dart';
import 'package:policili_apps/models/external_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiExternalController extends GetxController {

  Rx<ExternalUser?> externalUser = Rx<ExternalUser?>(null);
  RxString suhu = ''.obs;
  RxString humidity = ''.obs;
  RxString soilMoisture = ''.obs;
  RxString ph = ''.obs;

  RxString recommendationResult = ''.obs;

  Future<ExternalUser?> getDataThinger(email) async {
    final url = Uri.https('www.meep-lab.cloud', '/api/users/getUser',{'email':email});
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if(response.statusCode == 201 || response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ExternalUser.fromJson(data);
    } else {
      throw Exception('External API failed: ${response.statusCode}');
    }
  }


  void saveDataThinger(user, email) async {

    externalUser.value = await getDataThinger(email);

    try {
      final prefs = await SharedPreferences.getInstance();
      if(user!=null && externalUser.value!.deviceId.isNotEmpty && externalUser.value!.sensorId.isNotEmpty && externalUser.value!.usernameThinger.isNotEmpty){
        Map<String, dynamic> sensor = {
          'deviceId':externalUser.value!.deviceId,
          'sensorId':externalUser.value!.sensorId,
          'userName':externalUser.value!.usernameThinger
        };

        String jsonString = jsonEncode(sensor); // ubah map ke string
        await prefs.setString('data_sensor', jsonString);
      } else {
        print('Data tidak lengkap, tidak disimpan');
      }

    } catch(e) {
      print('Error on shared preference save data sensor: $e');
    }
  }

  void getTokenThinger() async {

    final prefs = await SharedPreferences.getInstance();
    final storage = await FlutterSecureStorage();

    String? thingerDataJson = await prefs.getString('data_sensor');
    if(thingerDataJson!=null){

      Map<String, dynamic> thingerData = jsonDecode(thingerDataJson);
      String? password = await storage.read(key: 'password');

      try {
        final storage = FlutterSecureStorage();

        final url = Uri.parse("https://api.thinger.io/oauth/token");
        final response = await http.post(
            url,
            body: {
              'grant_type':'password',
              'username':thingerData['userName'],
              'password':password
            }
        );

        Map<String, dynamic> responseBody = jsonDecode(response.body);

        if(response.statusCode == 200 && responseBody.containsKey('access_token')) {
          await storage.write(key: 'access_token', value: responseBody['access_token']);
          await storage.write(key: 'refresh_token', value: responseBody['refresh_token']);

          print(responseBody);

        } else {
          Get.snackbar("Get token failed.", responseBody['error']);
          print("Access token is missing or invalid.");
        }
      } catch(e) {
        print("Error on get token thinger: $e");
      }
    }
  }

  void showGeneratePage() async {
    final storage = FlutterSecureStorage();
    String? tokenAccess = await storage.read(key: 'access_token');
    String? refreshToken = await storage.read(key: 'refresh_token');

    try {
      final prefs = await SharedPreferences.getInstance();

      final jsonString = await prefs.getString('data_sensor');
      if (jsonString == null) {
        print('Data sensor tidak ditemukan.');
        return;
      }
      Map<String, dynamic>? sensorMap = jsonDecode(jsonString);
      final String? deviceId = sensorMap!['deviceId'];
      final String? sensorId = sensorMap!['sensorId'];
      final String? userName = sensorMap!['userName'];
      print(deviceId);
      print(sensorId);
      print(userName);

      final url = Uri.parse("https://api.thinger.io/v3/users/${userName}/devices/${deviceId}/properties/${sensorId}");
      final response = await http.get(
          url,
          headers: {
            'Authorization': 'Bearer ${tokenAccess}',
            'Content-Type': 'application/json'
          }
      );
      if(response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        String dataResponse = responseBody['value']['sensor'];
        List partOfResponse = dataResponse.split('#');

        suhu.value = partOfResponse[0];
        humidity.value = partOfResponse[1];
        soilMoisture.value = partOfResponse[2];
        ph.value = partOfResponse[3];

        print(response.statusCode);
        print(responseBody['value']);
        getRecommendation();
      } else {
        print(response.statusCode);
        refsreshTokenThinger();
      }
    } catch(e) {
      print('Error at show generate page: $e');
    }
  }

  void refsreshTokenThinger() async {
    final storage = FlutterSecureStorage();
    final refreshToken = await storage.read(key: 'refresh_token');

    try {
      final url = Uri.parse('https://api.thinger.io/oauth/token');
      final response = await http.post(
        url,
        body: {
          'grant_type': 'refresh_token',
          'refresh_token': refreshToken
        }
      );
      if(response.statusCode != 200 || response.statusCode != 201){
        print('Failed to renew token.');
        print(response.statusCode);
        print(response.body);
        return;
      } else {
        print('Success to renew token.');
      }
    } catch(e) {
      print('Error at refresh token: $e');
    }
  }

  void getRecommendation() async {
    try{
      final url = Uri.parse("https://neusisco-TrainSpace.hf.space/predict");
      final response = await http.post(
        url,
        body: jsonEncode({
          "suhu": suhu.value,
          "kelembaban_udara": humidity.value,
          "kelembaban_tanah": soilMoisture.value,
          "ph": ph.value
        })
      );
      if(response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        recommendationResult.value = responseBody['rekomendasi_tanaman'];
        print(recommendationResult);
        Get.to(GeneratePage());
      } else {
        print("Failed to get recommendation: ${response.body}");
      }
    }catch(e){
      print('Error get recommendation at: $e');
    }
  }
}
