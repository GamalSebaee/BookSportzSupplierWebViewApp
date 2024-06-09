
import 'package:flutter/material.dart';

import '../../../../commons/routes.dart';
import '../pages/explore_page.dart';
import '../pages/notifications_page.dart';
import '../pages/profile_page.dart';
import '../pages/reservations_page.dart';

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;
  final Function? onMainBackPressed;
  final Function? openCustomTabCallBack;
  const TabNavigator({Key? key, required this.navigatorKey, required this.tabItem, this.onMainBackPressed,this.openCustomTabCallBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = const ExplorePage();
    if (tabItem == Routes.explore) {
      child = const ExplorePage(
       /* onProfileImagePressed: (){
          if(openCustomTabCallBack != null){
            openCustomTabCallBack!(Routes.profile,3);
          }
        },*/
      );
    } else if (tabItem == Routes.categories) {
      child = /*Categories*/const ReservationsPage(/*onBack: () {
        onMainBackPressed!(Routes.explore);
      },
        isFromHome: true,*/);
    } else if (tabItem == Routes.notifications) {
      child = const NotificationsPage(/*onBack: (){
        onMainBackPressed!(Routes.explore);
      },*/);
    } else if (tabItem == Routes.profile) {
      child = const ProfilePage(/*onBack: (){
        onMainBackPressed!(Routes.explore);
      },*/);
    }
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSetting) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
