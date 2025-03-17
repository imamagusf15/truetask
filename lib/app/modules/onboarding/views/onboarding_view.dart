import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          pages: List.generate(3, (index) {
            return PageViewModel(
              decoration: PageDecoration(imageFlex: 3),
              title: "Be A Creative Person",
              body:
                  "Millions of peoples can’t Wait to see what you have to share",
              image: Image.asset(
                'assets/image/onboarding.png',
                fit: BoxFit.fill,
                width: Get.width,
                height: Get.height,
              ),
            );
          }),
          showBackButton: true,
          back: Icon(Icons.arrow_back_ios_new),
          next: Icon(Icons.arrow_forward_ios),
          done: Text("Done"),
          onDone: () => controller.setPrefs(),
        ),
      ),
    );
  }
}
