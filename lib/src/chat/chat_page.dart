import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../main.dart';
import '../../core/auth_manager.dart';
import '../../core/utils/helper_manager.dart';
import '../../core/values/colors.dart';

import '../../core/values/size_constants.dart';
import '../../core/widget/common_widgets.dart';
import '../auth/auth_model/user_model.dart';
import 'firebase_models/User.dart';
import 'firebase_models/file_class.dart';
import 'firebase_models/message_model2.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  late String currentUserId;

  int _limit = 100;
  final int _limitIncrement = 20;
  static String groupChatId = '';

  File? imageFile;
  bool isLoading = false;
  bool isShowSticker = false;
  String imageUrl = '';
  static String UserToName = "";
  static String UserToId = "";
  static String UserToLogo = "";

  UserModel userModel = UserModel();

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  AuthenticationManager get readAuthManager =>
      context.read<AuthenticationManager>();

  @override
  void initState() {
    super.initState();

    readAuthManager.getUser().then(
        (value) => {currentUserId = value!.office!.id.toString(), userModel = value});

    focusNode.addListener(onFocusChanged);
    scrollController.addListener(_scrollListener);
  }

  _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  void onFocusChanged() {
    if (focusNode.hasFocus) {
      setState(() {
        isShowSticker = false;
      });
    }
  }
  Future<void> callApiBackend(MessageModel2 messageModel2) async {
    Map<String,String> headers = {'Content-Type':'application/json'};

    final response = await dio.post( "v1/sendMessage",options: Options(headers: headers), data:messageModel2 );

  }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile;
    pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      print("ghhhhff");
      if (imageFile != null) {
        setState(() {
          isLoading = true;
        });
        uploadImageFile();
      }
    }
  }

  void getSticker() {
    focusNode.unfocus();
    setState(() {
      isShowSticker = !isShowSticker;
    });
  }

  Future<bool> onBackPressed() {
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
    } else {
      // chatProvider.updateFirestoreData(FirestoreConstants.pathUserCollection,
      //     currentUserId, {FirestoreConstants.chattingWith: null});
    }
    return Future.value(false);
  }

  void uploadImageFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    UploadTask uploadTask = uploadImageFiled(imageFile!, fileName);
    try {

      TaskSnapshot snapshot = await uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        isLoading = false;
        MessageModel2 messageModel2 = MessageModel2();
        User yuser = User();
        yuser.id = userModel.office!.id.toString();
        yuser.name = userModel.office!.name;
        yuser.photo = userModel.office!.image.toString();
        yuser.type = "1";
        yuser.toUserId = UserToId;
        yuser.userLogo = UserToLogo;
        yuser.userName = UserToName;
        yuser.email = userModel.email!;

        messageModel2.user = yuser;
        FileClass fileClass=FileClass();
        fileClass.type="img";
        fileClass.name=fileName;
        fileClass.url=imageUrl;
        fileClass.size="";

        messageModel2.file = fileClass;
        messageModel2.timeStamp = DateTime.now().millisecondsSinceEpoch;
        messageModel2.groupChatId=groupChatId;

        FirebaseDatabase.instance
            .ref("Chats/${groupChatId}")
            .child(DateTime.now().millisecondsSinceEpoch.toString())
            .set(messageModel2.toJson());
        callApiBackend(messageModel2);
      });
    } on FirebaseException catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: e.message ?? e.toString());
    }
  }

  void onSendMessage(String content, int type) {
    if (content.trim().isNotEmpty) {
      textEditingController.clear();
      // chatProvider.sendChatMessage(
      //     content, type, groupChatId, currentUserId, widget.peerId);
      scrollController.animateTo(0,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      Fluttertoast.showToast(
          msg: 'Nothing to send', backgroundColor: Colors.grey);
    }
  }

  // checking if received message
  bool isMessageReceived(DataSnapshot index) {
    if (index.child("user").child("toUserId").value.toString() ==
        currentUserId) {
      return true;
    }
    return false;
  }

  // checking if sent message
  bool isMessageSent(DataSnapshot index) {
    if (index.child("user").child("id").value.toString() == currentUserId) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '$UserToName',
          style: GoogleFonts.tajawal(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [],
      ),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Sizes.dimen_8),
          child: Column(
            children: [
              buildListMessage(),
              buildMessageInput(),
            ],
          ),
        ),
      ),
    );
  }

  void sendChatMessage() {
    MessageModel2 messageModel2 = MessageModel2();
    User yuser = User();
    yuser.id = userModel.office!.id.toString();
    yuser.name = userModel.office!.name;
    yuser.photo = userModel.office!.image.toString();
    yuser.type = "1";
    yuser.toUserId = UserToId;
    yuser.userLogo = UserToLogo;
    yuser.userName = UserToName;
    yuser.email = userModel.email!;

    messageModel2.user = yuser;
    messageModel2.messgage = textEditingController.value.text;
    messageModel2.groupChatId=groupChatId;
    messageModel2.timeStamp = DateTime.now().millisecondsSinceEpoch;

    FirebaseDatabase.instance
        .ref("Chats/${groupChatId}")
        .child(DateTime.now().millisecondsSinceEpoch.toString())
        .set(messageModel2.toJson());

    callApiBackend(messageModel2);
    setState((){
      textEditingController.text="";
    });
  }

  Widget buildMessageInput() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: Sizes.dimen_4),
            decoration: BoxDecoration(
              color: samaColor,
              borderRadius: BorderRadius.circular(Sizes.dimen_30),
            ),
            child: IconButton(
              onPressed: getImage,
              icon: const Icon(
                Icons.camera_alt,
                size: Sizes.dimen_28,
              ),
              color: Colors.white,
            ),
          ),
          Flexible(
              child: TextField(
            focusNode: focusNode,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.sentences,
            controller: textEditingController,
            decoration: InputDecoration(
              fillColor: Colors.white,
              border: InputBorder.none,
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.blue)),
              filled: true,
              contentPadding:
                  const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
              labelText: tr('WriteMessage'),
            ),
            onSubmitted: (value) {
              //   onSendMessage(textEditingController.text, MessageType.text);
            },
          )),
          Container(
            margin: const EdgeInsets.only(left: Sizes.dimen_4),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(Sizes.dimen_30),
            ),
            child: IconButton(
              onPressed: () {
                if(textEditingController.value.text.isNotEmpty) {
                  sendChatMessage();
                }else{
                  toastApp(tr('WriteMessage'),context);
                }
              },
              icon: const Icon(Icons.send_rounded),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(int index, DataSnapshot? snapshot) {
    if (snapshot != null) {
      if (snapshot.child("user").child("id").value.toString() ==
          currentUserId) {
        // right side (my message)
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                snapshot.child("messgage").value.toString() != "null"
                    ? messageBubble(
                        chatContent:
                            snapshot.child("messgage").value.toString(),
                        color: spaceLight,
                        textColor: white,
                        margin: const EdgeInsets.only(right: Sizes.dimen_10),
                      )
                    : snapshot.child("file").child("type").value.toString() ==
                            "img"
                        ? Container(
                            margin: const EdgeInsets.only(
                                right: Sizes.dimen_10, top: Sizes.dimen_10),
                            child: chatImage(
                                imageSrc: snapshot
                                    .child("file")
                                    .child("url")
                                    .value
                                    .toString(),
                                onTap: () {}),
                          )
                        : const SizedBox.shrink(),
                isMessageSent(snapshot)
                    ? Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizes.dimen_20),
                        ),
                        child: Image.network(
                          snapshot
                              .child("user")
                              .child("photo")
                              .value
                              .toString(),
                          width: Sizes.dimen_40,
                          height: Sizes.dimen_40,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext ctx, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                color: burgundy,
                                value: loadingProgress.expectedTotalBytes !=
                                            null &&
                                        loadingProgress.expectedTotalBytes !=
                                            null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, object, stackTrace) {
                            return const Icon(
                              Icons.account_circle,
                              size: 35,
                              color: greyColor,
                            );
                          },
                        ),
                      )
                    : Container(
                        width: 35,
                      ),
              ],
            ),
            isMessageSent(snapshot)
                ? Container(
                    margin: const EdgeInsets.only(
                        right: Sizes.dimen_50,
                        top: Sizes.dimen_6,
                        bottom: Sizes.dimen_8),
                    child: Text(
                      DateFormat('E MMM d HH:mm:ss yyyy').format(
                        DateTime.fromMillisecondsSinceEpoch(
                          int.parse(
                              snapshot.child("timeStamp").value.toString()),
                        ),
                      ),
                      style: const TextStyle(
                          color: lightGrey,
                          fontSize: Sizes.dimen_12,
                          fontStyle: FontStyle.italic),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                isMessageReceived(snapshot)
                    // left side (received message)
                    ? Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizes.dimen_20),
                        ),
                        child: Image.network(
                          snapshot
                              .child("user")
                              .child("photo")
                              .value
                              .toString(),
                          width: Sizes.dimen_40,
                          height: Sizes.dimen_40,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext ctx, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                color: burgundy,
                                value: loadingProgress.expectedTotalBytes !=
                                            null &&
                                        loadingProgress.expectedTotalBytes !=
                                            null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, object, stackTrace) {
                            return const Icon(
                              Icons.account_circle,
                              size: 35,
                              color: greyColor,
                            );
                          },
                        ),
                      )
                    : Container(
                        width: 35,
                      ),
                snapshot.child("messgage").value.toString() != "null"
                    ? messageBubble(
                        color: burgundy,
                        textColor: white,
                        chatContent:
                            snapshot.child("messgage").value.toString(),
                        margin: const EdgeInsets.only(left: Sizes.dimen_10),
                      )
                    : snapshot.child("file").child("type").value.toString() ==
                            "img"
                        ? Container(
                            margin: const EdgeInsets.only(
                                left: Sizes.dimen_10, top: Sizes.dimen_10),
                            child: chatImage(
                                imageSrc: snapshot
                                    .child("file")
                                    .child("url")
                                    .value
                                    .toString(),
                                onTap: () {}),
                          )
                        : const SizedBox.shrink(),
              ],
            ),
            isMessageReceived(snapshot)
                ? Container(
                    margin: const EdgeInsets.only(
                        left: Sizes.dimen_50,
                        top: Sizes.dimen_6,
                        bottom: Sizes.dimen_8),
                    child: Text(
                      DateFormat('E MMM d HH:mm:ss yyyy').format(
                        DateTime.fromMillisecondsSinceEpoch(
                          int.parse(
                              snapshot.child("timeStamp").value.toString()),
                        ),
                      ),
                      style: const TextStyle(
                          color: lightGrey,
                          fontSize: Sizes.dimen_12,
                          fontStyle: FontStyle.italic),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        );
      }
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget buildListMessage() {
    var f = DateFormat('E MMM d HH:mm:ss yyyy ');
    var date = f.format(DateTime.now().toUtc());
    print(date);
    return Flexible(
      child: groupChatId.isNotEmpty
          ? FirebaseAnimatedList(
              query: getChatMessage(groupChatId, 200),
              padding: const EdgeInsets.all(10),
              reverse: false,
              controller: scrollController,
              itemBuilder: (context, snapshot, animation, index) {
                if (snapshot.children.isNotEmpty) {
                  if (snapshot.children.isNotEmpty) {
                    return buildItem(index, snapshot);
                  } else {
                    return const Center(
                      child: Text('No messages...'),
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: burgundy,
                    ),
                  );
                }
              })
          : const Center(
              child: CircularProgressIndicator(
                color: burgundy,
              ),
            ),
    );
  }
}
