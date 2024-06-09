import 'package:booksportz_supplier_webview_app/commons/app_firebase_messaging.dart';
import 'package:booksportz_supplier_webview_app/commons/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../commons/colors.dart';
import '../../../../commons/constants.dart';
import '../../../../commons/routes.dart';
import '../../../../commons/widgets/view-space.dart';
import '../../../../data/beans/home_menu_item.dart';

class MenuCardWidget extends StatelessWidget {
  final HomeMenuItem? homeMenuItem;
  final Color? color;

  const MenuCardWidget({super.key, this.homeMenuItem, this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        printLog(
            "Page Url ${getPageUrl(pageUrl: homeMenuItem?.pageUrl ?? '')}");
        openPageWithName(context, Routes.appWebPage, args: {
          RouteParameter.data: getPageUrl(pageUrl: homeMenuItem?.pageUrl ?? ''),
          RouteParameter.title: homeMenuItem?.title
        });
      },
      child: Card(
        elevation: 5,
        color: color,
        margin: const EdgeInsets.all(4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(homeMenuItem?.image ?? '',
              colorFilter: const ColorFilter.mode(ColorSet.primaryColor, BlendMode.srcIn),
              width: 30,
              height: 30,),
              const SpaceVertical(
                space: 10,
              ),
              Text(
                homeMenuItem?.title ?? '',
                style: const TextStyle(color: ColorSet.primaryColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
