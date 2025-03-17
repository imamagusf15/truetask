import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truetask/app/routes/app_pages.dart';

class SplashController extends GetxController {
  void checkAuthState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Reads a value from local storage key named displayedOnboarding
    final bool? displayedOnboarding = prefs.getBool('displayedOnboarding');

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        // print('User is currently signed out!');
        if (displayedOnboarding == true) {
          // If OnboardingPage has displayed once navigate to Login
          Get.offNamed(Routes.LOGIN);
        } else {
          // If OnboardingPage has not displayed once navigate to it
          Get.offNamed(Routes.ONBOARDING);
        }
      } else {
        // print('User is signed in!');
        Get.offNamed(Routes.HOME);
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
