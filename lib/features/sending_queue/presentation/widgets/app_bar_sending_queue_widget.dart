
import 'package:core/presentation/extensions/color_extension.dart';
import 'package:core/presentation/resources/image_paths.dart';
import 'package:core/presentation/utils/style_utils.dart';
import 'package:core/presentation/views/button/icon_button_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:model/mailbox/select_mode.dart';
import 'package:tmail_ui_user/main/localizations/app_localizations.dart';
import 'package:tmail_ui_user/main/utils/app_utils.dart';

class AppBarSendingQueueWidget extends StatelessWidget {

  final VoidCallback? onBackAction;
  final VoidCallback? onOpenMailboxMenu;
  final SelectMode selectMode;

  const AppBarSendingQueueWidget({
    super.key,
    this.onBackAction,
    this.onOpenMailboxMenu,
    this.selectMode = SelectMode.INACTIVE,
  });

  @override
  Widget build(BuildContext context) {
    final imagePaths = Get.find<ImagePaths>();

    return Container(
      height: 52,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (selectMode == SelectMode.INACTIVE)
            buildIconWeb(
              icon: SvgPicture.asset(
                imagePaths.icMenuMailbox,
                colorFilter: AppColor.colorTextButton.asFilter(),
                fit: BoxFit.fill
              ),
              tooltip: AppLocalizations.of(context).openMailboxMenu,
              onTap: onOpenMailboxMenu
            )
          else
            buildIconWeb(
              icon: SvgPicture.asset(
                AppUtils.isDirectionRTL(context) ? imagePaths.icCollapseFolder : imagePaths.icBack,
                colorFilter: AppColor.colorTextButton.asFilter(),
                fit: BoxFit.fill
              ),
              tooltip: AppLocalizations.of(context).back,
              onTap: onBackAction
            ),
          Expanded(child: Text(
            AppLocalizations.of(context).sendingQueue,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: CommonTextStyle.defaultTextOverFlow,
            softWrap: CommonTextStyle.defaultSoftWrap,
            style: const TextStyle(
              fontSize: 21,
              color: Colors.black,
              fontWeight: FontWeight.bold
            )
          )),
          const SizedBox(width: 50)
        ],
      ),
    );
  }
}