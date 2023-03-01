import 'package:dio/dio.dart';
import 'package:pokemon_ddd/domain/datasources/pokemon_datasource.dart';
import 'package:pokemon_ddd/domain/entities/pokemon.dart';
import 'package:pokemon_ddd/infrastructure/mappers/pokemon_mapper.dart';
import 'package:pokemon_ddd/infrastructure/models/pokeapi/pokeapi_pokemon.dart';
import 'package:pokemon_ddd/infrastructure/models/pokeapi/pokeapi_pokemons_response.dart';



class PokeapiDatasource extends PokemonDatasource {

  final dio = Dio(BaseOptions(
    baseUrl: 'https://pokeapi.co/api/v2'
  ));


  @override
  Future<List<Pokemon>> getPokemonsByPage({int page = 0, int offset = 0}) async{
    
    //? Paso 1 tomar los primeros 20 pokemons
    final response = await dio.get('/pokemon', queryParameters: {
      'limit': 50,
      'offset': offset
    });
    final pokemonsResponse = PokeApiPokemonsResponse.fromJson(response.data);

    //?  Obtener la información de cada pokemon
    final pokemonsFutures = <Future<Response>> [];

    for (final result in pokemonsResponse.results ) {
      pokemonsFutures.add( dio.get(result.url) );
    }

  
    final pokemonReponses = await Future.wait( pokemonsFutures );

    //? Retornar la data exactamente como la necesitamos
    final pokemons = <Pokemon>[];

    for (final pokeApiResponse in pokemonReponses ) {
      final pokeApiPokemon = PokeapiPokemon.fromJson(pokeApiResponse.data);
      final pokemon = PokemonMapper.pokeapiPokemonToEntity(pokeApiPokemon);
      pokemons.add( pokemon );
    }

    return pokemons;
  }



}


