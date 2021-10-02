import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:have_you_heard/controller/game_controller.dart';

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
    final GameController gc = Get.find();
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              Text('Rodada ${gc.game.roundIndex+1}/3'),
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
                    Get.offNamed(VoteAnswerScreen.route);
                  },
                  child: const Text('Enviar')),
            ],
          )
      ),
    );
  }
}
