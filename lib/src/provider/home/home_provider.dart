import 'package:flutter/widgets.dart';
import 'package:pokeapi/src/service/service.dart';

class HomeProvider with ChangeNotifier {
  final List _pokemons = [];
  final int limit = 20;
  int offset = 0;

  HomeProvider() {
    fillListPokemons();
  }

  fillListPokemons() async {
    final data = await Service().getData('?limit=$limit&offset=$offset');
    _pokemons.addAll(data.data['results']);
    notifyListeners();
  }

  addNewData() async {
    offset = offset + 20;
    fillListPokemons();
  }

  List get pokemons => _pokemons;
}
