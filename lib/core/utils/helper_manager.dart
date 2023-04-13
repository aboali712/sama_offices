import 'dart:async';
import 'dart:io';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

late StreamSubscription<DatabaseEvent> messagesSubscriptions;
late DatabaseReference messagesRef;


toastApp(String msg, BuildContext context) {
  return ElegantNotification(
    iconSize: 26,
    width: MediaQuery.of(context).size.width,
    height: 50,
    displayCloseButton: false,
    description: Text(
      msg,
      style: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15),
    ),
    icon: const Padding(
      padding: EdgeInsets.all(8.0),
      child: Icon(
        Icons.error_outlined,
        color: Colors.red,
      ),
    ),
    progressIndicatorColor: Colors.redAccent,
  ).show(context);
}

toastAppSuccess(String msg, BuildContext context) {
  return ElegantNotification(
    iconSize: 26,
    width: MediaQuery.of(context).size.width,
    height: 50,
    displayCloseButton: false,
    description: Text(
      msg,
      style: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15),
    ),
    icon: const Padding(
      padding: EdgeInsets.all(8.0),
      child: Icon(
        Icons.check_circle,
        color: Colors.green,
      ),
    ),
    progressIndicatorColor: Colors.lightGreen,
  ).show(context);
}

UploadTask uploadImageFiled(File image, String filename) {
  Reference reference = FirebaseStorage.instance.ref().child(filename);
  UploadTask uploadTask = reference.putFile(image);
  return uploadTask;
}
DatabaseReference getChatMessage(String groupChatId, int limit) {
  var database=FirebaseDatabase.instance;
  messagesRef=  database.ref("Chats/${groupChatId}");


  final messagesQuery =messagesRef
      .child(groupChatId).orderByChild("Chats/${groupChatId}/timeStamp").limitToFirst(limit);

  messagesSubscriptions = messagesQuery.onChildAdded.listen(
        (DatabaseEvent event) {
      print('Child added: ${event.snapshot.value}');
    },
    onError: (Object o) {
      final error = o as FirebaseException;
      print('Error: ${error.code} ${error.message}');
    },
  );

  return messagesRef;

}
