import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:policili_apps/home_page.dart';
import 'package:policili_apps/widget/card_device.dart';

class GeneratePage extends StatelessWidget {
  GeneratePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20.w), bottomLeft: Radius.circular(20.w)),
                              image: DecorationImage(
                                image: AssetImage("assets/img/bg_card.png"),
                                fit: BoxFit.cover
                              ),
                            ),
                            height: 0.75.sw,
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 0.65.sw,
                              ),
                              Center(
                                child: Container(
                                  width: 0.9.sw,
                                  height: 0.25.sw,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.w)
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      CardDevice(logo: "Mm", labelName: "Air Humidity", labelValue: "80", status: "Success",),
                      SizedBox(
                        height: 11.h,
                      ),
                      CardDevice(logo: "Mm", labelName: "Air Humidity", labelValue: "80", status: "Success",),
                      SizedBox(
                        height: 11.h,
                      ),
                      CardDevice(logo: "Mm", labelName: "Air Humidity", labelValue: "80", status: "Success",),
                      SizedBox(
                        height: 11.h,
                      ),
                      CardDevice(logo: "Mm", labelName: "Air Humidity", labelValue: "80", status: "Success",),
                      SizedBox(
                        height: 11.h,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        backgroundColor: Colors.blueGrey,
        items: [
          Icon(Icons.home, size: 25.w),
          Icon(Icons.refresh, size: 25.w),
          Icon(Icons.person, size: 25.w),
        ],
        onTap: (index) {
          if (index == 0) {
            Get.off(HomePage());
          }
        },
      ),
    );
  }
}
