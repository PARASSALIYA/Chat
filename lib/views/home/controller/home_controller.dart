import 'package:chat_app/services/firestore_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // UserModel? user;
  Stream<QuerySnapshot<Map<String, dynamic>>>? fetchUserList;
  void fetchUser() {
    fetchUserList = FirestoreServices.firestoreServices.fetchUser();
    update();
  }
}
