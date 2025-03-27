import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String msg;
  String sent;
  String receiver;
  String status;
  String selectIndex;
  Timestamp time;

  ChatModel({
    required this.msg,
    required this.sent,
    required this.receiver,
    required this.status,
    required this.time,
    required this.selectIndex,
  });

  factory ChatModel.toMap(Map<String, dynamic> data) {
    return ChatModel(
      msg: data['msg'],
      sent: data['sent'],
      receiver: data['receiver'],
      time: data['time'],
      selectIndex: data['selectIndex'],
      status: data['status'],
    );
  }

  Map<String, dynamic> get toMap => {
        'msg': msg,
        'sent': sent,
        'receiver': receiver,
        'status': status,
        'time': time,
        'selectIndex': selectIndex
      };
}
