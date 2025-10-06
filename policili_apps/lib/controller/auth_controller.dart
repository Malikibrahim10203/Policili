import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:policili_apps/home_page.dart';
import 'package:policili_apps/models/external_user.dart';
import 'package:policili_apps/models/userapi_model.dart';
import 'package:policili_apps/sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'api_external_controller.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final sensoridController = TextEditingController();
  final deviceidController = TextEditingController();
  final usernameController = TextEditingController();

  final controllers = [].obs;

  void changeController() {
    controllers.value = [
      emailController,
      usernameController,
      emailController,
      deviceidController,
      sensoridController,
      passwordController,
      nameController
    ];
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<User?> firebaseUser = Rx<User?>(null);
  RxString signUpMessage = ''.obs;
  RxBool isLoading = false.obs;
  final apiExternalController = Get.put(ApiExternalController());

  RxBool access = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    firebaseUser.bindStream(_auth.authStateChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  bool get isSigned => firebaseUser.value != null;

  void _setInitialScreen(User? user) {
    if(user != null && access.value == true) {
      Get.offAll(HomePage());
    } else {
      Get.offAll(SignIn());
    }
  }

  void signIn() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final prefs = await SharedPreferences.getInstance();
    final storage = FlutterSecureStorage();

    await storage.write(key: "email", value: email);
    await storage.write(key: "password", value: password);

    isLoading.value = true;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar("Success", "login success");

      try {
        final user = FirebaseAuth.instance.currentUser;
        await apiExternalController.saveDataThinger(user, email);
        String? jsonString = prefs.getString('data_sensor');
        await apiExternalController.getTokenThinger();
        final savedAccessToken = await storage.read(key: 'access_token');
        final savedRefreshToken = await storage.read(key: 'refresh_token');
        access.value = true;
        print("Access token: $savedAccessToken");
        print("Refresh token: $savedRefreshToken");
        print("External Message: $jsonString");
      } catch(e) {
        print("Get data in Error: $e");
      }
      Get.offAll(HomePage());
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message??'login gagal');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendUserRestApi(UserapiModel user) async {
    final url = Uri.parse("https://www.meep-lab.cloud/api/users");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(user.toJson())
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        Get.snackbar("Success", "User added successfully");
      } else {
        Get.snackbar("Error", "Failed to add user");
        // print("BODY SENT: ${jsonEncode(user.toJson())}");
        // print("STATUS CODE: ${response.statusCode}");
        // print("RESPONSE BODY: ${response.body}");
      }
    } catch(e) {
      Get.snackbar("Exception", e.toString());
    }
  }

  Future<void> signUp(String email, String password, String name, String device_id, String sensor_id, String username_thinger) async {
    final user = UserapiModel(name: name, email: email, deviceId: device_id, sensorId: sensor_id, usernameThinger: username_thinger);
    access.value = false;
    isLoading.value = true;
    try {
      final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      signUpMessage.value = 'UID: ${credential.user?.uid}';
      await sendUserRestApi(user);

    } on FirebaseAuthException catch(e) {
      if(e.code == 'weak-password') {
        signUpMessage.value = 'Password lemah';
      } else if(e.code == 'email-already-in-use') {
        signUpMessage.value = 'Email sudah digunakan';
      } else {
        signUpMessage.value = 'Terjadi kesalahan:${e.message}';
      }
    } catch(e) {
      signUpMessage.value = 'Kesalahan tidak terduga:$e';
    } finally {
      Get.snackbar('Alert', signUpMessage.value);
      print(signUpMessage.value);
      emailController.clear();
      passwordController.clear();
      nameController.clear();
      deviceidController.clear();
      sensoridController.clear();
      usernameController.clear();
      isLoading.value = false;
    }
  }


  Future<void> signOut() async {

    final storage = FlutterSecureStorage();

    await storage.delete(key: "email");
    await storage.delete(key: "password");

    access.value = false;

    await _auth.signOut();
  }
}