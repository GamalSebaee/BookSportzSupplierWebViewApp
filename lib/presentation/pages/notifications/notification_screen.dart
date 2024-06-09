
import 'package:booksportz_supplier_webview_app/data/beans/notification.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import '../../providers/notifications_provider.dart';
import 'widgets/notification_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class NotificationScreen extends StatefulWidget {

 const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  static const _pageSize = 10;

  late final _notificationsProvider = context.read<NotificationsProvider>();

  final PagingController<int, Notifications> _pagingController =
  PagingController(firstPageKey: 0);

  int loadedCount=0;

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${AppLocalizations.of(context)?.notifications}'),
      ),
      backgroundColor: const Color(0xfffafafa),
        /*backgroundColor: Colors.white ,

      appBar:createDefaultAppBar2(
        backAction: () {
          widget.onBack();
        },
        title: AppLocalizations.of(context)!.notifications,
      ),*/
      body:  PagedListView<int, Notifications>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Notifications>(
          itemBuilder: (context, item, index) => NotificationWidget(
            notifications: item,
            index: index,
          ),
        ),
      ),
    );
  }


  void _fetchPage(int pageKey) async{
    try {
      var notificationsResponse = await _notificationsProvider.getNotificationsData(
        offset: pageKey,
        limit:  _pageSize
      );
      var newItems=notificationsResponse?.notifications ?? [];
      loadedCount+=newItems.length;
      final isLastPage = loadedCount >= (notificationsResponse?.count ?? 0);
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
