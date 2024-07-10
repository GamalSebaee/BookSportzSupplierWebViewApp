import 'package:booksportz_supplier_webview_app/commons/routes.dart';
import 'package:booksportz_supplier_webview_app/commons/ui_utils.dart';
import 'package:booksportz_supplier_webview_app/commons/widgets/view-space.dart';
import 'package:booksportz_supplier_webview_app/presentation/pages/home/widgets/home_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../booksportz_app.dart';
import '../../../commons/app_queued_tasks.dart';
import '../../../commons/colors.dart';
import '../../../commons/constants.dart';
import '../../../commons/images.dart';
import '../../providers/device_info_notifier.dart';
import '../../providers/notifications_provider.dart';
import '../../providers/user_auth_provider.dart';
import '../helper_screens/app_menu_web_page.dart';
import 'widgets/user_info_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const secondaryColor = Color(0xFF5593f8);
  static const primaryColor = Color(0xFF48c9e2);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NotificationsProvider>(context, listen: false)
          .getUnreadNotificationsCount();
      Provider.of<DeviceInfoNotifier>(context, listen: false)
          .submitDeviceToken();
      AppQueuedTasks.handleBackgroundNotificationAction();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationsProvider>(
        builder: (context, notificationsProvider, _) {
      return Scaffold(
        backgroundColor: const Color(0xfffafafa),
        appBar: AppBar(
          title: Text('${AppLocalizations.of(context)?.home}'),
          toolbarHeight: 0,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Row(
                children: [
                  Image.asset(
                    Images.loginLogo,
                    height: 50,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            openPageWithName(
                                context, Routes.notificationScreen);
                            Provider.of<NotificationsProvider>(context,
                                    listen: false)
                                .clearNotificationCounter();
                          },
                          child: Stack(
                            children: [
                              SvgPicture.asset(Images.notifications),
                              Visibility(
                                visible: notificationsProvider
                                        .unreadNotificationsCount >
                                    0,
                                child: PositionedDirectional(
                                  start: 0,
                                  top: 0,
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SpaceHorizontal(space: 10),
                        GestureDetector(
                          onTap: () => showProfileMenu(),
                          child: SvgPicture.asset(Images.personIcon2,
                              colorFilter: const ColorFilter.mode(
                                  ColorSet.primaryColor, BlendMode.srcIn)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverList.list(
                    children: const [
                      /*  Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                          child: Text("Notification Data :${Constants.notificationData}",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500
                          ),),
                        ),*/
                      HomeMenuWidget(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  void showProfileMenu() {
    double screenHeight = MediaQuery.of(context).size.height;
    double cardHeight = (screenHeight * .75);
    showModalBottomSheet(
      /* constraints:  BoxConstraints(
        maxHeight: cardHeight,
      ),*/
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      builder: (context) {
        return SizedBox(
          height: cardHeight,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Icon(Icons.close)),
                ),
              ),
              const UserInfoWidget(),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                color: Colors.black.withOpacity(0.3),
                height: 1,
                width: double.infinity,
              ),
             /* ListTile(
                onTap: () {
                  BookSportzApp.setLocale(context, const Locale("en"));
                },
                leading: SvgPicture.asset(
                  Images.changeLanguage,
                  colorFilter: const ColorFilter.mode(
                      ColorSet.COLOR_333333, BlendMode.srcIn),
                  width: 25,
                  height: 25,
                ),
                title: Text('${AppLocalizations.of(context)?.changeLanguage}'),
              ),*/
              ListTile(
                onTap: (){
                  openAboutUsPage();
                },
                leading: SvgPicture.asset(
                  Images.aboutUs,
                  colorFilter: const ColorFilter.mode(
                      ColorSet.COLOR_333333, BlendMode.srcIn),
                  width: 25,
                  height: 25,
                ),
                title: Text('${AppLocalizations.of(context)?.about}'),
              ),
              ListTile(
                onTap: (){
                  openContactUsPage();
                },
                leading: SvgPicture.asset(
                  Images.contactUsIcon,
                  colorFilter: const ColorFilter.mode(
                      ColorSet.COLOR_333333, BlendMode.srcIn),
                  width: 25,
                  height: 25,
                ),
                title: Text('${AppLocalizations.of(context)?.contactUs}'),
              ),
              ListTile(
                onTap: (){
                  openPrivacyPage();
                },
                leading: SvgPicture.asset(
                  Images.privacyIcon,
                  colorFilter: const ColorFilter.mode(
                      ColorSet.COLOR_333333, BlendMode.srcIn),
                  width: 25,
                  height: 25,
                ),
                title: Text('${AppLocalizations.of(context)?.privacyPolicy}'),
              ),
              ListTile(
                onTap: (){
                  openTermsConditionsPage();
                },
                leading: SvgPicture.asset(
                  Images.tCIcon,
                  colorFilter: const ColorFilter.mode(
                      ColorSet.COLOR_333333, BlendMode.srcIn),
                  width: 25,
                  height: 25,
                ),
                title: Text('${AppLocalizations.of(context)?.termsConditions}'),
              ),
              ListTile(
                onTap: () {
                  Provider.of<DeviceInfoNotifier>(context, listen: false)
                      .deleteDeviceToken();
                  Provider.of<UserAuthProvider>(context, listen: false)
                      .logout();
                  openPageWithName(context, Routes.signInPage,
                      closeBefore: true);
                },
                leading: SvgPicture.asset(
                  Images.menuIconLogout,
                  colorFilter:
                      const ColorFilter.mode(Colors.red, BlendMode.srcIn),
                  width: 25,
                  height: 25,
                ),
                title: Text(
                  '${AppLocalizations.of(context)?.logout}',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void openContactUsPage() {
    openPageWithName(context, Routes.menuWebPage, args: {
      RouteParameter.title: AppLocalizations.of(context)?.contactUs,
      RouteParameter.data: WebViewPagesUrl.contactUs
    });
  }

  void openPrivacyPage() {
    openPageWithName(context, Routes.menuWebPage, args: {
      RouteParameter.title: AppLocalizations.of(context)?.privacyPolicy,
      RouteParameter.data: WebViewPagesUrl.privacyPolicy
    });
  }
  void openAboutUsPage() {
    openPageWithName(context, Routes.menuWebPage, args: {
      RouteParameter.title: AppLocalizations.of(context)?.about,
      RouteParameter.data: WebViewPagesUrl.aboutUs
    });
  }

  void openTermsConditionsPage() {
    openPageWithName(context, Routes.menuWebPage, args: {
      RouteParameter.title: AppLocalizations.of(context)?.termsConditions,
      RouteParameter.data: WebViewPagesUrl.termsConditions
    });
  }

  void openHelpCenterPage() {
    /*Navigator.of(NavigatorHelper.parentContext!).push(CupertinoPageRoute(
        builder: (context) => HelpCenterScreen(
              onBackPressed: () {},
            )));*/
  }
}
