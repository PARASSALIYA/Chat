import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

import '../../../uitlls/get_pages.dart';
import '../../wallpaper/controller/wallpaper_controller.dart';
import '../controller/singup_controller.dart';

class SingUpPage extends StatelessWidget {
  const SingUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController uNameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController contactNumberController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    GlobalKey<FormState> singUpKey = GlobalKey<FormState>();
    SignUpController controller = Get.put(SignUpController());
    var wallpaperController = Get.put(WallpaperController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xff038D3C).withOpacity(0.3),
              const Color(0xff038D3C).withOpacity(0.4)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff038D3C),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Create an account so you can explore all the existing jobs.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: singUpKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 15.h,
                          ),
                          TextFormField(
                            controller: uNameController,
                            validator: (val) => (val!.isEmpty)
                                ? "Please enter your UserName"
                                : null,
                            decoration: InputDecoration(
                              labelText: "username",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          TextFormField(
                            controller: emailController,
                            validator: (val) => (val!.isEmpty)
                                ? "Please enter your email"
                                : null,
                            decoration: InputDecoration(
                              labelText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          SizedBox(height: 15.h),
                          Obx(() {
                            return TextFormField(
                              controller: passwordController,
                              validator: (val) => (val!.isEmpty)
                                  ? "Please enter your password"
                                  : null,
                              obscureText: controller.isPasswordVisible.value,
                              decoration: InputDecoration(
                                labelText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.changePasswordVisibility();
                                  },
                                  icon: Icon(
                                    controller.isPasswordVisible.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                              ),
                            );
                          }),
                          SizedBox(height: 15.h),
                          Obx(
                            () {
                              return TextFormField(
                                controller: confirmPasswordController,
                                validator: (val) => (val!.isEmpty)
                                    ? "Please enter your confirm password"
                                    : null,
                                obscureText:
                                    controller.isConfirmPasswordVisible.value,
                                decoration: InputDecoration(
                                  labelText: "Confirm Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      controller
                                          .changeConfirmPasswordVisibility();
                                    },
                                    icon: Icon(
                                      controller.isPasswordVisible.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 15.h),
                          ElevatedButton(
                            onPressed: () {
                              if (singUpKey.currentState!.validate()) {
                                if (passwordController.text.trim() ==
                                    confirmPasswordController.text.trim()) {
                                  controller.singUp(
                                    uNameController.text,
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                  );
                                } else {
                                  toastification.show(
                                    title: const Text("Error"),
                                    description: const Text(
                                      "Something went wrong Password not match",
                                    ),
                                    style: ToastificationStyle.flat,
                                    type: ToastificationType.error,
                                    autoCloseDuration:
                                        const Duration(seconds: 2),
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff038D3C),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Center(
                            child: Text(
                              "Or continue with",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {
                                  controller.signUpWithGoogle();
                                },
                                icon: const Icon(Icons.g_mobiledata),
                                color: Colors.grey,
                                iconSize: 32,
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.apple),
                                color: Colors.grey,
                                iconSize: 32,
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.facebook),
                                color: Colors.grey,
                                iconSize: 32,
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Get.toNamed(GetPages.login);
                              },
                              child: const Text(
                                "Already have an account? Log in",
                                style: TextStyle(color: Color(0xff038D3C)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
