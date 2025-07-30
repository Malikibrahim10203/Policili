import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CardHistory extends StatelessWidget {
  final String imageUrl;
  final String plantName;
  final String date;
  final String soilMoisture;
  final String airMoisture;
  final String ph;
  final String temperature;

  const CardHistory({
    Key? key,
    required this.imageUrl,
    required this.plantName,
    required this.date,
    required this.soilMoisture,
    required this.airMoisture,
    required this.ph,
    required this.temperature,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 1.sw,
          height: 0.3.sw,
          padding: EdgeInsets.only(
            top: 0.008.sw,
            left: 0.03.sw,
            right: 0.03.sw,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffD4D4D4),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/img/Logo.png",
                width: 0.07.sw,
              ),
              Text(
                DateFormat('dd MMMM yyyy H:m:s', 'id_ID').format(DateTime.parse(date)),
                style: GoogleFonts.roboto(fontSize: 12.sp),
              ),
            ],
          ),
        ),

        Column(
          children: [
            SizedBox(height: 0.07.sw),
            Container(
              width: 1.sw,
              height: 0.25.sw,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.r),
                  bottomRight: Radius.circular(10.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.network(
                    imageUrl,
                    width: 0.2.sw,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 0.5.sw,
                        child: Text(
                          plantName,
                          style: GoogleFonts.roboto(fontSize: 14.sp),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 0.03.sw),
                      Row(
                        children: [
                          Container(
                            width: 0.3.sw,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Kel. tanah - $soilMoisture",
                                  style: GoogleFonts.roboto(fontSize: 12.sp),
                                ),
                                Text(
                                  "Kel. udara - $airMoisture",
                                  style: GoogleFonts.roboto(fontSize: 12.sp),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 0.2.sw,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "pH - $ph",
                                  style: GoogleFonts.roboto(fontSize: 12.sp),
                                ),
                                Text(
                                  "Suhu - $temperature",
                                  style: GoogleFonts.roboto(fontSize: 12.sp),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
