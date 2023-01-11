import 'package:flutter/widgets.dart';
import 'package:pokeapi/src/service/service.dart';

class DetailProvider with ChangeNotifier {
  late dynamic _pokemon;
  final String name;
  String _abilities = '';
  String _moves = '';
  int _weight = 0;
  DetailProvider({required this.name}) {
    getPokemon();
  }

  getPokemon() async {
    final data = await Service().getData('/$name');
    _pokemon = data.data;
    _weight = _pokemon['weight'];
    _setAbilities(_pokemon['abilities']);
    _setMoves(_pokemon['moves']);
  }

  _setAbilities(List abilities) {
    abilities.asMap().forEach((i, element) {
      _abilities += '${element['ability']['name']}, ';
    });
    notifyListeners();
  }

  _setMoves(List moves) {
    moves.asMap().forEach((i, element) {
      _moves += '${element['move']['name']}, ';
    });
    notifyListeners();
  }

  String get abilities => _abilities;
  String get moves => _moves;
  int get weight => _weight;
}
