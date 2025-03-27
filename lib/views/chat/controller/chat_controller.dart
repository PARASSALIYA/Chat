import 'package:chat_app/services/firestore_services.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  bool isUpdate = false;
  String id = "";
  void changeUpdateValue({required String id}) {
    isUpdate = true;
    this.id = id;
    update();
  }

  void changeUpdateValueFalse() {
    isUpdate = false;
    update();
  }

  Future<void> updateChat({
    required String sent,
    required String receiver,
    required String msg,
    required String id,
  }) async {
    FirestoreServices.firestoreServices
        .updateChat(sent: sent, receiver: receiver, msg: msg, id: id);
    update();
  }
}
