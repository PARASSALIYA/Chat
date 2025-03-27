import 'package:chat_app/views/home/controller/home_controller.dart';
import 'package:chat_app/views/login/contoller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/user.model.dart';
import '../../../services/firestore_services.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  HomeController homeController = Get.put(HomeController());
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add User"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirestoreServices.firestoreServices.fetchUser(),
                builder: (context, snapshot) {
                  var data = snapshot.data;
                  var allData = data?.docs ?? [];
                  List<UserModel> allUsers =
                      allData.map((e) => UserModel.fromJson(e.data())).toList();
                  return ListView.builder(
                    itemCount: allUsers.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          FirestoreServices.firestoreServices
                              .deleteUser(email: allUsers[index].email);
                        },
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(allUsers[index].image),
                        ),
                        title: Text(allUsers[index].name),
                        subtitle: Text(allUsers[index].email),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
