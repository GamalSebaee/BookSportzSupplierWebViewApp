import 'package:booksportz_supplier_webview_app/commons/app_firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../commons/ui_utils.dart';
import '../../../data/beans/pages_stack.dart';
import '../../providers/device_info_notifier.dart';
import '../../providers/user_auth_provider.dart';

class AppWebPage extends StatefulWidget {
  final String? webPageUrl;
  final String? title;

  const AppWebPage({super.key, this.webPageUrl, this.title});

  @override
  State<AppWebPage> createState() => _AppWebPageState();
}

class _AppWebPageState extends State<AppWebPage> {
  bool _isLoading = true;
  late WebViewController _webViewController;

  String? _currentPageUrl;

  late final _deviceInfoNotifier = context.read<DeviceInfoNotifier>();
  late final _userAuthProvider = context.read<UserAuthProvider>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _currentPageUrl =
          widget.webPageUrl ?? 'http://www.stgdashboard.booksportz.com';
      _getWebViewController();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title ?? '')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : WebViewWidget(controller: _webViewController),
    );
  }

  void _getWebViewController() {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..addJavaScriptChannel("JavaScriptChannelName",
          onMessageReceived: (javaScript) {
        printLog("JavaScriptChannelName : ${javaScript.message}}");
      })
      ..setNavigationDelegate(
        NavigationDelegate(
            onProgress: (int progress) {
              // Update loading bar.
            },
            onPageFinished: (String url) {
              printLog("onPageFinished url is : $url");
              _isLoading = false;
              setState(() {});
            },
            onUrlChange: (UrlChange urlChange) {
              printLog("urlChange : ${urlChange.url}");
            },
          onNavigationRequest: (NavigationRequest request){
            printLog("request.url ${request.url}");
            if (request.url.contains("tel:") == true) {
              String phoneNumber=request.url.replaceAll("tel:","");
              if(phoneNumber.isNotEmpty){
                launchPhoneNumber( phone: phoneNumber
                );
              }
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
            onWebResourceError: (WebResourceError error) {},
            ),
      )
      ..loadRequest(Uri.parse(getPageUrlWithQueryParameters(_currentPageUrl ??
          'http://www.stgdashboard.booksportz.com') /*_currentPageUrl ?? ''*/));
  }

  String getPageUrlWithQueryParameters(String pageStrUrl) {
    var pageUrl = Uri.parse(pageStrUrl);
    /*var urlWithQueryParams =
        "$pageStrUrl${(pageUrl.hasQuery) ? '&' : '?'}deviceId=${_deviceInfoNotifier.deviceId}&fcmToken=${_deviceInfoNotifier.deviceFCMToken}";
    */
    var urlWithQueryParams =
        "$pageStrUrl${(pageUrl.hasQuery) ? '&' : '?'}userToken=${_userAuthProvider.userToken}&deviceType=${_deviceInfoNotifier.deviceType}";
    /*  var urlWithQueryParams =
        "$pageStrUrl${(pageUrl.hasQuery) ? '&' : '?'}userToken=${_userAuthProvider.userToken}";*/

    printLog("pageUrl $urlWithQueryParams");
    return urlWithQueryParams;
  }
}
