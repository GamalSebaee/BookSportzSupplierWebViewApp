
import 'package:booksportz_supplier_webview_app/commons/colors.dart';
import 'package:booksportz_supplier_webview_app/commons/images.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../presentation/pages/splash/splash.dart';
import 'app_firebase_messaging.dart';
import 'dimens.dart';
void dismissKeyboard(
    BuildContext context,
    ) =>
    FocusScope.of(context).unfocus();

Future<dynamic> openPageWithName(
    BuildContext context,
    String pageName, {
      Object? args,
      bool closeBefore = false,
      bool closeAllBefore = false,
    }) {
  dismissKeyboard(context);
  if (closeAllBefore) {
    return Navigator.pushNamedAndRemoveUntil(
      context,
      pageName,
          (Route<dynamic> route) => (route is SplashPage),
      arguments: args,
    );
  } else if (closeBefore) {
    return Navigator.of(context).pushReplacementNamed(
      pageName,
      arguments: args,
    );
  } else {
    return Navigator.of(context).pushNamed(
      pageName,
      arguments: args,
    );
  }
}

Future<bool> openUrl(
    String url,
    ) async {
  final uri = Uri.tryParse(
    url,
  );

  if (uri == null) return false;

  return await launchUrl(
    uri,
  );
}

Future<void> launchPhoneNumber({required String phone}) async {
  if (!await launchUrl(Uri.parse("tel:$phone"))) {
    printLog("Couldn't load url $phone");
  }
}

Widget addVerticalSpace(double space){
  return SizedBox(
    width: 1,
    height: space,
  );
}
Widget addHorizontalSpace(double space){
  return SizedBox(
    width: space,
    height: 1,
  );
}

BoxDecoration containerBtnBlueBg(bool isEnabled) {
  return isEnabled
      ? BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(Dimens.dimen_15)),
      border: Border.all(color: ColorSet.COLOR_3D98FF, width: Dimens.dimen_1),
      color: ColorSet.COLOR_3D98FF)
      : BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(Dimens.dimen_15)),
      border: Border.all(color: ColorSet.COLOR_E0E0E0, width: Dimens.dimen_1),
      color: ColorSet.COLOR_E0E0E0);
}

Widget customLoadingView({double? customHeight, double? customWidth}) {
  return Center(
    child: Image.asset(
      Images.loading,
      width: customWidth ?? Dimens.dimen_160,
      height: customHeight ?? Dimens.dimen_70,
    ),
  );
}


Widget createSignupInputWidget(
    {required String hintText,
      required TextEditingController inputController,
      Widget? suffixWidgetIcon,
      bool? enableInput,
      Key? key,
      double? horizontalPadding,
      TextInputType? textInputType,
      bool? isPassword,
      bool? hasError,
      Container? errorWidget,
      String? titleText,
      TextStyle? hintTextStyle,
      TextStyle? titleTextStyle,
      Function(String)? onChange}) {
  if (textInputType == null) {
    textInputType = TextInputType.text;
  }

  if (horizontalPadding == null) {
    horizontalPadding = Dimens.dimen_25;
  }
  if (hasError == null) {
    hasError = false;
  }
  if (titleText == null) {
    titleText = hintText;
  }
  if (hintTextStyle == null) {
  /*  hintTextStyle = customTextStyle(
        color: AppColors.COLOR_E0E0E0,
        fontFamily: AppFonts.fontSfProRegular,
        fontSize: dimen_12);*/
  }
  if (titleTextStyle == null) {
   /* titleTextStyle = customTextStyle(
        fontFamily: AppFonts.fontSfProMedium,
        fontSize: dimen_12,
        color: AppColors.COLOR_828282);*/
  }
  bool isNotEmpty = false;
  if (inputController.text.length > 0) {
    isNotEmpty = true;
  }

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(titleText, style: titleTextStyle),
        addVerticalSpace(Dimens.dimen_8),
        Container(
            width: double.infinity,
            height: Dimens.dimen_48,
            child: TextField(
                key: key,
                obscureText: isPassword ?? false,
                enabled: enableInput ?? true,
                controller: inputController,
               /* style: customTextStyle(
                    color: AppColors.COLOR_BLACK,
                    fontFamily: AppFonts.fontSfProRegular,
                    fontSize: dimen_14),*/
                onChanged: onChange,
                keyboardType: textInputType,
                decoration: InputDecoration(
                  errorText: hasError ? "" : null,
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: ColorSet.red, width: Dimens.dimen_1),
                    borderRadius: BorderRadius.circular(Dimens.dimen_15),
                  ),
                  errorStyle: TextStyle(
                    height: 0,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: isNotEmpty
                            ? ColorSet.COLOR_3D98FF
                            : ColorSet.COLOR_CBCBD4,
                        width: Dimens.dimen_1),
                    borderRadius: BorderRadius.circular(Dimens.dimen_15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: ColorSet.COLOR_3D98FF, width: Dimens.dimen_1),
                    borderRadius: BorderRadius.circular(Dimens.dimen_15),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: ColorSet.red, width: Dimens.dimen_1),
                    borderRadius: BorderRadius.circular(Dimens.dimen_15),
                  ),
                  hintText: hintText,
                  suffixIcon: suffixWidgetIcon,
                  hintStyle: hintTextStyle,
                ))),
        errorWidget ??
            Container(
              width:Dimens.dimen_0,
              height: Dimens.dimen_0,
            )
      ],
    ),
  );
}

void showAppMessage(String? message) async {
  Fluttertoast.showToast(
      msg: message ?? "",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0);
  /*await Flushbar(
    message: '$message',
    duration: Duration(seconds: 2),
  ).show(context);*/
}
