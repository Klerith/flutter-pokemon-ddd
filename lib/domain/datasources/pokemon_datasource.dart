


import 'package:pokemon_ddd/domain/entities/pokemon.dart';

abstract class PokemonDatasource {

  Future<List<Pokemon>> getPokemonsByPage({ int page = 0, int offset = 0 });


}
