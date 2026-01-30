import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/constants/asset_constants.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';

class ToastUtils {
  ToastUtils._();

  static void showToast(
    final BuildContext context,
    final String message, {
    required final bool isSuccess,
  }) {
    final FToast fToast = FToast()..init(context);

    final Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: context.appColors.surfaceL1,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        spacing: 10,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (isSuccess)
            Image.asset(AppAssets.appLogoRoundedCorners, width: 24, height: 24)
          else
            Icon(
              Icons.error_outline,
              color: context.appColors.semanticsIconError,
            ),
          Flexible(
            child: Text(
              message,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
              style: AppTextStyles.interW400S14Lh21Ls0.copyWith(
                color: context.appColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(milliseconds: 3000),
    );
  }
}
