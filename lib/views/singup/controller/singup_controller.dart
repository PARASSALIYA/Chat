import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

import '../../../model/user.model.dart';
import '../../../services/auth_services.dart';
import '../../../services/firestore_services.dart';
import '../../../uitlls/get_pages.dart';
import '../../wallpaper/controller/wallpaper_controller.dart';

class SignUpController extends GetxController {
  RxBool isPasswordVisible = true.obs;
  RxBool isConfirmPasswordVisible = true.obs;
  WallpaperController wallpaperController = Get.put(WallpaperController());
  void changePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void changeConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  Future<void> singUp(uName, email, password) async {
    String msg = await AuthServices.authServices.signUp(email, password);
    if (msg == "Success") {
      toastification.show(
        title: const Text("Success"),
        description: Text(msg),
        type: ToastificationType.success,
        style: ToastificationStyle.fillColored,
        autoCloseDuration: const Duration(seconds: 2),
      );
      FirestoreServices.firestoreServices.addUser(
        model: UserModel(
          uid: AuthServices.authServices.currentUser?.uid ?? "",
          name: uName,
          email: email,
          selectedImage: 0,
          password: password,
          image: "",
          token: await FirebaseMessaging.instance.getToken() ?? "",
          isOnline: false,
        ),
      );
      Get.offNamed(GetPages.login);
    } else {
      toastification.show(
        autoCloseDuration: const Duration(seconds: 2),
        title: const Text("Error"),
        description: Text(msg),
        type: ToastificationType.error,
      );
    }
    update();
  }

  Future<void> signUpWithGoogle() async {
    String msg = await AuthServices.authServices.signUpWithGoogle();
    if (msg == "Success") {
      Get.offNamed(GetPages.home);
      // Get.offNamed(GetPages.otpVerification);
      var user = AuthServices.authServices.currentUser;

      if (user != null) {
        FirestoreServices.firestoreServices.addUser(
          model: UserModel(
            uid: user.uid ?? "",
            name: user.displayName ?? "",
            email: user.email ?? "",
            password: "",
            selectedImage: 0,
            image: user.photoURL ?? "",
            token: await FirebaseMessaging.instance.getToken() ?? "",
            isOnline: false,
          ),
        );
        AuthServices.authServices.signInWithEmailLink(user.email);
        FirestoreServices.firestoreServices.updateUser(
          model: UserModel(
            uid: user.uid ?? "",
            name: user.displayName ?? "",
            email: user.email ?? "",
            password: "",
            selectedImage: 0,
            image: user.photoURL ?? "",
            token: await FirebaseMessaging.instance.getToken() ?? "",
            isOnline: true,
          ),
        );
      }
    }
  }
}
