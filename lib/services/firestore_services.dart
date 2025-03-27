import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/chat_model.dart';
import '../model/user.model.dart';
import 'auth_services.dart';

class FirestoreServices {
  FirestoreServices._();

  static FirestoreServices firestoreServices = FirestoreServices._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String user = 'User';
  String userCollection = 'UserCollection';
  String chatCollection = 'chatCollection';
  String chat = 'Chats';
  String userChat = 'userChats';

  void addUser({required UserModel model}) async {
    await firestore.collection(user).doc(model.email).set(model.toMap);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchUser() {
    String email = AuthServices.authServices.currentUser?.email ?? "";
    return firestore
        .collection(user)
        .where("email", isNotEqualTo: email)
        .snapshots();
  }

  void updateUser({required UserModel model}) async {
    await firestore.collection(user).doc(model.email).update({
      'selectedImage': model.selectedImage,
      'isOnline': model.isOnline,
    });
  }

  void deleteUser({required String email}) async {
    await firestore.collection(user).doc(email).delete();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchSingleUser() async {
    String email = AuthServices.authServices.currentUser?.email ?? "";
    return await firestore.collection(user).doc(email).get();
  }

  Future<Stream<DocumentSnapshot<Map<String, dynamic>>>> fetchSingleUserChat(
      {required ChatModel chatModel}) async {
    String docId =
        createDocId(sent: chatModel.sent, receiver: chatModel.receiver);
    return firestore.collection(chatCollection).doc(docId).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchUserChatCollection(
      {required String sent, required String receiver}) {
    String docId = createDocId(sent: sent, receiver: receiver);
    return firestore
        .collection(user)
        .doc(docId)
        .collection(chatCollection)
        .doc(docId)
        .collection(userChat)
        .orderBy('time', descending: false)
        .snapshots();
  }

  void sentChat({required ChatModel chatModel}) async {
    String docId =
        createDocId(sent: chatModel.sent, receiver: chatModel.receiver);
    firestore
        .collection(chatCollection)
        .doc(docId)
        .collection(chat)
        .add(chatModel.toMap);
  }

  String createDocId({required String sent, required String receiver}) {
    List userList = [sent, receiver];
    userList.sort();
    String docId = userList.join("_");
    return docId;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchChat(
      {required String sent, required String receiver}) {
    String docId = createDocId(sent: sent, receiver: receiver);
    return firestore
        .collection(chatCollection)
        .doc(docId)
        .collection(chat)
        .orderBy('time', descending: false)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchUserChats(
      {required String sent, required String receiver}) {
    String docId = createDocId(sent: sent, receiver: receiver);
    return firestore
        .collection(user)
        .doc(docId)
        .collection(userCollection)
        .doc(docId)
        .collection(userChat)
        .orderBy('time', descending: false)
        .snapshots();
  }

  void updateChat({
    required String sent,
    required String receiver,
    required String msg,
    required String id,
    // required int selectedImage
  }) async {
    String docId = createDocId(sent: sent, receiver: receiver);

    firestore
        .collection(chatCollection)
        .doc(docId)
        .collection(chat)
        .doc(id)
        .update({'msg': msg});
  }

  void deleteChat(
      {required String sent,
      required String receiver,
      required String id}) async {
    String docId = createDocId(sent: sent, receiver: receiver);
    firestore
        .collection(chatCollection)
        .doc(docId)
        .collection(chat)
        .doc(id)
        .delete();
  }

  void seenChat({
    required String sent,
    required String receiver,
    required String id,
  }) async {
    String docId = createDocId(sent: sent, receiver: receiver);
    firestore
        .collection(chatCollection)
        .doc(docId)
        .collection(chat)
        .doc(id)
        .update(
      {
        'status': 'seen',
      },
    );
  }
}
