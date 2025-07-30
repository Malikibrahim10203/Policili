import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:policili_apps/controller/auth_controller.dart';
import 'package:policili_apps/controller/rememberme_controller.dart';
import 'package:policili_apps/sign_up.dart';
import 'package:policili_apps/widget/input_field.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

  final TextEditingController emailController = TextEditingController();
  final remembermeController = Get.put(RemembermeController());

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD52424),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 0.6.sw),
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
                  width: 1.sw,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.r),
                      topRight: Radius.circular(40.r),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.h),
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
                                  "Log in to your account",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text("Welcome back! Please enter your details."),
                              ],
                            ),
                          ),
                          SizedBox(height: 40.h),
                          InputField(label: "Email", controller: authController.emailController),
                          SizedBox(height: 10.h),
                          InputField(
                            label: "Password",
                            controller: authController.passwordController,
                            isPassword: true,
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Obx((){
                                    return Checkbox(
                                      value: remembermeController.isChecked.value,
                                      checkColor: Colors.white,
                                      fillColor:
                                      MaterialStateProperty.resolveWith<Color>((states) {
                                        if (states.contains(MaterialState.selected)) {
                                          return Colors.blue;
                                        }
                                        return Colors.grey;
                                      }),
                                      side: MaterialStateBorderSide.resolveWith((states) {
                                        return BorderSide(
                                            color: states.contains(MaterialState.selected)
                                                ? Colors.blue
                                                : Colors.grey,
                                            width: 1);
                                      }),
                                      onChanged: (bool? newValue) {
                                        remembermeController.changeValue(newValue);
                                      },
                                    );
                                  }),
                                  Text("Remember me"),
                                ],
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(4.r),
                                splashColor: Colors.blue.withOpacity(0.3),
                                onTap: () {},
                                child: Text(
                                  "Forgot Password",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          SizedBox(
                            width: 1.sw,
                            child: ElevatedButton(
                              onPressed: () {
                                if (authController.controllers.every((c)=> c.text.trim().isNotEmpty)) {
                                  authController.signIn();
                                } else {

                                }
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                backgroundColor: Color(0xffFF2020),
                              ),
                              child: Text(
                                "Sign in",
                                style: TextStyle(color: Colors.white.withOpacity(0.8)),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          SizedBox(
                            width: 1.sw,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.r),
                                  side: BorderSide(color: Colors.black12),
                                ),
                                backgroundColor: Color(0xffFFFFFF),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/img/google.png",
                                    width: 16.w,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    "Sign in with Google",
                                    style:
                                    TextStyle(color: Colors.black.withOpacity(0.8)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Material(
                                child: InkWell(
                                  onTap: (){
                                    authController.emailController.clear();
                                    authController.passwordController.clear();
                                    Get.off(SignUp());
                                  },
                                  child: Text("Sign up", style: TextStyle(color: Colors.blue),),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Obx(() => authController.isLoading.value?
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
