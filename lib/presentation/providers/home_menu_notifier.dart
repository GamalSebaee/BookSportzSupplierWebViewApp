import 'package:flutter/cupertino.dart';

import '../../commons/images.dart';
import '../../data/beans/home_menu_item.dart';

class HomeMenuNotifier extends ChangeNotifier {
  List<HomeMenuItem> get menu => [
      /*  HomeMenuItem(
            title: "Dashboard",
            pageUrl: "/dashboard",
            image: Images.menuIconDashboard),*/
        HomeMenuItem(
            title: "Reservations",
            pageUrl: "/reservations",
            image: Images.menuIconReservations),
       /* HomeMenuItem(
            title: "Catalog",
            pageUrl: "/catalog",
            image: Images.menuIconCatalog),*/
        HomeMenuItem(
            title: "Items Control",
            pageUrl: "/itemsControl",
            image: Images.menuIconCatalog),
        HomeMenuItem(
            title: "Reviews",
            pageUrl: "/reviews",
            image: Images.menuIconReviews),
     /*   HomeMenuItem(
            title: "Reports",
            pageUrl: "/reports",
            image: Images.menuIconReports),
        HomeMenuItem(
            title: "Settings",
            pageUrl: "/settings",
            image: Images.menuIconSetting),*/
        HomeMenuItem(
            title: "Help Center",
            pageUrl: "/help-center",
            image: Images.menuIconHelpCenter),
        HomeMenuItem(
            title: "Loyality Program",
            pageUrl: "/loyality",
            image: Images.menuIconLoyality),
      ];
}
