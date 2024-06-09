import 'package:booksportz_supplier_webview_app/commons/app_firebase_messaging.dart';
import 'package:booksportz_supplier_webview_app/commons/widgets/view-space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../commons/constants.dart';
import '../../../../commons/images.dart';
import '../../../providers/user_auth_provider.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserAuthProvider>(builder: (context, userAuthProvider, _) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UserImageWidget(imagePath: userAuthProvider.userModel?.serviceProviderDetails?.company?.logo ?? ''
            , userToken: userAuthProvider.userToken ?? '',),
          const SpaceVertical(
            space: 10,
          ),
          Text(
            '${userAuthProvider.userModel?.name}',
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          const SpaceVertical(
            space: 5,
          ),
          Text(
            '${userAuthProvider.userModel?.email}',
            style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
          ),
        ],
      );
    });
  }
}

class UserImageWidget extends StatelessWidget {
  final String imagePath;
  final String userToken;
  final double? imageHeight;
  final double? imageWidth;
  final double? borderRadius;
  final String? defaultImage;
  final String? placeholder;
  final BoxFit? boxFit;

  const UserImageWidget(
      {super.key,
      required this.imagePath,
      required this.userToken,
      this.boxFit,
      this.defaultImage,
      this.imageHeight = 75,
      this.imageWidth = 75,
      this.borderRadius = 40,
      this.placeholder});

  @override
  Widget build(BuildContext context) {
    var fullImagePath="${Constants.dashboardBaseUrl}/file/company-logo-36";
    printLog("fullImagePath $fullImagePath - userToken: $userToken");
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
          border: Border.all(
            color: Colors.grey.withOpacity(.3),
          )
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        child: Image.network(
          fullImagePath,
          headers: {
            "Authorization": "Bearer $userToken"
          },
          fit: boxFit ?? BoxFit.cover,
          filterQuality: FilterQuality.medium,
          errorBuilder: (_, ee, __)  {
            printLog("Error loading image $ee");
            return Image.asset(
              defaultImage ?? Images.emptyImage,
              fit: boxFit ?? BoxFit.cover,
              height: imageHeight,
              width: imageWidth,
            );
          },
          height: imageHeight,
          width: imageWidth,
        ),
      ),
    );
  }
}
