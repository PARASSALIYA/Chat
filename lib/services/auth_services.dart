import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  AuthServices._();

  static AuthServices authServices = AuthServices._();
  GoogleSignInAccount? googleSignInAccount;

  Future<String> signUp(email, password) async {
    String msg;
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      msg = "Success";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'operation-not-allowed':
          msg = 'try another way to login';
        case 'week-password':
          msg = "password is week ";
        case 'email-already-in-use':
          msg = "email already exits...";
        default:
          msg = e.code;
      }
    }
    return msg;
  }

  Future<String> login(email, password) async {
    String msg;
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      msg = "Success";
    } on FirebaseAuthException catch (e) {
      log("===================${e.code}================");
      switch (e.code) {
        case 'invalid-credential':
          msg = "email or password is invalid";
        case 'operation-not-allowed':
          msg = 'try another way to login';
        default:
          msg = e.code;
      }
    }
    return msg;
  }

  Future<String> signUpWithGoogle() async {
    String msg;
    try {
      googleSignInAccount = await GoogleSignIn().signIn();
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication? googleAuth =
            await googleSignInAccount?.authentication;

        var credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
        msg = "Success";
      } else {
        msg = "Not Google Account !!!";
      }
    } on FirebaseAuthException catch (e) {
      msg = e.code;
    }
    return msg;
  }

  Future<User?> anonymousLogin() async {
    UserCredential credential = await FirebaseAuth.instance.signInAnonymously();
    return credential.user;
  }

  User? get currentUser => FirebaseAuth.instance.currentUser;

  Future<void> signInWithEmailLink(emailLink) async {
    // User? user = FirebaseAuth.instance.currentUser;
    //
    // if (user != null && !user.emailVerified) {
    //   try {
    //     await user.sendEmailVerification();
    //     log("================= Verification email sent.");
    //     const GetSnackBar(
    //       title: "Success",
    //       message: "Verification email sent.",
    //       backgroundColor: Colors.green,
    //     );
    //   } catch (e) {
    //     log("=================Error sending verification email: $e");
    //     GetSnackBar(
    //       title: "Error",
    //       message: "Error sending verification email: $e",
    //       backgroundColor: Colors.red,
    //     );
    //   }
    // }
    var acs = ActionCodeSettings(
      url: 'https://chat-app-7fde3.firebaseapp.com/auth',
      handleCodeInApp: true,
      iOSBundleId: 'com.example.ios',
      androidPackageName: 'com.example.android',
      androidInstallApp: true,
      androidMinimumVersion: '12',
    );
    var emailAuth = 'parassaliya123@gmail.com';
    FirebaseAuth.instance
        .sendSignInLinkToEmail(email: emailAuth, actionCodeSettings: acs);
  }

  Future<void> checkEmailVerification() async {
    var user = FirebaseAuth.instance.currentUser;
    await user?.reload();
    if (user != null && user.emailVerified) {
      log("=================Email is verified!");
      const GetSnackBar(
        title: "Success",
        message: "Email is verified!",
        backgroundColor: Colors.green,
      );
    } else {
      log("===================Email is not verified. Please check your inbox.");
      const GetSnackBar(
        title: "Error",
        message: "Email is not verified. Please check your inbox.",
        backgroundColor: Colors.red,
      );
    }
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}
