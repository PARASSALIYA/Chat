import 'dart:developer';

import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/uitlls/get_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OTPVerificationPage extends StatelessWidget {
  const OTPVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 250,
                width: 250,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(
                  'assets/images/verification.jpg',
                ),
              ),
            ),
            SizedBox(height: 20.h),
            const Text(
              "OTP Verification",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            const Text(
              "Enter phone number to send one-time password",
            ),
            SizedBox(height: 15.h),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email Address",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () async {
                String phone = emailController.text.trim();
                if (phone.isNotEmpty) {
                  log("==2=======:$phone:===================");
                  await AuthServices.authServices.checkEmailVerification();
                  Get.offNamed(GetPages.otp);
                }
                emailController.clear();
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
                    "Continue",
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

// /// OTP Input Page
// class OTPInputPage extends StatelessWidget {
//   const OTPInputPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20.w),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Text(
//               "Verification Code",
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10.h),
//             const Text("We have sent the verification code to your email address"),
//             SizedBox(height: 20.h),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(
//                 4,
//                     (index) => Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 5.w),
//                   child: SizedBox(
//                     width: 50.w,
//                     child: TextField(
//                       textAlign: TextAlign.center,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                       ),
//                       keyboardType: TextInputType.number,
//                       maxLength: 1,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20.h),
//             ElevatedButton(
//               onPressed: () {
//                 Get.to(() => const SuccessPage());
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.orange,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//               ),
//               child: const Padding(
//                 padding: EdgeInsets.symmetric(vertical: 15),
//                 child: Center(child: Text("Confirm", style: TextStyle(color: Colors.white))),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// /// Success Page
// class SuccessPage extends StatelessWidget {
//   const SuccessPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20.w),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.check_circle, color: Colors.orange, size: 80),
//             SizedBox(height: 20.h),
//             const Text(
//               "Success!",
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10.h),
//             const Text("Congratulations! You have been successfully authenticated."),
//             SizedBox(height: 20.h),
//             ElevatedButton(
//               onPressed: () {
//                 Get.offAll(() => const OTPVerificationPage());
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.orange,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//               ),
//               child: const Padding(
//                 padding: EdgeInsets.symmetric(vertical: 15),
//                 child: Center(child: Text("Continue", style: TextStyle(color: Colors.white))),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
