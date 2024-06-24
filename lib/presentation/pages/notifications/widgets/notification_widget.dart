import 'package:booksportz_supplier_webview_app/commons/colors.dart';
import 'package:booksportz_supplier_webview_app/commons/widgets/view-space.dart';
import 'package:flutter/material.dart';
import '../../../../commons/constants.dart';
import '../../../../commons/routes.dart';
import '../../../../commons/ui_utils.dart';
import '../../../../data/beans/notification.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../data/repositories/notifications_repo.dart';

class NotificationWidget extends StatefulWidget {
  final Notifications? notifications;
  final int? index;

  const NotificationWidget({super.key, this.notifications, this.index});

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        makeNotificationSeen();

        if ((widget.notifications?.redirect ?? '').trim().isEmpty) {
          return;
        }
        openPageWithName(context, Routes.appWebPage, args: {
          RouteParameter.data:
              getPageUrl(pageUrl: widget.notifications?.redirect ?? ''),
          RouteParameter.title:
              '${AppLocalizations.of(context)?.reservationDetails}'
        });
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          decoration: BoxDecoration(
              color: (widget.notifications?.seen == true)
                  ? Colors.white
                  : Colors.grey.withOpacity(.4),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "#${widget.notifications?.id ?? ''}",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SpaceVertical(
                  space: 5,
                ),
                Text(widget.notifications?.message ?? '',
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 14)),
                const SpaceVertical(
                  space: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.notifications?.type ?? '',
                      style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                          color: ColorSet.primaryColor),
                    ),
                    Text(
                      widget.notifications?.createdAt ?? '',
                      style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                          color: ColorSet.darkishPink),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void makeNotificationSeen() {
    if (widget.notifications?.seen == false) {
      makeNotificationSeenRequest(notificationId: widget.notifications?.id);

      setState(() {
        widget.notifications?.seen = true;
      });
    }
  }
}
