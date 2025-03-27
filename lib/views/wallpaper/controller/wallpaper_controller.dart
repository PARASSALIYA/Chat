import 'package:chat_app/model/user.model.dart';
import 'package:get/get.dart';

import '../../../services/firestore_services.dart';

class WallpaperController extends GetxController {
  int currentIndex = 0;
  List images = [
    'assets/images/1.jpeg',
    'assets/images/2.jpeg',
    'assets/images/4.jpeg',
    'assets/images/9.jpeg',
    'assets/images/10.jpeg',
    'assets/images/12.jpeg',
    'assets/images/13.jpeg',
    'assets/images/14.jpeg',
    'assets/images/15.jpeg',
    'assets/images/16.jpeg',
    'assets/images/18.jpeg',
    'assets/images/20.jpeg',
    'assets/images/21.jpeg',
    'assets/images/22.jpeg',
    'assets/images/23.jpeg',
    'assets/images/24.jpeg',
    'assets/images/25.jpeg',
    'assets/images/26.jpeg',
    'assets/images/27.jpeg',
  ];

  void changeImage(int index, UserModel user) {
    currentIndex = index;
    user.selectedImage = index;
    FirestoreServices.firestoreServices.updateUser(model: user);
    update();
  }
}
