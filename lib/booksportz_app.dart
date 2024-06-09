import 'package:booksportz_supplier_webview_app/presentation/pages/login_page/signin_page.dart';
import 'package:booksportz_supplier_webview_app/presentation/pages/webpage/app_web_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'commons/app_firebase_messaging.dart';
import 'commons/colors.dart';
import 'commons/constants.dart';
import 'commons/fonts.dart';
import 'commons/localizations_utils.dart';
import 'commons/routes.dart';
import 'commons/storage_handler.dart';
import 'commons/utils.dart';
import 'presentation/pages/home/home_page.dart';
import 'presentation/pages/notifications/notification_screen.dart';
import 'presentation/pages/splash/splash.dart';

class BookSportzApp extends StatefulWidget {
  static const defaultLocale = Locale(
    Constants.englishLanguageCode,
  );
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static Locale get systemLocale =>
      WidgetsBinding.instance.platformDispatcher.locale;

  const BookSportzApp({
    super.key,
  });

  @override
  State<BookSportzApp> createState() => _BookSportzAppState();

  static void setLocale(
    BuildContext context,
    Locale locale,
  ) {
    final appState = context.findAncestorStateOfType<_BookSportzAppState>();
    appState?.locale = locale;
  }
}

class _BookSportzAppState extends State<BookSportzApp> {
  Locale? _locale;
  String? _fontFamily;

  set locale(Locale locale) {
    StorageHandler.setLocale(locale);

    Intl.defaultLocale = locale.languageCode;

    setState(() {
      _locale = locale;
      _updateFontFamily(locale);
    });
  }

  @override
  void initState() {
    super.initState();
    initFirebaseMessaging();
    _loadCurrentLocale();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      builder: (context, child) {
        LocalizationsUtils.init(context);

        return EasyLoading.init()(
          context,
          child,
        );
      },
      navigatorKey: BookSportzApp.navigatorKey,
      initialRoute: Routes.splash,
      onGenerateRoute: (settings) {
        final parameters = tryCast<RouteParameters>(
          settings.arguments,
        );
        switch (settings.name) {
          case Routes.splash:
            return MaterialPageRoute(
              builder: (context) => const SplashPage(),
            );
          case Routes.signInPage:
            return MaterialPageRoute(
              builder: (context) => const SignInPage(),
            );
          case Routes.home:
            return MaterialPageRoute(
              builder: (context) => const HomePage(),
            );
          case Routes.notificationScreen:
            return MaterialPageRoute(
              builder: (context) => const NotificationScreen(),
            );
          case Routes.appWebPage:
            return MaterialPageRoute(
              builder: (context) => AppWebPage(
                webPageUrl: parameters?[RouteParameter.data],
                title: parameters?[RouteParameter.title],
              ),
            );

          default:
            assert(false, 'Need to implement ${settings.name}');
            return null;
        }
      },
      title: Constants.appName,
      theme: ThemeData(
        useMaterial3: false,
        colorSchemeSeed: ColorSet.primaryColor,
        fontFamily: _fontFamily,
      ),
      locale: _locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
    );
  }

  void _loadCurrentLocale() => StorageHandler.loadCurrentLocale().then(
        (locale) {
          locale ??=
              AppLocalizations.delegate.isSupported(BookSportzApp.systemLocale)
                  ? BookSportzApp.systemLocale
                  : BookSportzApp.defaultLocale;
          this.locale = locale;
        },
      );

  void _updateFontFamily(Locale locale) {
    switch (locale.languageCode) {
      case Constants.englishLanguageCode:
        _fontFamily = FontFamily.englishFont;
        break;
      case Constants.arabicLanguageCode:
        _fontFamily = FontFamily.arabicFont;
        break;
    }
  }
}
