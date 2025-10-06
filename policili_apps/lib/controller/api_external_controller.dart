import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:policili_apps/change_profile.dart';
import 'package:policili_apps/generate_page.dart';
import 'package:policili_apps/history.dart';
import 'package:policili_apps/models/external_user.dart';
import 'package:policili_apps/models/history_predict.dart';
import 'package:policili_apps/models/tanaman_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiExternalController extends GetxController {

  Rx<ExternalUser?> externalUser = Rx<ExternalUser?>(null);
  RxList<HistoryPredict?> historyPredict = <HistoryPredict?>[].obs;
  RxString suhu = ''.obs;
  RxString humidity = ''.obs;
  RxString soilMoisture = ''.obs;
  RxString ph = ''.obs;

  // final phdum = "5";
  // final kelu = "0.59";
  // final kelta = "0.72";
  // final suhdum = "30";

  RxString recommendationResult = ''.obs;

  final dataTanaman = Rxn<TanamanModel>();
  final listDataTanaman = [].obs;

  final message = "".obs;

  final nameThinger = TextEditingController();
  final deviceThinger = TextEditingController();
  final sensorThinger = TextEditingController();
  final usernameThingerIo =  TextEditingController();

  RxBool isRecommendationLoading = false.obs;
  RxBool isChangeProfileLoading = false.obs;
  RxBool isLoading = false.obs;



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


  Future<void> saveDataThinger(user, email) async {

    externalUser.value = await getDataThinger(email);

    try {
      final prefs = await SharedPreferences.getInstance();
      if(user!=null && externalUser.value!.name.isNotEmpty && externalUser.value!.deviceId.isNotEmpty && externalUser.value!.sensorId.isNotEmpty && externalUser.value!.usernameThinger.isNotEmpty){
        Map<String, dynamic> sensor = {
          'name': externalUser.value!.name,
          'deviceId':externalUser.value!.deviceId,
          'sensorId':externalUser.value!.sensorId,
          'userName':externalUser.value!.usernameThinger
        };

        String jsonString = jsonEncode(sensor); // ubah map ke string
        await prefs.setString('data_sensor', jsonString);
        print('Save data thinger success');
      } else {
        print('Data tidak lengkap, tidak disimpan');
      }

    } catch(e) {
      print('Error on shared preference save data sensor: $e');
    }
  }

  Future<void> getTokenThinger() async {

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
          print("Save token success.${responseBody['refresh_token']??'null'}");

        } else {
          Get.snackbar("Get token failed.", responseBody['error']);
          print("Access token is missing or invalid.");
        }
      } catch(e) {
        print("Error on get token thinger: $e");
      }
    } else {
      print("Data thinger null");
    }
  }

  Future<void> showGeneratePage() async {
    isRecommendationLoading.value = true;
    final success = await fetchSensorDataFromThinger();
    if(success){
      await getRecommendation();
    } else {
      isRecommendationLoading.value = false;
      Get.snackbar("Failed", "Failed to show recommendation.");
    }
  }

  Future<void> refhreshGeneretePage() async {
    isRecommendationLoading.value = true;
    final success = await fetchSensorDataFromThinger();
    if (success) {
      await getRecommendation();
    } else {
      print("Failed to refresh data.");
    }
  }

  Future<bool> fetchSensorDataFromThinger() async {
    try {
      final storage = FlutterSecureStorage();
      String? tokenAccess = await storage.read(key: 'access_token');
      String? refreshToken = await storage.read(key: 'refresh_token');

      final prefs = await SharedPreferences.getInstance();

      final jsonString = await prefs.getString('data_sensor');
      if (jsonString == null) {
        print('Data sensor tidak ditemukan.');
        return false;
      }
      Map<String, dynamic>? sensorMap = jsonDecode(jsonString);
      final String? deviceId = sensorMap!['deviceId'];
      final String? sensorId = sensorMap!['sensorId'];
      final String? userName = sensorMap!['userName'];
      print(deviceId);
      print(sensorId);
      print(userName);

      // final url = Uri.parse("https://api.thinger.io/v3/users/${userName}/devices/${deviceId}/properties/${sensorId}");
      // final response = await http.get(
      //     url,
      //     headers: {
      //       'Authorization': 'Bearer ${tokenAccess}',
      //       'Content-Type': 'application/json'
      //     }
      // );

      final url = Uri.parse("https://api.thinger.io/v3/users/${userName}/devices/${deviceId}/resources/${sensorId}");
      final response = await http.get(
          url,
          headers: {
            'Authorization': 'Bearer ${tokenAccess}',
            'Content-Type': 'application/json'
          }
      );

      if(response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        String dataResponse = responseBody['all'];
        List partOfResponse = dataResponse.split('#');

        suhu.value = partOfResponse[1];
        final tempHumidity = double.parse(partOfResponse[0]) / 100;
        humidity.value = tempHumidity.toStringAsFixed(2);
        final tempSoil = double.parse(partOfResponse[2]) / 100;
        soilMoisture.value = tempSoil.toStringAsFixed(2);
        ph.value = partOfResponse[3];

        print("ini humiditi : ${tempHumidity}");
        print(response.statusCode);
        print(responseBody);
        print(responseBody['value']);
        return true;
      } else {
        print("Token refresh 1: ${refreshToken}");
        await refsreshTokenThinger(refreshToken);
        return false;
      }
    } catch(e) {
      print('Error at show generate page: $e');
      return false;
    }
  }

  Future<void> refsreshTokenThinger(refreshToken) async {
    try {
      final url = Uri.parse('https://api.thinger.io/oauth/token');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'grant_type':'refresh_token',
          'refresh_token':refreshToken
        }
      );
      if(response.statusCode != 200){
        print('Failed to renew token.');
        print("Refresh token 2: ${refreshToken}");
        print(response.statusCode);
        print(response.body);
        return;
      } else {
        final storage = FlutterSecureStorage();
        final responseBody = jsonDecode(response.body);
        await storage.write(key: 'access_token', value: responseBody['access_token']);
        await storage.write(key: 'refresh_token', value: responseBody['refresh_token']);
        print('Success to renew token.');
      }
    } catch(e) {
      print('Error at refresh token: $e');
    }
  }

  Future<void> getRecommendation() async {
    try{
      final storage = FlutterSecureStorage();
      final email = await storage.read(key: "email");
      final url = Uri.parse("https://neusisco-ModelRFv2.hf.space/predict");
      final response = await http.post(
        url,
        body: jsonEncode({
          "suhu": "30",
          "kelembaban_udara": "0.61",
          "kelembaban_tanah": soilMoisture.value,
          "ph": ph.value
        }),
      );
      final responseBody = jsonDecode(response.body);
      if(response.statusCode == 200 || response.statusCode == 201) {
        print(responseBody['rekomendasi_tanaman']);

        await getDataTanaman(responseBody['rekomendasi_tanaman'][0]);

        listDataTanaman.value.insert(0, responseBody['rekomendasi_tanaman'][1]);
        listDataTanaman.value.insert(1, responseBody['rekomendasi_tanaman'][2]);

        // await getDataTanaman(responseBody['rekomendasi_tanaman'], 0);
        await addHistoryPredict(email, soilMoisture.value, "0.61", ph.value, "30", responseBody['rekomendasi_tanaman'][0]);
        Get.to(GeneratePage());
      } else {
        print(responseBody);
        if(response.statusCode == 422) {
          message.value = responseBody['detail'];
          Get.snackbar("Failed", "$message");
        } else {
          Get.snackbar("Failed", "Failed to get recommendation: ${response.body}");
        }
        print("Failed to get recommendation: ${response.body}");
      }
    }catch(e){
      print('Error get recommendation at: $e');
    } finally {
      isRecommendationLoading.value = false;
    }
  }

  Future<void> getDataTanaman(String name) async {
    try{
      final url = Uri.parse("https://www.meep-lab.cloud/api/tanamans");
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "name": name
        })
      );
      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);

        if (responseBody is List && responseBody.isNotEmpty) {
          dataTanaman.value = TanamanModel.fromJson(responseBody[0]);
          // listDataTanaman.add(Rxn(TanamanModel.fromJson(responseBody[0])));
          print("Success get one data tanaman");
        } else {
          print("Data tanaman kosong atau format tidak sesuai.");
        }
      }
    } catch(e) {
      print("Error get data tanaman at: $e");
    }
  }

  Future<void> goToChangeProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String? thingerDataJson = await prefs.getString('data_sensor');

    if (thingerDataJson != null) {

      Map<String, dynamic> dataThinger = jsonDecode(thingerDataJson);

      nameThinger.text = dataThinger['name'];
      deviceThinger.text = dataThinger['deviceId'];
      sensorThinger.text = dataThinger['sensorId'];
      usernameThingerIo.text = dataThinger['userName'];

      Get.to(ChangeProfile());
    } else {
      Get.snackbar("Failed to get user profile", "Error: data incomplete or null");
    }
  }



  Future<void> changeProfile() async {
    try {
      isChangeProfileLoading.value = true;
      final storage = await FlutterSecureStorage();
      final email = await storage.read(key: "email");
      final url = Uri.parse("https://meep-lab.cloud/api/users/change_profile");
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
            {
              "name": nameThinger.text,
              "device_id": deviceThinger.text,
              "sensor_id": sensorThinger.text,
              "username_thinger": usernameThingerIo.text,
              "email": email
            }
        )
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        saveDataThingerWithoutUser(email);
        FocusManager.instance.primaryFocus?.unfocus();
        Get.snackbar("Profile updated!", "$responseBody");
        print("Profile updated: $responseBody");
      } else {
        Get.snackbar("Failed to update profile", "${response.statusCode} - ${response.body}");
        print("Failed to update profile: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error updating profile: $e");
    } finally {
      isChangeProfileLoading.value = false;
    }
  }

  Future<void> saveDataThingerWithoutUser(email) async {

    externalUser.value = await getDataThinger(email);

    try {
      final prefs = await SharedPreferences.getInstance();

      if(externalUser.value!.name.isNotEmpty && externalUser.value!.deviceId.isNotEmpty && externalUser.value!.sensorId.isNotEmpty && externalUser.value!.usernameThinger.isNotEmpty){
        Map<String, dynamic> sensor = {
          'name': externalUser.value!.name,
          'deviceId':externalUser.value!.deviceId,
          'sensorId':externalUser.value!.sensorId,
          'userName':externalUser.value!.usernameThinger
        };

        String jsonString = jsonEncode(sensor); // ubah map ke string
        await prefs.setString('data_sensor', jsonString);

        final url = Uri.parse("https://meep-lab.cloud/api/users/getUser?email=$email");
        final response = await http.get(url);

        if (response.statusCode == 200 || response.statusCode == 201) {
          nameThinger.text = externalUser.value?.name ?? '';
          deviceThinger.text = externalUser.value?.deviceId ?? '';
          sensorThinger.text = externalUser.value?.sensorId ?? '';
          usernameThingerIo.text = externalUser.value?.usernameThinger ?? '';
          Get.snackbar("Profile Updated!", "Your information has been updated.");
        } else {
          Get.snackbar("Oops!", 'Something went wrong while update your new data.');
        }
      } else {
        Get.snackbar("Oops!", 'Something went wrong while saving your data.');
        print('Data tidak lengkap, tidak disimpan');
      }

    } catch (e) {
      print('Error on shared preference save data sensor: $e');
      Get.snackbar("Error", "Unexpected error occurred. Please try again.");
    }
  }

  Future<void> addHistoryPredict(email, kelembabanTanah, kelembabanUdara, pH, suhu, predict) async {
    try {
      final url = Uri.parse("https://meep-lab.cloud/api/users/log_activity");
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
            {
              "email": email,
              "date": DateTime.now().toIso8601String(),
              "pH": pH,
              "kelembabanUdara": kelembabanUdara,
              "kelembabanTanah": kelembabanTanah,
              "suhu": suhu,
              "recommendation": predict
            }
        ),
      );
      print(response.body);
      if (response.statusCode == 200){
        print("Success add history");
        Get.snackbar("Success", "Success add history");
      } else {
        return;
      }
    } catch(e) {
      print(e);
    }
  }

  Future<void> fetchHistoryPredict() async {
    try {
      isLoading.value = true;
      final storage = FlutterSecureStorage();
      final email = await storage.read(key: "email");
      final url = Uri.parse("https://meep-lab.cloud/api/users/getLog?email=${email}");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> jsonData = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        historyPredict.value = jsonData.map((e)=>HistoryPredict.fromJson(e)).toList();
        Get.off(History());
      } else {
        Get.snackbar("Error", "Failed to load data history");
      }
    } catch(e) {
      print("e");
    } finally {
      isLoading.value = false;
    }
  }


}