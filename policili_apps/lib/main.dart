import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:policili_apps/controller/api_external_controller.dart';
import 'package:policili_apps/controller/auth_controller.dart';
import 'package:policili_apps/home_page.dart';
import 'package:policili_apps/sign_in.dart';
import 'package:policili_apps/splash_ui.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDateFormatting('id_ID', null);
  Get.put(AuthController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
          splash: Image.asset("assets/img/Logo.png"),
          splashIconSize: MediaQuery.of(context).size.width * 0.4,
          duration: 3000,
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.white,
          nextScreen: Obx(() {
            if (authController.isSigned){
              return HomePage();
            } else {
              return SignIn();
            }
          }),
        ),
      ),
    );
  }
}