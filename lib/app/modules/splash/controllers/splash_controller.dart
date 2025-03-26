import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truetask/app/routes/app_pages.dart';

class SplashController extends GetxController {
  void checkAuthState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      // Reads a value from local storage key named displayedOnboarding
      final bool? displayedOnboarding = prefs.getBool('displayedOnboarding');
      if (user == null) {
        if (displayedOnboarding == true) {
          // If OnboardingPage has displayed once navigate to Login
          Get.offAllNamed(Routes.LOGIN);
        } else {
          // If OnboardingPage has not displayed once navigate to it
          Get.offAllNamed(Routes.ONBOARDING);
        }
      } else {
        Get.offAllNamed(Routes.HOME);
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    // Show screen for 2 sec then call function checkAuthState
    Future.delayed(Duration(seconds: 2), () => checkAuthState());
  }
}
