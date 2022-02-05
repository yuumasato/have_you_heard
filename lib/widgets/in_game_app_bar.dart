import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:have_you_heard/constants/colors.dart';
import 'package:have_you_heard/ui/lobby.dart';
import 'package:have_you_heard/ui/settings.dart';

class InGameAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;
  final Color textColor;
  final FontWeight fontWeight;

  const InGameAppBar({
    this.title = '',
    this.textColor = kGrayScaleLight,
    this.fontWeight = FontWeight.w400,
    Key? key,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
            fontSize: 16, fontWeight: fontWeight, color: textColor),
      ),
      leading: IconButton(
        icon: const Image(
          image: Svg("assets/images/icon_leave.svg", size: Size(24, 24)),
        ),
        onPressed: (){Get.toNamed(LobbyScreen.route);}
      ),
      actions: [
        IconButton(
          onPressed: () {Get.toNamed(SettingsScreen.route);},
          icon: const Icon(Icons.settings_outlined),
        )
      ],
      automaticallyImplyLeading: false,
    );
  }
}
