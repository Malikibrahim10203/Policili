import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:policili_apps/controller/api_external_controller.dart';
import 'package:policili_apps/controller/auth_controller.dart';
import 'package:policili_apps/generate_page.dart';
import 'package:policili_apps/history.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final auth = Get.find<AuthController>();
  final apiExternalController = Get.find<ApiExternalController>();

  void loadAndNavigate() async {
    await apiExternalController.showGeneratePage();
    Get.to(GeneratePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedMeshGradient(
        colors: [
          Color(0xffFFE4D0),
          // Color(0xffFDE6E7),
          Color(0xffFFFFFF),
          Color(0xffFFE4ff),
          Color(0xffFCD8DA),
        ],
        options: AnimatedMeshGradientOptions(
          speed: 0.05,
          frequency: 7,
          amplitude: 30,
          grain: 0.1,
        ),
        child: Stack(
          children: [
            Container(
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
                    height: 40.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffFF2020),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.w)
                        ),
                      ),
                      onPressed: (){
                        apiExternalController.showGeneratePage();
                        if(false){

                        }
                      },
                      child: Text("Generate now", style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),),
                    ),
                  ),
                  SizedBox(
                    height: 0.12.sw,
                  ),
                  Container(
                    width: 0.22.sw,
                    height: 0.08.sw,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0.08.sw),
                      gradient: LinearGradient(
                        colors: [Colors.orange, Colors.deepOrange.shade700],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "V1.0",
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(() => apiExternalController.isRecommendationLoading.value || apiExternalController.isLoading.value?
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: LoadingAnimationWidget.fourRotatingDots(color: Colors.red, size: 50.w),
              ),
            ):
            SizedBox.shrink()
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: SpeedDial(
        icon: Icons.menu,
        foregroundColor: Colors.white,
        buttonSize: Size(0.12.sw, 0.12.sw),
        backgroundColor: Color(0xffFF2020),
        direction: SpeedDialDirection.down,
        switchLabelPosition: true,
        children: [
          SpeedDialChild(
            label: "Change Profile",
            labelBackgroundColor: Colors.white10,
            child: Icon(Icons.settings_suggest_outlined),
            shape: CircleBorder(),
            onTap: () {
              apiExternalController.isLoading.value = true;
              Future.delayed(Duration(seconds: 1), () {
                apiExternalController.isLoading.value = false;
                apiExternalController.goToChangeProfile();
              },);
            }
          ),
          SpeedDialChild(
              label: "History Predict",
              labelBackgroundColor: Colors.white10,
              child: Icon(Icons.history),
              shape: CircleBorder(),
              onTap: () {
                apiExternalController.fetchHistoryPredict();
              }
          ),
          SpeedDialChild(
              label: "Sign Out",
              labelBackgroundColor: Colors.white10,
              child: Icon(Icons.logout),
              shape: CircleBorder(),
              onTap: () {
                apiExternalController.isLoading.value = true;
                Future.delayed(Duration(seconds: 1), () {
                  apiExternalController.isLoading.value = false;
                  auth.signOut();
                },);
              }
          ),
        ],
      ),
    );
  }
}
