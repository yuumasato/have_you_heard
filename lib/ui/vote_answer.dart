import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:have_you_heard/constants/colors.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'round_winner.dart';

class VoteAnswerScreen extends StatefulWidget {
  const VoteAnswerScreen({Key? key}) : super(key: key);

  static const routeName = '/input-answer';
  static const route = '/input-answer';

  @override
  _VoteAnswerScreenState createState() => _VoteAnswerScreenState();
}

class _VoteAnswerScreenState extends State<VoteAnswerScreen> {
  String votedAnswer = 'No voted answer';
  final List<String> allAnswers = [
    'Resposta 1',
    'Resposta 2',
    'Resposta 3',
    'Resposta 4',
    'Resposta 5',
    'Resposta 6',
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final appBarHeight = AppBar().preferredSize.height;

    return Scaffold(
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
                  backgroundColor: kBackgroundDarkGray,
                ),
                const Text('Escolha a melhor resposta'),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.1,
              ),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  //TODO: Adicionar imagem de balão
                  image: Svg("assets/images/full_landscape.svg",
                      size: Size(300, 150)),
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                ),
              ),
              child: SizedBox(
                width: screenWidth * 0.8,
                height: screenWidth * 0.4,
                child: const Center(
                  child: Text(
                      'Lorem ipsum dolor sit amet, consectetur _____ elit ut aliquam, purus sit amet luctus venenatis, lectus'),
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
                  for (var answer in allAnswers) buildAnswerButton(answer),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildAnswerButton(String resposta) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: AppBar().preferredSize.height * 0.08),
      child: SizedBox(
        height: AppBar().preferredSize.height * 0.8,
        child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  width: 2.0,
                  color: kBackgroundDarkerGray,
                  style: BorderStyle.solid,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            onPressed: () {
              votedAnswer = resposta;
              sendVote();
            },
            child: Align(
              child: Text(
                resposta,
                //TODO: Adicionar fonte Nunito
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              alignment: Alignment.centerLeft,
            )),
      ),
    );
  }

  void sendVote() {
    // Socket send vote
    Get.offNamed(RoundWinnerScreen.routeName);
  }
}
