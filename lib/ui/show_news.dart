import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:have_you_heard/constants/colors.dart';
import 'package:have_you_heard/controller/game_controller.dart';
import 'package:have_you_heard/widgets/chat_balloon.dart';

import 'vote_answer.dart';

class ShowNewsScreen extends StatefulWidget {
  const ShowNewsScreen({Key? key}) : super(key: key);

  static const routeName = '/show-news';
  static const route = '/show-news';

  @override
  _ShowNewsScreenState createState() => _ShowNewsScreenState();
}

class _ShowNewsScreenState extends State<ShowNewsScreen> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    final appBarHeight = AppBar().preferredSize.height;
    final GameController gc = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rodada ${gc.game.roundIndex + 1}/3',
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: kYellowButton),
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
              ),
              const Text("Escreva sua resposta")
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
            child: ChatBalloon(
              balloonHeader: const Text('Você ouviu que...'),
              balloonText: RichText(
                  text: const TextSpan(
                      text: 'Lorem ipsum dolor sit amet, consectetur _____ elit ut aliquam, purus sit amet luctus venenatis, lectus',
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
                  child: const TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
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
                    style: TextStyle(
                        color: Colors.white, decoration: TextDecoration.none),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: appBarHeight * 0.26),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        fixedSize: Size(screenWidth * 0.8,
                            AppBar().preferredSize.height * 0.08),
                      ),
                      onPressed: () {
                        Get.offNamed(VoteAnswerScreen.route);
                      },
                      child: const Text('Enviar')),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
