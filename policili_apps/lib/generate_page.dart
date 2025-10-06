import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:policili_apps/change_profile.dart';
import 'package:policili_apps/controller/api_external_controller.dart';
import 'package:policili_apps/home_page.dart';
import 'package:policili_apps/widget/card_device.dart';

class GeneratePage extends StatelessWidget {
  GeneratePage({super.key});

  final ApiExternalController apiExternalController = Get.find<ApiExternalController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Stack(
            children: [
              Positioned.fill(
                child: AnimatedMeshGradient(
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
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1)
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  height: 1.sh,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(15.w), bottomLeft: Radius.circular(15.w)),
                              image: DecorationImage(
                                image: AssetImage("assets/img/bg_card.png"),
                                fit: BoxFit.cover
                              ),
                            ),
                            height: 0.95.sw,
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 0.1.sw,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(20),
                                    child: GestureDetector(
                                      onTap: () {
                                        apiExternalController.isLoading.value = true;
                                        Future.delayed(Duration(seconds: 1), () {
                                          apiExternalController.historyPredict.value.clear();
                                          apiExternalController.listDataTanaman.value.clear();
                                          apiExternalController.isLoading.value = false;
                                          Get.off(HomePage());
                                        },);
                                      },
                                      child: Container(
                                        width: 0.13.sw,
                                        height: 0.13.sw,
                                        decoration: BoxDecoration(
                                            color: Color(0xffD9D9D9),
                                            borderRadius: BorderRadius.circular(10.w)
                                        ),
                                        child: Icon(Icons.arrow_back),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 0.2.sw,
                                ),
                                Stack(
                                  children: [
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 0.17.sh,
                                        ),
                                        Container(
                                          width: 200.w,
                                          height: 20.h,
                                          decoration: BoxDecoration(
                                            // color: Colors.black.withOpacity(0.6),
                                            borderRadius: BorderRadius.circular(10.w),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black.withOpacity(0.8),
                                                  blurRadius: 50
                                              )
                                            ]
                                          ),
                                        ),
                                      ],
                                    ),
                                    Obx(() => Image.network(
                                      "https://www.meep-lab.cloud/images/${apiExternalController.dataTanaman.value?.url}",
                                      // "https://www.meep-lab.cloud/images/${apiExternalController.listDataTanaman[0].value?.url}",
                                      width: 200.w,
                                    ),),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 0.75.sw,
                              ),
                              Obx(() => Text(
                                "${apiExternalController.dataTanaman.value?.name}",
                                // "${apiExternalController.listDataTanaman[0].value?.name}",
                                style: GoogleFonts.roboto(
                                  fontSize: 18.sp,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),),
                              SizedBox(
                                height: 0.05.sw,
                              ),
                              Center(
                                child: Container(
                                  width: 0.9.sw,
                                  constraints: BoxConstraints(
                                    minHeight: 0.2.sw,
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.w)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10.w, bottom: 10.w, left: 25.w, right: 25.w),
                                    child: Row(
                                      children: [
                                        Image.asset("assets/img/search.png", width: 35.w,),
                                        SizedBox(width: 15.w,),
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Manfaat",
                                                style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13.5.sp
                                                ),
                                              ),
                                              Obx(() => Text(
                                                "${apiExternalController.dataTanaman.value?.kelebihan}",
                                                // "${apiExternalController.listDataTanaman[0].value?.kelebihan}",
                                                style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13.sp
                                                ),
                                              ),)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 11.h,
                      ),
                      Container(
                        width: 0.9.sw,
                        height: 0.9.sw,
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 10.w, bottom: 10.w, left: 25.w, right: 25.w),
                              width: 0.9.sw,
                              constraints: BoxConstraints(
                                minHeight: 0.21.sw,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.w)
                              ),
                              child: Row(
                                children: [
                                  Image.asset("assets/img/list.png", width: 35.w,),
                                  SizedBox(width: 15.w,),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Alternatif",
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13.5.sp
                                          ),
                                        ),
                                        Text(
                                          "${apiExternalController.listDataTanaman.value[0]}",
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13.sp
                                          ),
                                        ),
                                        Text(
                                          "${apiExternalController.listDataTanaman.value[1]}",
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13.sp
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 11.h,
                            ),
                            CardDevice(logo: "Mm", labelName: "Temprature", labelValue: "30", status: "Success",),
                            SizedBox(
                              height: 11.h,
                            ),
                            CardDevice(logo: "Mm", labelName: "Air Humidity", labelValue: "0.61", status: "Success",),
                            SizedBox(
                              height: 11.h,
                            ),
                            Obx(() => CardDevice(logo: "Mm", labelName: "Soil Humidity", labelValue: "${apiExternalController.soilMoisture}", status: "Success",),),
                            SizedBox(
                              height: 11.h,
                            ),
                            Obx(() => CardDevice(logo: "Mm", labelName: "PH", labelValue: "${apiExternalController.ph}", status: "Success",),),
                            SizedBox(
                              height: 11.h,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Obx(() => apiExternalController.isRecommendationLoading.value || apiExternalController.isLoading.value?
          Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: LoadingAnimationWidget.fourRotatingDots(color: Colors.red, size: 50.w),
            ),
          ): SizedBox.shrink(),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Color(0xffFD9A37),
        height: 60.w,
        items: [
          Icon(Icons.home, size: 25.w, color: Color(0xff6A0606),),
          Icon(Icons.refresh, size: 25.w, color: Colors.white,),
          Icon(Icons.settings_suggest_outlined, color: Colors.grey, size: 25.w),
        ],
        onTap: (index) {
          if (index == 0) {
            index = 1;
            apiExternalController.isLoading.value = true;
            Future.delayed(Duration(seconds: 1), () {
              apiExternalController.isLoading.value = false;
              Get.off(HomePage());
            },);
          } else if (index == 1) {
            index == 1;
            apiExternalController.refhreshGeneretePage();
          } else if (index == 2) {
            index == 1;
            apiExternalController.goToChangeProfile();
          }
        },
      ),
    );
  }
}
