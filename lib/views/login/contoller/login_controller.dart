import 'package:chat_app/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

import '../../../model/user.model.dart';
import '../../../services/firestore_services.dart';
import '../../../uitlls/get_pages.dart';

class LoginController extends GetxController {
  RxBool isPasswordVisible = true.obs;

  void changePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void login(email, password) async {
    String msg = await AuthServices.authServices.login(email, password);
    if (msg == "Success") {
      toastification.show(
        title: const Text("Success"),
        description: const Text("Login successfully"),
        type: ToastificationType.success,
        style: ToastificationStyle.fillColored,
        autoCloseDuration: const Duration(seconds: 2),
      );

      Get.offNamed(GetPages.home);
      FirestoreServices.firestoreServices.updateUser(
        model: UserModel(
          uid: AuthServices.authServices.currentUser?.uid ?? "",
          name: AuthServices.authServices.currentUser?.displayName ?? "",
          email: email,
          selectedImage: 0,
          password: password,
          image: "",
          token: await FirebaseMessaging.instance.getToken() ?? "",
          isOnline: true,
        ),
      );
      // Get.offNamed(GetPages.otpVerification);
    } else {
      toastification.show(
        autoCloseDuration: const Duration(seconds: 2),
        title: const Text("Error"),
        description: Text(msg),
        type: ToastificationType.error,
      );
    }
  }

  Future<void> loginWithGoogle() async {
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
            uid: AuthServices.authServices.currentUser?.uid ?? "",
            name: AuthServices.authServices.currentUser?.displayName ?? "",
            email: user.email ?? "",
            selectedImage: 0,
            password: "",
            image: user.photoURL ?? "",
            token: await FirebaseMessaging.instance.getToken() ?? "",
            isOnline: true,
          ),
        );
      }
    }
  }

  void loginWithAnonymous() async {
    User? user = await AuthServices.authServices.anonymousLogin();
    if (user != null) {
      toastification.show(
        title: const Text("Success"),
        description: const Text("Login successfully"),
        type: ToastificationType.success,
        style: ToastificationStyle.fillColored,
        autoCloseDuration: const Duration(seconds: 2),
      );
    }
  }

  Future<void> currentUser() async {
    User? user = AuthServices.authServices.currentUser!;
    if (user != null) {
      toastification.show(
        title: const Text("Success"),
        description: const Text("Login successfully"),
        type: ToastificationType.success,
        style: ToastificationStyle.fillColored,
        autoCloseDuration: const Duration(seconds: 2),
      );
      Get.offNamed(GetPages.home);
    } else {}
  }

  void signOut() {
    AuthServices.authServices.signOut();
    FirestoreServices.firestoreServices.updateUser(
        model: UserModel(
      uid: AuthServices.authServices.currentUser?.uid ?? "",
      name: AuthServices.authServices.currentUser?.displayName ?? "",
      email: AuthServices.authServices.currentUser?.email ?? "",
      selectedImage: 0,
      password: "",
      image: "",
      token: "",
      isOnline: false,
    ));
    Get.offNamed(GetPages.login);
  }
}
