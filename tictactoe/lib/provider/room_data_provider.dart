import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/models/player.dart';

class RoomDataProvider extends ChangeNotifier {
  Map<String, dynamic> _roomData = {};
  List<String> _displayElements = ['', '', '', '', '', '', '', '', ''];
  int _filledBoxes = 0;
  Player _player1 =
      Player(nickname: '', socketID: '', points: 0, playerType: 'X');

  Player _player2 =
      Player(nickname: '', socketID: '', points: 0, playerType: 'O');
  Map<String, dynamic> get roomdata => _roomData;
  Player get player1 => _player1;

  Player get player2 => _player2;
  int get filledbox => _filledBoxes;
  List<String> get displayElements => _displayElements;

  void updateroomdata(Map<String, dynamic> data) {
    _roomData = data;
    notifyListeners();
  }

  void updateplayer1(Map<String, dynamic> player1Data) {
    _player1 = Player.fromMap(player1Data);
    notifyListeners();
  }

  void updateplayer2(Map<String, dynamic> player2Data) {
    _player2 = Player.fromMap(player2Data);
    notifyListeners();
  }

  void updateDisplayElements(int index, String choice) {
    _displayElements[index] = choice;
    _filledBoxes += 1;
    notifyListeners();
  }

  void setFilledBoxesTo() {
    _filledBoxes = 0;
  }
}
