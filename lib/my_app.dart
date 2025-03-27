import 'package:chat_app/uitlls/get_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: ScreenUtilInit(
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          getPages: GetPages.getPages,
        ),
      ),
    );
  }
}
