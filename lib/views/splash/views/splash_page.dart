import 'package:chat_app/uitlls/get_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/auth_services.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(
        seconds: 3,
      ),
      () {
        if (AuthServices.authServices.currentUser != null) {
          Get.toNamed(GetPages.home);
        } else {
          Get.toNamed(GetPages.login);
        }
      },
      // () => Get.toNamed(GetPages.login),
    );
    return Scaffold(
      body: Center(
        child: Container(
          height: 200,
          width: 200,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/gif/splash.gif',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
