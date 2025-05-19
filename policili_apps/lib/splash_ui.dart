import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:policili_apps/home_page.dart';
import 'dart:async';

class SplashUi extends StatefulWidget {
  const SplashUi({super.key});

  @override
  State<SplashUi> createState() => _SplashUiState();
}

class _SplashUiState extends State<SplashUi> {

  @override
  void initState() {
    // TODO: implement initState
    // Timer(Duration(seconds: 3), () {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => HomePage()),
    //   );
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedMeshGradient(
        colors: [
          Color(0xffFFE4D0),
          Color(0xffF9B0B4),
          Color(0xffFFE4ff),
          Color(0xffE6C7FE),
        ],
        options: AnimatedMeshGradientOptions(
          speed: 0.01,       // Kecepatan animasi
          frequency: 7,   // Frekuensi gelombang (semakin tinggi = lebih banyak riak)
          amplitude: 20,   // Amplitudo (semakin tinggi = lebih berombak)
          grain: 0.1,     // Efek noise/grain (semakin tinggi = lebih kasar)
        ),
        child: Center(
          child: Image.asset(
            "assets/img/Logo.png",
            width: 25.w,
          ),
        ),
      ),
    );
  }
}

