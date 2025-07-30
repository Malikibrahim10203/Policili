import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:policili_apps/controller/auth_controller.dart';
import 'package:policili_apps/sign_in.dart';
import 'package:policili_apps/widget/input_field.dart';
import 'package:policili_apps/widget/input_field_short.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final TextEditingController controller = TextEditingController();

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffFF2020),
      body: Stack(
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: 0.25.sw,
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
                                    "Sign Up to create your account",
                                    style: TextStyle(
                                        fontSize: width*0.05,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  SizedBox(
                                    height: width * 0.01,
                                  ),
                                  Text(
                                    "Welcome! Please enter your details.",
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                            InputField(label: "Email", controller: authController.emailController),
                            SizedBox(
                              height: 10.h,
                            ),
                            InputField(label: "Password", controller: authController.passwordController, isPassword: true,),
                            SizedBox(
                              height: 10.h,
                            ),
                            InputField(label: "Name", controller: authController.nameController),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InputFieldShort(label: "Device Name", controller: authController.deviceidController),
                                InputFieldShort(label: "Sensor Name", controller: authController.sensoridController),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            InputField(label: "Username Thinger", controller: authController.usernameController),
                            SizedBox(
                              height: 30.h,
                            ),
                            authController.isLoading.value?
                            Center(child: CircularProgressIndicator(),):
                            Container(
                              width: width*1,
                              child: ElevatedButton(
                                onPressed: (){
                                  final controllers = [
                                    authController.emailController,
                                    authController.usernameController,
                                    authController.emailController,
                                    authController.deviceidController,
                                    authController.sensoridController,
                                    authController.passwordController,
                                    authController.nameController
                                  ];
                                  if (controllers.every((c)=> c.text.trim().isNotEmpty)) {
                                    authController.signUp(authController.emailController.text, authController.passwordController.text, authController.nameController.text, authController.deviceidController.text, authController.sensoridController.text, authController.usernameController.text);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(width*0.01),
                                  ),
                                  backgroundColor: Color(0xffFF2020),
                                ),
                                child: Text("Sign up", style: TextStyle(color: Colors.white.withOpacity(0.8)),),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Have an account?",
                                ),
                                SizedBox(
                                  width: width*0.01,
                                ),
                                Material(
                                  child: InkWell(
                                    onTap: () {
                                      Get.off(SignIn());
                                    },
                                    child: Text("Sign in", style: TextStyle(color: Colors.blue),),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: width*0.05,
                            ),
                            if(authController.signUpMessage.isNotEmpty)
                              Text(authController.signUpMessage.value),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Obx(()=>authController.isLoading.value?
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
    );
  }
}
