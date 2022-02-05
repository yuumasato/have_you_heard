import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:have_you_heard/constants/colors.dart';

class InGameAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;
  final VoidCallback? onSettingsPressed;
  final VoidCallback? onLeavePressed;
  final Color textColor;
  final FontWeight fontWeight;

  const InGameAppBar({
    this.title = '',
    this.onSettingsPressed,
    this.onLeavePressed,
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
        onPressed: onLeavePressed,
      ),
      actions: [
        IconButton(
          onPressed: onSettingsPressed,
          icon: const Icon(Icons.settings_outlined),
        )
      ],
      automaticallyImplyLeading: false,
    );
  }
}
