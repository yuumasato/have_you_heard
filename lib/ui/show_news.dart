import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../game_state.dart';
import 'vote_answer.dart';

class ShowNewsScreen extends StatefulWidget {
  const ShowNewsScreen({Key? key}) : super(key: key);

  static const routeName = '/question';

  @override
  _ShowNewsScreenState createState() => _ShowNewsScreenState();
}

class _ShowNewsScreenState extends State<ShowNewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<GameState> (
            builder: (context, gameState, child){
              return Column(
                children: [
                  Text('Rodada ${gameState.roundIndex+1}/3'),
                  const Text('Você ouviu que...'),
                  const Text('Lorem ipsum dolor sit amet, consectetur _____ elit ut aliquam, purus sit amet luctus venenatis, lectus'),
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      width: 200.0,
                      height: 38.0,
                      child: const TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Resposta',
                          ))
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, VoteAnswerScreen.routeName);
                      },
                      child: const Text('Enviar')),
                ],
              );
            }),
      ),
    );
  }
}
