import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../commons/app_firebase_messaging.dart';
import '../../../commons/ui_utils.dart';

class AppMenuWebPage extends StatefulWidget {
  final String? pageUrl;
  final String? pageTitle;

  const AppMenuWebPage({super.key, this.pageUrl,this.pageTitle});

  @override
  State<AppMenuWebPage> createState() => _AppMenuWebPageState();
}

class _AppMenuWebPageState extends State<AppMenuWebPage> {
  WebViewController? controller;
  bool isLoading=true;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..enableZoom(true)
      ..setNavigationDelegate(
        NavigationDelegate(
            onProgress: (int progress) {
              // Update loading bar.
            },
            onPageStarted: (String url) {
              printLog("inside onPageStarted $url");
            },
            onPageFinished: (String url) {
              if(!mounted){
                return;
              }
              setState(() {
                isLoading=false;
              });
              printLog("inside onPageFinished $url");
            },
            onWebResourceError: (WebResourceError error) {
              printLog(
                  "inside onWebResourceError ${error.description}");
            }
        ),
      )
      ..loadRequest(Uri.parse(widget.pageUrl ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text(widget.pageTitle ?? '')),
        body: Stack(
          children: [
            isLoading
                ? customLoadingView() : const SizedBox(
              width: 0,
              height: 0,
            ),
            Column(
              children: [
                Expanded(
                  child: (controller != null) ?Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: WebViewWidget(
                        controller: controller!,
                ),
                  ) : const SizedBox(
                    width: 0,
                    height: 0,
                  )),
              ],
            ),
          ],
        ));
  }
}
