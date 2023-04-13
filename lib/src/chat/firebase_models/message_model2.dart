import 'dart:convert';
import 'dart:ffi';
import 'User.dart';
import 'audio.dart';
import 'file_class.dart';

MessageModel2 messageModel2FromJson(String str) => MessageModel2.fromJson(json.decode(str));

String messageModel2ToJson(MessageModel2 data) => json.encode(data.toJson());

class MessageModel2 {
  MessageModel2({
    this.timeStamp,
    this.messgage,
    this.user,
    this.file,
    this.groupChatId,
    this.audio
  });

  int? timeStamp;
  Audio? audio;
  String? messgage;
  FileClass? file;
  User? user;
  String? groupChatId;

  factory MessageModel2.fromJson(Map<String, dynamic> json) => MessageModel2(
    timeStamp: json["timeStamp"],
    messgage: json["messgage"],
    groupChatId: json["messgage"],

    file: FileClass.fromJson(json["file"]),
    audio: Audio.fromJson(json["audio"]),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "timeStamp": timeStamp,
    "messgage": messgage,
    "groupChatId": groupChatId,
    "file": (file != null) ? file!.toJson() : null,
    "audio": (audio != null) ? audio!.toJson() : null,
    "user": user!.toJson(),
  };
}