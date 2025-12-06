import 'package:axonia/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/app_image.dart';
import '../controllers/on_boarding_controller.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  const OnBoardingView({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xffA180F5),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(9),
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: size.height * 0.63,

                    child: Image.asset(AppImage.splashImage, fit: BoxFit.fill),
                  ),
                ],
              ),
              Positioned(
                bottom: 20,
                right: 0,
                left: 0,
                child: Container(
                  height: size.height * 0.4,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xffD4D1F3),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 10,
                        ),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Jihad's AI",
                                style: GoogleFonts.fredoka(
                                  color: Color(0xff423F83),
                                  fontSize: 55,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(width: 20),

                              Text(
                                "Hi there! 👋\nAsk me anything.\nQuestions, ideas,\nor help. Let’s dive in!",
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 70),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            backgroundColor: Color(0xffA180F5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: BorderSide(
                                color: Color(0xff7135F2),
                                width: 2,
                              ),
                            ),
                          ),
                          onPressed: () {
                            Get.toNamed(Routes.HOME);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Get Started",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.arrow_forward,
                                size: 30,
                                color: Colors.black87,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
