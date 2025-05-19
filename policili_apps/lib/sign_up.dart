import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:policili_apps/sign_in.dart';
import 'package:policili_apps/widget/input_field.dart';
import 'package:policili_apps/widget/input_field_short.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffFF2020),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 0.4.sw,
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
                          height: 32.h,
                        ),
                        Center(
                          child: Column(
                            children: [
                              Text(
                                "Log in to your account",
                                style: TextStyle(
                                    fontSize: width*0.05,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                              SizedBox(
                                height: width * 0.01,
                              ),
                              Text(
                                "Welcome back! Please enter your details.",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        InputField(label: "Email", controller: controller),
                        SizedBox(
                          height: 10.h,
                        ),
                        InputField(label: "Password", controller: controller),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InputFieldShort(label: "Device Name", controller: controller),
                            InputFieldShort(label: "Sensor Name", controller: controller),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        InputField(label: "Username Thinger", controller: controller),
                        SizedBox(
                          height: 30.h,
                        ),
                        Container(
                          width: width*1,
                          child: ElevatedButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
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
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
