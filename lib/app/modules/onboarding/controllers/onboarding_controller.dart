import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truetask/app/routes/app_pages.dart';

class OnboardingController extends GetxController {
  Future<void> setPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Set data locally once time as key 'displayedOnboarding' with boolean as value
    await prefs.setBool('displayedOnboarding', true);
    Get.offNamed(Routes.LOGIN);
  }
}
