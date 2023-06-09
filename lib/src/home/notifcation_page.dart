import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama_offices/src/home/resevition/model/not_reponse.dart';
import 'package:sama_offices/src/home/resevition/model/notifications_model.dart';

import '../../../../../main.dart';
import '../../../../core/utils/helper_manager.dart';
import '../../../core/cash/storage.helper.dart';
import '../../../core/values/colors.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with StorageHelper {
  List<NotificationModel> list = <NotificationModel>[];
  bool isLoading = false;
  String? token = "";

  @override
  void initState() {
    super.initState();
    this.getToken().then((value) => {
          setState(() {
            token = value!;
            callApiBackend();
          })
        });
  }

  Future<void> callApiBackend() async {
    if (token != "" && token != null) {
      setState(() {
        isLoading = true;
      });
      final response = await dio.get("v1/office/notifications");
      setState(() {
        isLoading = false;
        list = NotResponse(response.data!).data!;
      });
    }
  }

  Future<void> deleteCallApiBackend(String id) async {
    if (token != "" && token != null) {
      setState(() {
        isLoading = true;
      });
      final response = await dio.get("v1/office/deleteNotification",
          queryParameters: Map.of({"notification_id": id}));
      setState(() {
        isLoading = false;
        callApiBackend();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const SizedBox(
          height: 40,
        ),
        Row(
          children: [
            Align(
                alignment: AlignmentDirectional.topStart,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back))),
            Text(
              tr("Notification"),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Divider(
          height: 1,
          color: Colors.grey,
        ),
        SizedBox(
          height: 10,
        ),
        token != ""
            ? !isLoading
                ? list.isNotEmpty
                    ? Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                              children: list
                                  .map((notif) => Container(
                                        padding: EdgeInsets.all(5),
                                        margin: EdgeInsets.all(5),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border:
                                                Border.all(color: grayColor)),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 30,
                                              backgroundImage: Image.asset(
                                                "assets/images/applogo.png",
                                                height: 80,
                                                width: 80,
                                              ).image,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      100,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        notif.title!,
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      IconButton(
                                                        style: IconButton.styleFrom(
                                                            fixedSize:
                                                                const Size(
                                                                    50, 50),
                                                            backgroundColor:
                                                                Colors.red,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15))),
                                                        icon: const Icon(
                                                          Icons.close,
                                                          color: Colors.red,
                                                          size: 25,
                                                        ),
                                                        onPressed: () {
                                                          deleteCallApiBackend(
                                                              notif.id
                                                                  .toString());
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      150,
                                                  child: Text(
                                                    notif.description!,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList()),
                        ),
                      )
                    : const Expanded(
                        child: Center(child: Text("No Notifications")))
                : const Expanded(
                    child: Center(
                    child: CircularProgressIndicator(),
                  ))
            : Center(
                child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 5),
                child: Column(
                  children: [
                    SvgPicture.asset("assets/images/login.svg"),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      tr("LoginRequired"),
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      tr("LoginRequiredDesc"),
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ))
      ]),
    );
  }
}
