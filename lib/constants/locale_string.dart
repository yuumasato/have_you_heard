import 'package:get/get.dart';

class LocalString extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'pt_BR': {
          'entrar': 'Entrar',
          'criarSala': 'Criar sala privada',
          'privateRoom': 'Sala Privada',
          'waitingPlayers': 'Aguardando jogadores...',
          'startGame': 'Iniciar jogo',
          'roundWinner': 'Vencedor da Rodada',
        },
        'es_AR': {
          'entrar': 'Entrar',
          'criarSala': 'Crear sala privada',
          'privateRoom': 'Sala Privada',
          'waitingPlayers': 'Esperando jugadores...',
          'startGame': 'Empezar juego',
          'roundWinner': 'ganador de la ronda',
        },
      };
}
