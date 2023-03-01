


import 'package:pokemon_ddd/domain/datasources/pokemon_datasource.dart';
import 'package:pokemon_ddd/domain/entities/pokemon.dart';
import 'package:pokemon_ddd/domain/repositores/pokemon_repository.dart';

class PokemonRepositoryImpl extends PokemonRepository {
  
  final PokemonDatasource datasource;

  PokemonRepositoryImpl(this.datasource);


  @override
  Future<List<Pokemon>> getPokemonsByPage({int page = 0, int offset = 0}) {
    return datasource.getPokemonsByPage( page: page, offset: offset );
  }

}