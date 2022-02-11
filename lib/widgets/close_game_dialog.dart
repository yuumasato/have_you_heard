import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:have_you_heard/constants/styles.dart';

import 'app_button.dart';

class CloseGameDialog extends StatelessWidget {
  const CloseGameDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Center(child: Text('leaveTheGame?'.tr,)),
      titlePadding: const EdgeInsets.only(top: 20,bottom: 40,),
      titleTextStyle: HyhTextStyle.heading24Bold,
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actionsPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('cancel'.tr, style: HyhTextStyle.body16BoldYellow,)),
        AppButton(
            text: 'close'.tr,
            onPressed: () =>SystemNavigator.pop(),
        ),
      ],
    );
  }
}