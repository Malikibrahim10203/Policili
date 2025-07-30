import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:policili_apps/controller/api_external_controller.dart';
import 'package:policili_apps/home_page.dart';
import 'package:policili_apps/widget/card_history.dart';

class History extends StatelessWidget {
  History({super.key});

  final ApiExternalController apiExternalController = Get.find<ApiExternalController>();

  @override
  Widget build(BuildContext context) {
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
                      height: 0.15.sw,
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
                      height: 0.03.sw,
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
                        width: 1.sw,
                        decoration: BoxDecoration(
                          color: Color(0xffE2E1E1),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.r),
                            topRight: Radius.circular(10.r),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 0.05.sw, right: 0.05.sw),
                          child: ListView.builder(
                            itemCount: apiExternalController.historyPredict.length,
                            itemBuilder: (context, index) {
                              final item = apiExternalController.historyPredict[index];
                              return Column(
                                children: [
                                  CardHistory(imageUrl: "https://meep-lab.cloud/images/${item?.recommendation}.png", plantName: item!.recommendation, date: item.date.toString(), soilMoisture: item!.kelembabanTanah, airMoisture: item.kelembabanUdara, ph: item!.pH, temperature: item!.suhu),
                                  SizedBox(
                                    height: 0.03.sw,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


