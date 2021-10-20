import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:have_you_heard/constants/colors.dart';
import 'package:have_you_heard/controller/game_controller.dart';
import 'package:have_you_heard/widgets/app_button.dart';
import 'package:have_you_heard/widgets/chat_balloon.dart';
import 'package:have_you_heard/widgets/game_exit_dialog.dart';

class ShowNewsScreen extends StatefulWidget {
  const ShowNewsScreen({Key? key}) : super(key: key);

  static const routeName = '/show-news';
  static const route = '/show-news';

  @override
  _ShowNewsScreenState createState() => _ShowNewsScreenState();
}

class _ShowNewsScreenState extends State<ShowNewsScreen> {
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    myController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    final appBarHeight = AppBar().preferredSize.height;
    final GameController gc = Get.find();
    return GameExitDialog (
      onElevatedPressed: () => Navigator.of(context).pop(),
      onPlainPressed: () => gc.exitGame(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Rodada ${gc.game.roundIndex + 1}/3',
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: kYellow),
          ),
          automaticallyImplyLeading: false,
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
                      color: kPlayer_3,
                      backgroundColor: kGrayScaleMediumDark,
                    ),
                    Text("Escreva sua resposta")
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: ChatBalloon(
                    balloonHeader: const Text('Você ouviu que...'),
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
                        child: TextField(
                          controller: myController,
                          autofocus: true,
                          decoration: const InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            labelText: 'Resposta',
                            labelStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                            hintStyle: TextStyle(color: Colors.white),
                            focusColor: Colors.red,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white, width: 2.0),
                            ),
                          ),
                          style: const TextStyle(
                              color: Colors.white, decoration: TextDecoration.none),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: appBarHeight * 0.26),
                        child: AppButton(
                            onPressed: () {
                              gc.sendAnswer(myController.text);
                              // TODO: Remove snack bar and transition to waiting page
                              final snackBar = SnackBar(
                                  content: const Text('Voto enviado, aguarde os outros votarem.'));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            },
                            text: 'Enviar'),
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
