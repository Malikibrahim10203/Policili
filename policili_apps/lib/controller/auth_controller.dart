import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:policili_apps/home_page.dart';
import 'package:policili_apps/models/userapi_model.dart';
import 'package:policili_apps/sign_in.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final sensoridController = TextEditingController();
  final deviceidController = TextEditingController();
  final usernameController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<User?> firebaseUser = Rx<User?>(null);
  RxString signUpMessage = ''.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    firebaseUser.bindStream(_auth.authStateChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  bool get isSigned => firebaseUser.value != null;

  void _setInitialScreen(User? user) {
    if(user == null) {
      Get.offAll(SignIn());
    } else {
      Get.offAll(HomePage());
    }
  }

  void signIn() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    isLoading.value = true;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar("Success", "login berhasil");
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
    final user = UserapiModel(name: name, deviceId: device_id, sensorId: sensor_id, usernameThinger: username_thinger);
    isLoading.value = true;
    try {
      final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      Get.snackbar('Success', 'UID: ${credential.user?.uid}');
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
    await _auth.signOut();
  }
}