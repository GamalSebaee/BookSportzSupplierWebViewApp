import 'package:flutter/cupertino.dart';

import '../../webpage/app_web_page.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppWebPage(
      webPageUrl: 'http://www.stgdashboard.booksportz.com/reviews',
    );
  }
}
