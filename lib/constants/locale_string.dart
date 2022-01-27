import 'package:get/get.dart';

class LocalString extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'pt_BR': {
          'enter': 'Entrar',
          'haveYouHeard...': 'Você ouviu que...',
          'showRound': 'Rodada @round/3',

          //onboarding
          'gameExplanation': '"Have you Heard?" É um jogo multiplayer para conscientizar sobre fake news.',
          'character': 'Personagem',
          'characterExplanation': 'Coloque-se no papel de um personagem e faça sua melhor imitação.',
          'rounds': 'Rodadas',
          'roundExplanationStart': 'Seja rápido e convincente para aumentar suas chances de ',
          'roundLinedExplanation': 'ganhar uma viagem espacial ',
          'roundExplanationEnd': ' vencer!',
          'continue': 'Continuar',

          //set_user_name
          'chooseYourName': 'Escolha seu nome no jogo',
          'nameQuestion': 'Como você quer ser chamado?',
          'insertYourName': 'Insira seu nome',

          //lobby
          'chooseGameMode': 'Escolha seu modo de jogo, @name!',
          'insertRoomCode': 'Insira o código da sala',
          'or': 'ou',
          'createRoom': 'Criar sala privada',
          'returnToGame': 'Voltar para partida',

          //room
          'privateRoom': 'Sala Privada',
          'waitingPlayers': 'Aguardando jogadores...',
          'startGame': 'Iniciar jogo',

          //vote_persona
          'characterVote': 'Votação de personagens',
          'vote': 'Votar',

          //desc_persona
          'roleExplanation': 'Coloque-se no papel de...',
          'characteristcs': 'Características\n',
          'topcs': 'Tópicos\n',

          //show_news
          'writeYourAnswer': 'Escreva sua resposta',
          'answer': 'Resposta',
          'send': 'Enviar',

          //vote-answer
          'chooseAnswer': 'Escolha a melhor resposta',

          //correct_news
          'newsLink': 'Link para a notícia real',
          'actuallySaid': 'Na verdade eu disse que...',
          'correctNews': 'Notícia correta',

          //round_winner
          'roundWinner': 'Vencedor da Rodada',

          //game_winner
          'wonRounds': 'Rodadas\nvencidas',
          'fastestPlayers': 'Jogadores mais\nrápidos',
          'winner': '\nVencedor!',
          'congratulations': 'Parabéns',
          'playAgain': 'Jogar Novamente',
          'endGame': 'Finalizar partida',
          'player': 'Jogador @number',

          //game_exit_dialog
          'exitQuestion' : 'Sair da sala?',
          'stayInTheRoom': 'Continuar na sala',
          'returnToStart' : 'Voltar para tela inicial',

          //settings
          'settings' : 'Configurações',
          'name' : 'Nome',
          'sound' : 'Som',
          'country' : 'País',
          'rules' : 'Ver regras',
          'exitGame' : 'Fechar jogo',

        },
        'es_AR': {
          'enter': 'Entrar',
          'haveYouHeard...': 'Se enteró que...',
          'showRound': 'Ronda @round/3',

          //onboarding
          'gameExplanation': '"Have you Heard?" es un juego multijugador para crear conciencia sobre las noticias falsas.',
          'character': 'Personaje',
          'characterExplanation': 'Hacerse pasar por un personaje y has tu mejor imitación',
          'rounds': 'Rondas',
          'roundExplanationStart': '¡Sea rápido y convincente para aumentar sus posibilidades de ',
          'roundLinedExplanation': 'ganar un viaje espacial ',
          'roundExplanationEnd': 'ganar!',
          'continue': 'Continuar',

          //set_user_name
          'chooseYourName': 'Elige tu nombre en el juego',
          'nameQuestion': '¿Cómo quieres que te llamen?',
          'insertYourName': 'Introduzca su nombre',

          //lobby
          'chooseGameMode':'Elige tu modo de juego, @name!',
          'insertRoomCode': 'Inserta el código del juego aquí',
          'or': 'o',
          'createRoom': 'Crear sala privada',
          'returnToGame': 'Volver al juego',

          //room
          'privateRoom': 'Sala Privada',
          'waitingPlayers': 'Esperando jugadores...',
          'startGame': 'Empezar juego',

          //vote_persona
          'characterVote': 'voto de carácter', //TODO: Verificar tradução
          'vote': 'Votar',

          //desc_persona
          'roleExplanation': 'Ponerse en el lugar de...',
          'characteristcs': 'Caracteristicas\n',
          'topics': 'Temas\n',

          //show_news
          'writeYourAnswer':'Escribe tu respuesta',
          'answer': 'Respuesta',
          'send': 'Enviar',

          //vote_answer
          'chooseAnswer': 'Elige la mejor respuesta',

          //correct_news
          'newsLink': 'Enlace a noticias reales',
          'correctNews': 'Noticias correctas',
          'actuallySaid': 'En verdade, dije que ...',

          //round_winner
          'roundWinner': 'ganador de la ronda',

          //game_winner
          'wonRounds': 'Rondas\nganadas', //TODO: Verificar tradução
          'fastestPlayers': 'Jugadores más\nrápidos',
          'winner': '\nGanador!', //TODO: Verificar tradução
          'congratulations': 'Felicidades',
          'playAgain': 'Juega de nuevo',
          'endGame': 'Partido final',
          'player': 'Jugador @number',

          //game_exit_dialog
          'exitQuestion' : '¿Dejar la sala?', //TODO: Verificar tradução
          'stayInTheRoom': '¿Continuar en la sala?', //TODO: Verificar tradução
          'returnToStart' : 'Volver a la pantalla de inicio', //TODO: Verificar tradução

          //settings
          'settings' : 'Configuraciones',
          'name' : 'Nombre',
          'sound' : 'Sonar', //TODO: Verificar tradução
          'country' : 'País',
          'rules' : 'Ver reglas', //TODO: Verificar tradução
          'exitGame' : 'Cerrar Juego', //TODO: Verificar tradução

        },
      };
}
