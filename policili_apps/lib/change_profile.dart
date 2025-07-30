import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:policili_apps/controller/api_external_controller.dart';
import 'package:policili_apps/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:policili_apps/home_page.dart';
import 'package:policili_apps/widget/input_field.dart';
import 'package:policili_apps/widget/input_field_short.dart';

class ChangeProfile extends StatelessWidget {
  ChangeProfile({super.key});

  final apiExternalController = Get.find<ApiExternalController>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffFF2020),
      body: Stack(
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
          Stack(
            children: [
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 0.1.sw,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: GestureDetector(
                            onTap: (){
                              apiExternalController.isLoading.value = true;
                              Future.delayed(Duration(seconds: 1), () {
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
                    SizedBox(
                      height: 0.2.sw,
                    ),
                    Container(
                      width: 280.w,
                      height: 20.w,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.r),
                          topRight: Radius.circular(40.r),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.r),
                            topRight: Radius.circular(40.r),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(width*0.05),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20.h,
                                ),
                                Center(
                                  child: Container(
                                    width: 30.w,
                                    height: 30.w,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5.w),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            blurRadius: 10.w,
                                          )
                                        ]
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(3.w),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.red.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(5.w)
                                        ),
                                        child: Image.asset("assets/img/Logo.png"),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Change Profile",
                                        style: TextStyle(
                                            fontSize: width*0.05,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      SizedBox(
                                        height: width * 0.01,
                                      ),
                                      Text(
                                        "Make changes to your profile here.",
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 40.h,
                                ),
                                InputField(label: "Name", controller: apiExternalController.nameThinger),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InputFieldShort(label: "Device Name", controller: apiExternalController.deviceThinger),
                                    InputFieldShort(label: "Sensor Name", controller: apiExternalController.sensorThinger),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                InputField(label: "Username Thinger", controller: apiExternalController.usernameThingerIo),
                                SizedBox(
                                  height: 30.h,
                                ),
                                apiExternalController.isChangeProfileLoading.value?
                                Center(child: CircularProgressIndicator(),):
                                Container(
                                  width: width*1,
                                  child: ElevatedButton(
                                    onPressed: (){
                                      apiExternalController.changeProfile();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(width*0.01),
                                      ),
                                      backgroundColor: Color(0xffFF2020),
                                    ),
                                    child: Text("Change Profile", style: TextStyle(color: Colors.white.withOpacity(0.8)),),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Obx(()=>apiExternalController.isChangeProfileLoading.value?
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: LoadingAnimationWidget.fourRotatingDots(color: Colors.red, size: 50.w),
                ),
              ):
              SizedBox.shrink()
              )
            ],
          ),
          Obx(() => apiExternalController.isLoading.value?
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
    );
  }
}
