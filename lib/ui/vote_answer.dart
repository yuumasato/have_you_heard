import 'package:flutter/material.dart';
import 'round_winner.dart';

class VoteAnswerScreen extends StatefulWidget {
  const VoteAnswerScreen({Key? key}) : super(key: key);

  static const routeName = '/input-answer';

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

  Widget buildAnswerButton(String resposta) {
    return OutlinedButton(
        onPressed: () {
          votedAnswer = resposta;
          sendVote();
        },
        child: Text(resposta)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text('Escolha a melhor resposta'),
            const Text('Lorem ipsum dolor sit amet, consectetur _____ elit ut aliquam, purus sit amet luctus venenatis, lectus'),
            for ( var answer in allAnswers) buildAnswerButton(answer),
          ],
        ),
      ),
    );
  }
  void sendVote() {
    // Socket send vote
    Navigator.pushReplacementNamed(context, RoundWinnerScreen.routeName);
  }
}
