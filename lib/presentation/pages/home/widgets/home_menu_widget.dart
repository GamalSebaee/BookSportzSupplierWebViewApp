import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../providers/home_menu_notifier.dart';
import 'menu_card.dart';

class HomeMenuWidget extends StatefulWidget {
  const HomeMenuWidget({super.key});

  @override
  State<HomeMenuWidget> createState() => _HomeMenuWidgetState();
}

class _HomeMenuWidgetState extends State<HomeMenuWidget> {
  @override
  Widget build(BuildContext context) {
    var fWidth = MediaQuery.of(context).size.width;
    var itemWidth = (fWidth / 2) - 10;
    return Consumer<HomeMenuNotifier>(
      builder: (context, homeMenuNotifier, _) {
        return Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            for (int index = 0;
                index < (homeMenuNotifier.menu.length + 1);
                index++)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  width: itemWidth,
                  child: (index == homeMenuNotifier.menu.length)
                      ? Container()
                      : MenuCardWidget(
                          homeMenuItem: homeMenuNotifier.menu[index],
                        ),
                ),
              ),
          ],
        );
      },
    );
  }
}
