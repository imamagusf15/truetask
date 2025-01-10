import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.pageCount,
                controller: PageController(initialPage: 0),
                onPageChanged: (value) => controller.pageIndex.value = value,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth <= 480) {
                            return Image.asset('assets/image/onboarding.png');
                          } else {
                            return SizedBox(
                              width: Get.width,
                              height: 100,
                              child: Image.asset(
                                'assets/image/onboarding.png',
                                fit: BoxFit.fitWidth,
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Be A Creative Person',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 80, vertical: 8),
                        child: Text(
                          "Millions of peoples can’t Wait to see what you have to share",
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(onPressed: () {}, child: const Text('Skip')),
                SizedBox(
                  height: 50,
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 4),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.pageCount,
                    itemBuilder: (context, index) {
                      return Obx(
                        () => Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: controller.pageIndex.value == index
                                  ? Colors.blue
                                  : Colors.grey.shade300),
                        ),
                      );
                    },
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    onPressed: () => controller.nextPage(),
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
