import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:have_you_heard/constants/colors.dart';
import 'package:have_you_heard/controller/game_controller.dart';
import 'package:have_you_heard/ui/waiting_screen.dart';
import 'package:have_you_heard/widgets/app_button.dart';
import 'package:have_you_heard/widgets/app_text_field.dart';
import 'package:have_you_heard/widgets/chat_balloon.dart';
import 'package:have_you_heard/widgets/game_exit_dialog.dart';
import 'package:have_you_heard/widgets/in_game_app_bar.dart';

class ShowNewsScreen extends StatefulWidget {
  const ShowNewsScreen({Key? key}) : super(key: key);

  static const routeName = '/show-news';
  static const route = '/show-news';

  @override
  _ShowNewsScreenState createState() => _ShowNewsScreenState();
}

class _ShowNewsScreenState extends State<ShowNewsScreen>
    with SingleTickerProviderStateMixin {
  // The player has 12 seconds to answer the news
  final Duration _screenDuration = const Duration(seconds: 15);
  late final Timer _timer;

  late final AnimationController _controller = AnimationController(
    duration: _screenDuration,
    vsync: this,
  )..forward();

  late final Animation<double> _progressBar = Tween<double>(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear)
  );

  final textController = TextEditingController();
  final GameController gc = Get.find();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });

    _timer = Timer(_screenDuration, sendAnswer);
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    textController.dispose();
    super.dispose();
  }

  sendAnswer() {
    _timer.cancel();
    gc.sendAnswer(textController.text);
    var parameters = <String, String>{"titleFlag": "true", "bannerText": "Esperando respostas"};
    Get.offNamed(WaitingScreen.route, parameters: parameters);
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    final appBarHeight = AppBar().preferredSize.height;
    return GameExitDialog (
      onElevatedPressed: () => Navigator.of(context).pop(),
      onPlainPressed: () => gc.exitGame(),
      child: Scaffold(
        appBar: InGameAppBar(
            title: 'showRound'.trParams({'round': '${gc.game.roundIndex + 1}'}), //'Rodada ${gc.game.roundIndex + 1}/3',
            fontWeight: FontWeight.w700,
            textColor: kYellow,
            onLeavePressed: () => ExitGameAlert(context, () => Navigator.of(context).pop(), () => gc.exitGame())
        ),
        body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    LinearProgressIndicator(
                      minHeight: AppBar().preferredSize.height * 0.66,
                      value: _progressBar.value,
                      color: kPlayer_3,
                      backgroundColor: kGrayScaleMediumDark,
                    ),
                    Text('writeYourAnswer'.tr)
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: ChatBalloon(
                    balloonHeader: Text('haveYouHeard...'.tr),
                    balloonText: RichText(
                        text: TextSpan(
                            text: gc.game.getBlankHeadline(),
                            style: TextStyle(
                                fontSize: 16.0,
                                height: 1.5
                            )
                        )
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: appBarHeight * 0.8,
                        child: AppTextField(
                          textEditingController: textController,
                          autofocus: true,
                          labelText: 'answer'.tr,
                          inputFormatters:[LengthLimitingTextInputFormatter(25)],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: appBarHeight * 0.26),
                        child: AppButton(
                            onPressed: sendAnswer,
                            text: 'send'.tr),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
