import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'desc_persona.dart';

class VotePersonaScreen extends StatefulWidget {
  const VotePersonaScreen({Key? key}) : super(key: key);

  static const routeName = '/vote-persona';
  static const route = '/vote-persona';

  @override
  _VotePersonaScreenState createState() => _VotePersonaScreenState();
}

class _VotePersonaScreenState extends State<VotePersonaScreen> {
  final List<String> allPersona = [
    'Antivax',
    'Bonosaro',
    'Eron Must',
    'Lulo',
    'Salvio',
    'Tia do zap',
    'Tump',
    'Vegan',
    'Aleatório'
  ];

  Widget buildPersonaTile (String persona) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Center(child: Text(persona)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text('Votação de personagens'),
            Expanded(child:
            GridView.count(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              children: [ for (var persona in allPersona) buildPersonaTile(persona) ],
            )),
            ElevatedButton(
                onPressed: () {
                  Get.offNamed(DescPersonaScreen.route);
                },
                child: const Text('Votar')),
          ],
        ),
      ),
    );
  }
}
