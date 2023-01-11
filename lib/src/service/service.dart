import 'package:dio/dio.dart';

class Service {
  getData(String params) async {
    return await Dio().get('https://pokeapi.co/api/v2/pokemon${params}');
  }
}
