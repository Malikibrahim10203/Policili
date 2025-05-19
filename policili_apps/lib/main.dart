import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:policili_apps/home_page.dart';
import 'package:policili_apps/sign_in.dart';
import 'package:policili_apps/splash_ui.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() => runApp(const MyApp());

/// Root widget aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          nextScreen: SignIn(),
        ),
      ),
    );
  }
}