import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:policili_apps/controller/auth_controller.dart';
import 'package:policili_apps/generate_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedMeshGradient(
        colors: [
          Color(0xffFFE4D0),
          Color(0xffFDE6E7),
          Color(0xffFFE4ff),
          Color(0xffFCD8DA),
        ],
        options: AnimatedMeshGradientOptions(
          speed: 0.05,
          frequency: 7,
          amplitude: 30,
          grain: 0.1,
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50.w,
              ),
              Text(
                "Meet Your New",
                style: GoogleFonts.inter(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w600
                ),
              ),
              Text(
                "AI Companion",
                style: GoogleFonts.inter(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w600,
                  foreground: Paint()
                    ..shader = LinearGradient(
                      colors: <Color>[Colors.orangeAccent, Color(0xffFF2020)],
                    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                ),
              ),
              SizedBox(
                height: 30.w,
              ),
              Image.asset("assets/img/mascot.png"),
              SizedBox(
                height: 25.w,
              ),
              Text(
                "Talk to Doctor Polichili",
                style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 5.w,
              ),
              Container(
                width: 310.w,
                child: Text(
                  "Need advice on suitable plants? Just click “Generate”,\nlet us help you choose the best one!",
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 50.w,
              ),
              Container(
                width: 300.w,
                height: 35.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffFF2020),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.w)
                    ),
                  ),
                  onPressed: (){
                    Get.to(GeneratePage());
                  },
                  child: Text("Generate now", style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),),
                ),
              ),
              SizedBox(
                height: 20.w,
              ),
              ElevatedButton(onPressed: ()=> auth.signOut(), child: Text('Logout')),
            ],
          ),
        ),
      ),
    );
  }
}
