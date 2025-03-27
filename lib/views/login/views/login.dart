import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../uitlls/get_pages.dart';
import '../contoller/login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    LoginController controller = Get.put(LoginController());
    GlobalKey<FormState> loginKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: loginKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      controller.loginWithAnonymous();
                    },
                    style: ButtonStyle(
                      side: WidgetStateProperty.all(
                        const BorderSide(
                          color: Color(0xff038D3C),
                        ),
                      ),
                      backgroundColor: WidgetStateProperty.all(
                        const Color(0xff038D3C),
                      ),
                      foregroundColor: WidgetStateProperty.all(
                        Colors.white,
                      ),
                    ),
                    icon: const Icon(
                      Icons.person_rounded,
                    ),
                    label: const Text("Guest"),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 250,
                  width: 250,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(
                    'assets/images/login.jpg',
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                const Text(
                  "Login here",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff038D3C),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                Text(
                  "Welcome back you've been missed!",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                TextFormField(
                  controller: emailController,
                  validator: (val) =>
                      (val!.isEmpty) ? "Please enter your email" : null,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                Obx(
                  () {
                    return TextFormField(
                      controller: passwordController,
                      validator: (val) =>
                          (val!.isEmpty) ? "Please enter your password" : null,
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
                  },
                ),
                SizedBox(height: 5.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot your password?",
                      style: TextStyle(color: Color(0xff038D3C)),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                ElevatedButton(
                  onPressed: () {
                    if (emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      controller.login(
                          emailController.text, passwordController.text);
                      // Get.toNamed(GetPages.otpVerification);
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
                      "LogIn",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Get.toNamed(GetPages.signUp);
                    },
                    child: const Text(
                      "Create new account",
                      style: TextStyle(color: Color(0xff038D3C)),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Center(
                  child: Text(
                    "Or continue with",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        controller.loginWithGoogle();
                      },
                      icon: const Icon(Icons.g_mobiledata),
                      color: Colors.grey,
                      iconSize: 32.sp,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.facebook),
                      color: Colors.grey,
                      iconSize: 32.sp,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
