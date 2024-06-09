import 'package:booksportz_supplier_webview_app/commons/colors.dart';
import 'package:booksportz_supplier_webview_app/commons/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../commons/app_firebase_messaging.dart';
import '../../../commons/dimens.dart';
import '../../../commons/routes.dart';
import '../../../commons/ui_utils.dart';
import '../../providers/device_info_notifier.dart';
import '../../providers/user_auth_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final _userAuthProvider = context.read<UserAuthProvider>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _startTimer();
    });
    initRequestPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSet.colorWhite,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.dimen_25, vertical: Dimens.dimen_30),
              child: Center(
                  child: Image.asset(Images.landPageAnimatedLogo,
                      width: Dimens.dimen_200)))
        ],
      ),
    );
  }

  void _startTimer() {
    Provider.of<DeviceInfoNotifier>(context, listen: false).getDeviceInfo();
    Future.delayed(const Duration(seconds: 1))
        .then((value) => {checkLoggedUserInfo()});
  }

  void checkLoggedUserInfo() async {
    await _userAuthProvider.getSelf();
    if (!mounted) {
      return;
    }
    if (_userAuthProvider.isLoggedUser) {
      openPageWithName(context, Routes.home, closeBefore: true);
    } else {
      openPageWithName(context, Routes.signInPage, closeBefore: true);
    }
  }
}
