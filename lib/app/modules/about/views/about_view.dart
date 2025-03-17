import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              title: Text("Developed by"),
              subtitle: Text("Imam Agus Faisal"),
            ),
            ListTile(
              title: Text("Database used"),
              subtitle: Text("Cloud Firestore"),
            ),
            ListTile(
              title: Text("Auth Service by"),
              subtitle: Text("Firebase Authentication"),
            ),
            ListTile(
              title: Text("App Version"),
              subtitle: Text("1.0.0"),
            ),
          ],
        ),
      ),
    );
  }
}
