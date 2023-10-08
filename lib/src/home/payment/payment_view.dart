import 'dart:async';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sama_offices/app.dart';
import 'package:sama_offices/core/values/colors.dart';

import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/cash/storage.helper.dart';
import '../../../core/utils/helper_manager.dart';
import '../home_core.dart';
import 'checkout_view.dart';

class WebViewOfferPayment extends StatefulWidget {
  const WebViewOfferPayment({super.key});

  @override
  WebViewOfferPaymentState createState() => WebViewOfferPaymentState();
}

class WebViewOfferPaymentState extends State<WebViewOfferPayment> with StorageHelper {
  final GlobalKey webViewKey = GlobalKey();


  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  String url = "";
  double progress = 0;
  static String openUrl = "";
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    setState(() {
      url = openUrl;
    });
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: samaOfficeColor,
        /* set Status bar color in Android devices. */
        statusBarIconBrightness: Brightness.dark,
        /* set Status bar icons color in Android devices.*/
        statusBarBrightness: Brightness.dark));



    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: samaOfficeColor,
            actions: [
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios_sharp),
                onPressed: () {
                  Navigator.pop(context);
                },
              ), // add more IconButton
            ],
            title: Text("Payment".tr()),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              InAppWebView(
                key: webViewKey,
                initialUrlRequest: URLRequest(url: Uri.parse(url)),
                initialOptions: options,
                pullToRefreshController: pullToRefreshController,
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
                onLoadStart: (controller, url) {
                  setState(() {
                    this.url = url.toString();
                    urlController.text = this.url;
                  });
                },

                androidOnPermissionRequest:
                    (controller, origin, resources) async {
                  return PermissionRequestResponse(
                      resources: resources,
                      action: PermissionRequestResponseAction.GRANT);
                },
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  var uri = navigationAction.request.url!;

                  if (![
                    "http",
                    "https",
                    "file",
                    "chrome",
                    "data",
                    "javascript",
                    "about"
                  ].contains(uri.scheme)) {
                    if (await canLaunch(url)) {
                      // Launch the App
                      await launch(
                        url,
                      );
                      // and cancel the request
                      return NavigationActionPolicy.CANCEL;
                    }
                  }

                  return NavigationActionPolicy.ALLOW;
                },
                onLoadStop: (controller, url) async {
                  pullToRefreshController.endRefreshing();
                  setState(() {
                    this.url = url.toString();
                    urlController.text = this.url;
                  });
                  readResponse();
                },
                onLoadError: (controller, url, code, message) {
                  pullToRefreshController.endRefreshing();
                },
                onProgressChanged: (controller, progress) {
                  if (progress == 00) {
                    pullToRefreshController.endRefreshing();
                  }
                  setState(() {
                    this.progress = progress / 100;
                    urlController.text = this.url;
                  });
                },
                onUpdateVisitedHistory: (controller, url, androidIsReload) {
                  setState(() {
                    this.url = url.toString();
                    urlController.text = this.url;
                  });
                },
                onConsoleMessage: (controller, consoleMessage) {
                  debugPrint(consoleMessage.toString());
                  if (consoleMessage.message == "failed") {
                    toastApp("Some error occurred please try again", context);
                    Navigator.pop(context);
                  } else if (consoleMessage.message == "success") {

                  }
                },
              ),
              (progress < 1.0)
                  ? const Center(
                child: CircularProgressIndicator(
                  color: samaOfficeColor,
                ),
              )
                  : const SizedBox.shrink(),
            ],
          )),
    );
  }

  void readResponse() async
  {
    setState(() {
      webViewController?.evaluateJavascript(
          source: "document.documentElement.innerHTML").then((value) async {
        print(value);

        if (value.contains('{"status":200,"msg":')) {

          SamaOfficesApp.navKey.currentState!.pushReplacement(
              MaterialPageRoute(
                  builder: (context) => const CheckoutView()));


        }
        else if (value.contains('{"status":401,"msg":')) {
          toastApp("Some error occurred please try again", context);
          Navigator.pop(context);
        }
      });
    });
  }
}
