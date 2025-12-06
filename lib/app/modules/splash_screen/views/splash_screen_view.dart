import 'package:axonia/app/routes/app_pages.dart';
import 'package:axonia/core/app_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});
  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(seconds: 3), () {
      Get.offNamed(Routes.ON_BOARDING);
    });

    return Scaffold(
      backgroundColor: Color(0xffA180F5),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(9),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppImage.aiAgent,width: 180,height:180,fit: BoxFit.fill,),
                    SizedBox(height: 10,),
                    Text(
                      "Jihad's AI",
                      style: GoogleFonts.fredoka(
                        color: Colors.white,
                        fontSize: 55,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
