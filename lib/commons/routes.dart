class Routes {
  static const splash = '/';
  static const onBoardingPage = '/OnBoardingPage';
  static const home = '/home';
  static const appWebPage = '/appWebPage';
  static const signInPage = '/signInPage';
  static const explore = '/explore';
  static const categories = '/categories';
  static const notifications = '/notifications';
  static const profile = '/profile';
  static const notificationScreen = '/notificationScreen';
}

typedef RouteParameters = Map<RouteParameter, dynamic>;

enum RouteParameter {
  id,
  userRole,
  data,
  title,
}
