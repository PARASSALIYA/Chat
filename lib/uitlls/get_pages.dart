import 'package:chat_app/otp/views/otp.dart';
import 'package:chat_app/views/adduser/views/add_user.dart';
import 'package:chat_app/views/login/views/login.dart';
import 'package:chat_app/views/singup/views/singup.dart';
import 'package:get/get.dart';

import '../intro/views/intro_page.dart';
import '../views/chat/views/chat.dart';
import '../views/home/views/home.dart';
import '../views/otpverification/views/otpverification.dart';
import '../views/splash/views/splash_page.dart';
import '../views/wallpaper/views/wallpaper_page.dart';

class GetPages {
  static String splash = '/';
  static String login = '/login';
  static String intro = '/intro';
  static String signUp = '/signUp';
  static String home = '/home';
  static String chat = '/chat';
  static String adduser = '/adduser';
  static String otp = '/otp';
  static String otpVerification = '/OTPVerification';
  static String wallpaper = '/wallpaper';

  static List<GetPage> getPages = [
    GetPage(
      name: splash,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: signUp,
      page: () => const SingUpPage(),
    ),
    GetPage(
      name: intro,
      page: () => const IntroPage(),
    ),
    GetPage(
      name: otpVerification,
      page: () => const OTPVerificationPage(),
    ),
    GetPage(
      name: otp,
      page: () => const OTPInputPage(),
    ),
    GetPage(
      name: home,
      page: () => const HomePage(),
    ),
    GetPage(
      name: chat,
      page: () => const ChatPage(),
    ),
    GetPage(
      name: adduser,
      page: () => const AddUserPage(),
    ),
    GetPage(
      name: wallpaper,
      page: () => const WallpaperPage(),
    ),
  ];
}
