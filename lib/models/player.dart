class Player {
  String name;
  String id;

  String answer = 'not_set';
  int roundWins = 0;

  Player({this.name = 'not_set', this.id = 'not_set'});

  Player.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'];
}
