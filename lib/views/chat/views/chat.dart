// import 'package:chat_app/services/auth_services.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// import '../../../model/chat_model.dart';
// import '../../../model/user.model.dart';
// import '../../../services/colud_notification_services.dart';
// import '../../../services/firestore_services.dart';
// import '../../../uitlls/get_pages.dart';
// import '../../wallpaper/controller/wallpaper_controller.dart';
// import '../controller/chat_controller.dart';
//
// class ChatPage extends StatelessWidget {
//   const ChatPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     UserModel user = Get.arguments;
//     ChatController chatController = Get.put(ChatController());
//     WallpaperController wallpaperController = Get.put(WallpaperController());
//     TextEditingController messageController = TextEditingController();
//     ScrollController scrollController = ScrollController();
// String getMessageDate(Timestamp timestamp) {
//   DateTime date = timestamp.toDate();
//   DateTime now = DateTime.now();
//   if (date.year == now.year && date.month == now.month && date.day == now.day) {
//     return "Today";
//   } else if (date.year == now.year && date.month == now.month && date.day == now.day - 1) {
//     return "Yesterday";
//   } else {
//     return "${date.day}/${date.month}/${date.year}";
//   }
// }
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//           },
//           icon: const Icon(Icons.arrow_back_ios),
//         ),
//         title: Row(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             CircleAvatar(
//               backgroundImage: NetworkImage(user.image),
//             ),
//             const SizedBox(width: 10),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                   user.name,
//                   style: const TextStyle(
//                     fontSize: 16,
//                   ),
//                 ),
//                 Text(
//                   user.isOnline ? "Online" : "Offline",
//                   style: const TextStyle(fontSize: 12, color: Colors.grey),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         actions: [
//           PopupMenuButton(
//             itemBuilder: (BuildContext context) {
//               return [
//                 PopupMenuItem(
//                   child: const Text("Voice Call"),
//                   onTap: () {
//                     Get.toNamed(GetPages.wallpaper, arguments: user);
//                   },
//                 ),
//                 PopupMenuItem(
//                   child: const Text("Video Call"),
//                   onTap: () {
//                     Get.toNamed(GetPages.wallpaper, arguments: user);
//                   },
//                 ),
//                 PopupMenuItem(
//                   child: const Text("WallPaper"),
//                   onTap: () {
//                     Get.toNamed(GetPages.wallpaper, arguments: user);
//                   },
//                 ),
//               ];
//             },
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           GetBuilder<WallpaperController>(
//             builder: (context) {
//               return Container(
//                 height: double.infinity,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(
//                       "${wallpaperController.images[user.selectedImage]}",
//                     ),
//                     fit: BoxFit.cover,
//                   ),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               );
//             },
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: StreamBuilder(
//                     stream: FirestoreServices.firestoreServices.fetchChat(
//                         sent:
//                             AuthServices.authServices.currentUser!.email ?? '',
//                         receiver: user.email),
//                     builder: (context, snapshot) {
//                       var data = snapshot.data;
//                       var allData = data?.docs ?? [];
//
//                       List<ChatModel> allChat = allData
//                           .map((e) => ChatModel.toMap(e.data()))
//                           .toList();
//                       return ListView.builder(
//                         controller: scrollController,
//                         itemCount: allChat.length,
//                         itemBuilder: (context, index) {
//                       String? lastDate;
//                       String messageDate = getMessageDate(allChat[index].time);bool showDate = messageDate != lastDate;
//                           lastDate = messageDate;
//
//                           // WidgetsBinding.instance.addPostFrameCallback((_) {
//                           //   scrollController.jumpTo(
//                           //       scrollController.position.maxScrollExtent);
//                           // });
//
//                       if ((allChat[index].receiver == user.email)) {
//                         return  Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment:
//                                   CrossAxisAlignment.end,
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Flexible(
//                                       child: GestureDetector(
//                                         onDoubleTap: () {
//                                           FirestoreServices
//                                               .firestoreServices
//                                               .deleteChat(
//                                             sent: AuthServices.authServices
//                                                 .currentUser?.email ??
//                                                 "",
//                                             receiver: user.email,
//                                             id: allData[index].id,
//                                           );
//                                         },
//                                         onLongPress: () {
//                                           String msg = messageController
//                                               .text = allChat[index].msg;
//
//                                           chatController.changeUpdateValue(
//                                               id: allData[index].id);
//                                         },
//                                         child: Container(
//                                           margin: const EdgeInsets.all(5),
//                                           padding: const EdgeInsets.all(10),
//                                           decoration: const BoxDecoration(
//                                             color: Color(0xffFFE1A5),
//                                             borderRadius: BorderRadius.all(
//                                               Radius.circular(10),
//                                             ),
//                                           ),
//                                           child: Row(
//                                             mainAxisSize: MainAxisSize.min,
//                                             children: [
//                                               Text(
//                                                 allChat[index].msg,
//                                                 style: const TextStyle(
//                                                   fontSize: 15,
//                                                   color: Colors.black,
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 width: 5.w,
//                                                 height: 5.h,
//                                               ),
//                                               Align(
//                                                 child: Text(
//                                                   "${allChat[index].time.toDate().hour}:${allChat[index].time.toDate().minute}",
//                                                   style: const TextStyle(
//                                                     fontSize: 10,
//                                                     color: Colors.black,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     Align(
//                                       alignment: Alignment.bottomLeft,
//                                       child: Text(
//                                         allChat[index].status == "seen"
//                                             ? "seen"
//                                             : "sent",
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ],
//                         );
//                       } else {
//                         FirestoreServices.firestoreServices.seenChat(
//                           id: allData[index].id,
//                           receiver: user.email,
//                           sent: AuthServices
//                               .authServices.currentUser!.email ??
//                               '',
//                         );
//                         return Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Flexible(
//                               child: GestureDetector(
//                                 onDoubleTap: () {
//                                   FirestoreServices.firestoreServices
//                                       .deleteChat(
//                                     sent: AuthServices.authServices
//                                         .currentUser?.email ??
//                                         "",
//                                     receiver: user.email,
//                                     id: allData[index].id,
//                                   );
//                                 },
//                                 child: Container(
//                                   padding: const EdgeInsets.all(10),
//                                   margin: const EdgeInsets.all(5),
//                                   decoration: const BoxDecoration(
//                                     color: Color(0xff85C996),
//                                     borderRadius: BorderRadius.all(
//                                       Radius.circular(10),
//                                     ),
//                                   ),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Text(
//                                         allChat[index].msg,
//                                         style: const TextStyle(
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                       Align(
//                                         alignment:
//                                         const Alignment(0.0, 1.0),
//                                         child: Text(
//                                           "${allChat[index].time.toDate().hour}:${allChat[index].time.toDate().minute}",
//                                           style: const TextStyle(
//                                             fontSize: 10,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         );
//                       }
//                         },
//                       );
//                     },
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         style: const TextStyle(
//                           color: Colors.black,
//                         ),
//                         controller: messageController,
//                         decoration: const InputDecoration(
//                           focusColor: Colors.black,
//                           focusedBorder: OutlineInputBorder(),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(10),
//                             ),
//                           ),
//                           labelText: 'Message...',
//                           labelStyle: TextStyle(
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                     ),
//                     GetBuilder<ChatController>(
//                       builder: (context) {
//                         return IconButton(
//                           onPressed: () async {
//                             String msg = messageController.text.trim();
//                             if (msg.isNotEmpty) {
//                               if (!chatController.isUpdate) {
//                                 ChatModel chatModel = ChatModel(
//                                   sent: AuthServices
//                                           .authServices.currentUser!.email ??
//                                       '',
//                                   receiver: user.email,
//                                   msg: msg,
//                                   status: "Unseen",
//                                   selectIndex:
//                                       "${wallpaperController.currentIndex}",
//                                   time: Timestamp.now(),
//                                 );
//
//                                 FirestoreServices.firestoreServices
//                                     .sentChat(chatModel: chatModel);
//                                 messageController.clear();
//                               } else {
//                                 FirestoreServices.firestoreServices.updateChat(
//                                   sent: AuthServices
//                                           .authServices.currentUser!.email ??
//                                       "",
//                                   id: chatController.id,
//                                   msg: messageController.text.trim(),
//                                   receiver: user.email,
//                                   // selectedImage: user.selectedImage,
//                                 );
//                                 messageController.clear();
//                                 chatController.changeUpdateValueFalse();
//                               }
//                               await Notifications.notifications
//                                   .sendNotification(
//                                 title: user.name,
//                                 body: msg,
//                                 token: user.token,
//                               );
//                               messageController.clear();
//                             }
//                           },
//                           icon: const Icon(
//                             Icons.send,
//                             color: Colors.black,
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//

import 'package:chat_app/services/auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/chat_model.dart';
import '../../../model/user.model.dart';
import '../../../services/colud_notification_services.dart';
import '../../../services/firestore_services.dart';
import '../../../uitlls/get_pages.dart';
import '../../wallpaper/controller/wallpaper_controller.dart';
import '../controller/chat_controller.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel user = Get.arguments;
    ChatController chatController = Get.put(ChatController());
    WallpaperController wallpaperController = Get.put(WallpaperController());
    TextEditingController messageController = TextEditingController();
    ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.image),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  user.isOnline ? "Online" : "Offline",
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == "WallPaper") {
                Get.toNamed(GetPages.wallpaper, arguments: user);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                  value: "Voice Call", child: Text("Voice Call")),
              const PopupMenuItem(
                  value: "Video Call", child: Text("Video Call")),
              const PopupMenuItem(value: "WallPaper", child: Text("WallPaper")),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          GetBuilder<WallpaperController>(
            builder: (_) => Container(
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      wallpaperController.images[user.selectedImage]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: FirestoreServices.firestoreServices.fetchChat(
                      sent: AuthServices.authServices.currentUser!.email ?? '',
                      receiver: user.email,
                    ),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      var allData = snapshot.data?.docs ?? [];
                      List<ChatModel> allChat = allData
                          .map((e) => ChatModel.toMap(e.data()))
                          .toList();

                      String? lastDate;
                      return ListView.builder(
                        controller: scrollController,
                        itemCount: allChat.length,
                        itemBuilder: (context, index) {
                          String messageDate =
                              getMessageDate(allChat[index].time);
                          bool showDate = messageDate != lastDate;
                          lastDate = messageDate;

                          return Row(
                            children: [
                              Flexible(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    if (showDate)
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          child: Text(
                                            messageDate,
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    Align(
                                      alignment:
                                          allChat[index].receiver == user.email
                                              ? Alignment.centerRight
                                              : Alignment.centerLeft,
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: allChat[index].receiver ==
                                                  user.email
                                              ? Colors.yellow[200]
                                              : Colors.green[300],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              allChat[index].msg,
                                              style:
                                                  const TextStyle(fontSize: 15),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                "${allChat[index].time.toDate().hour}:${allChat[index].time.toDate().minute}",
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        decoration:
                            const InputDecoration(labelText: 'Message...'),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        String msg = messageController.text.trim();
                        if (msg.isNotEmpty) {
                          ChatModel chatModel = ChatModel(
                            sent:
                                AuthServices.authServices.currentUser!.email ??
                                    '',
                            receiver: user.email,
                            msg: msg,
                            status: "Unseen",
                            selectIndex: "${wallpaperController.currentIndex}",
                            time: Timestamp.now(),
                          );
                          FirestoreServices.firestoreServices
                              .sentChat(chatModel: chatModel);
                          messageController.clear();
                          await Notifications.notifications.sendNotification(
                            title: user.name,
                            body: msg,
                            token: user.token,
                          );
                        }
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getMessageDate(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    DateTime now = DateTime.now();
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return "Today";
    } else if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day - 1) {
      return "Yesterday";
    } else {
      return "${date.day}/${date.month}/${date.year}";
    }
  }
}
