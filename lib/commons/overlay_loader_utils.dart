import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void showOverlayLoader(
  BuildContext context,
) =>
    EasyLoading.show(
      maskType: EasyLoadingMaskType.black,
      dismissOnTap: false,
        indicator: const SizedBox(
          width: 70,
          height: 70,
          child: CircularProgressIndicator(
            color: Color(0xffd4ae6c),
            strokeWidth: 7,
          ),
        )
    );

Future<void> dismissOverlayLoader() => EasyLoading.dismiss();
