import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final pageIndex = 0.obs;
  final int pageCount = 3;

  void nextPage() => pageIndex.value++;
}
