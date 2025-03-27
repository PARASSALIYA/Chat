import 'package:chat_app/uitlls/get_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// OTP Input Page
class OTPInputPage extends StatelessWidget {
  const OTPInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    final otpController = TextEditingController();
    var verificationId = Get.arguments;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50.h,
            ),
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            SizedBox(
              height: 30.h,
            ),
            const Text(
              "Verification Code",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            const Text(
                "We have sent the verification code to your email address"),
            SizedBox(height: 20.h),
            OtpTextField(
              numberOfFields: 5,
              borderColor: const Color(0xff038D3C),
              focusedBorderColor: const Color(0xff038D3C),
              enabledBorderColor: const Color(0xff038D3C),
              showFieldAsBox: true,
              onCodeChanged: (String code) {},
              onSubmit: (String verificationCode) async {
                otpController.text = verificationCode;
                FocusScope.of(context).unfocus();
              },
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(GetPages.home);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff038D3C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Center(
                  child: Text(
                    "Confirm",
                    style: TextStyle(color: Colors.white),
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
