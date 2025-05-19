import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:policili_apps/controller/rememberme_controller.dart';
import 'package:policili_apps/sign_up.dart';
import 'package:policili_apps/widget/input_field.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

  final TextEditingController emailController = TextEditingController();
  final remembermeController = Get.put(RemembermeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD52424),
      body: Column(
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
                      SizedBox(height: 32.h),
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
                      InputField(label: "Email", controller: emailController),
                      SizedBox(height: 10.h),
                      InputField(
                        label: "Password",
                        controller: emailController,
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUp()),
                            );
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
    );
  }
}
