import 'package:get/get.dart';
import 'package:have_you_heard/models/player.dart';

class Room {

  RxInt nUsers = 0.obs;
  // The list always has a length of 6
  List<Player> userList = <Player>[].obs;
  RxString ownerID = 'not_set'.obs;

  Room();

  void setUsers(List<dynamic> users, Player myUser) {
    nUsers.value = users.length;
    userList.clear();
    for (var index = 0; index < 6; index++) {
      Player user = Player(name:'Jogador ${index + 1}');
      if (index < nUsers.value) {
        user = Player.fromJson(users[index]);
      }
      if (myUser.id == user.id) {
        // Always show myself as the first in the list of users
        userList.insert(0, user);
      } else {
        userList.add(user);
      }
    }
  }
}
