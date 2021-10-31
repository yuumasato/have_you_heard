import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:have_you_heard/constants/colors.dart';
import 'package:have_you_heard/controller/game_controller.dart';
import 'package:have_you_heard/models/player.dart';
import 'package:have_you_heard/widgets/chat_balloon.dart';
import 'package:have_you_heard/widgets/game_exit_dialog.dart';

class VoteAnswerScreen extends StatefulWidget {
  const VoteAnswerScreen({Key? key}) : super(key: key);

  static const routeName = '/input-answer';
  static const route = '/input-answer';

  @override
  _VoteAnswerScreenState createState() => _VoteAnswerScreenState();
}

class _VoteAnswerScreenState extends State<VoteAnswerScreen> {
  final GameController gc = Get.find();

  String votedAnswer = 'No voted answer';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final appBarHeight = AppBar().preferredSize.height;

    return GameExitDialog(
      onElevatedPressed: () => Navigator.of(context).pop(),
      onPlainPressed: () => gc.exitGame(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  LinearProgressIndicator(
                    minHeight: appBarHeight * 0.73,
                    color: kPlayer_3,
                    backgroundColor: kGrayScaleMediumDark,
                  ),
                  Text('chooseAnswer'.tr),
                ],
              ),
              //TODO: Verificar para diferentes telas
              SizedBox(
                width: screenWidth * 0.8,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: ChatBalloon(
                    balloonHeader: Text(
                        'haveYouHeard...'.tr,
                        style: TextStyle(height: 1.5, fontSize: 16, fontWeight: FontWeight.bold)),
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
              ),
              Container(
                padding: EdgeInsets.only(
                    left: screenWidth * 0.1,
                    right: screenWidth * 0.1,
                    bottom: appBarHeight * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ...buildAnswerButtons(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildAnswerButtons() {
    List<Widget> answerButtons = <Widget>[];

    for (var index = 0; index < 6; index++) {
      Player player = Player(name: 'Jogador ${index + 1}');
      bool visible = false;
      if (index < gc.game.nPlayers.value) {
        player = gc.game.playerList[index];
        visible = true;
      }

      answerButtons.add(Opacity(
        opacity: index == 0 ? 0.40 : 1.0,
        child: Visibility(
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: visible,
          child: Padding(
            padding:
            EdgeInsets.symmetric(vertical: AppBar().preferredSize.height * 0.08),
            child: SizedBox(
              height: AppBar().preferredSize.height * 0.8,
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        width: 2.0,
                        color: kGrayScaleDark,
                        style: BorderStyle.solid,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                  onPressed: index == 0 ? null : () {
                    votedAnswer = player.id;
                    sendVote();
                  },
                  child: Align(
                    child: Text(
                      player.answer,
                      //TODO: Adicionar fonte Nunito
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                  )),
            ),
          ),
        ),
      ));
    }
    return answerButtons;
  }

  void sendVote() {
    gc.voteAnswer(votedAnswer);
  }
}
