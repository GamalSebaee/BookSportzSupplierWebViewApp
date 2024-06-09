enum BackendEnv { live, dev }

class Constants {
  static const String appName = "BookSportz Supplier";
  static const String englishLanguageCode = "en";
  static const String arabicLanguageCode = "ar";

  static const BackendEnv _currentBackendEnv = BackendEnv.live;
  static String base = (_currentBackendEnv == BackendEnv.live)
      ? "https://www.backend.booksportz.com/"
      : "http://www.stgbackend.booksportz.com/";

  static String baseUrl = "${base}graphql";
  static String dashboardBaseUrl = (_currentBackendEnv == BackendEnv.live)
          ? "https://www.dashboard.booksportz.com"
          : "http://www.stgdashboard.booksportz.com";
}

String getPageUrl({required String pageUrl}) {
  if(!pageUrl.startsWith("/")){
    pageUrl='/$pageUrl';
  }
  return "${Constants.dashboardBaseUrl}$pageUrl";
}
