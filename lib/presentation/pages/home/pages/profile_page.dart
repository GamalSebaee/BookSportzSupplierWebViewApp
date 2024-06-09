import 'package:flutter/cupertino.dart';

import '../../webpage/app_web_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppWebPage(
      webPageUrl: 'http://www.stgdashboard.booksportz.com/settings',
    );
  }
}
