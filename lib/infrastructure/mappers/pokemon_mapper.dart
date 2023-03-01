import 'package:pokemon_ddd/domain/entities/pokemon.dart';
import 'package:pokemon_ddd/infrastructure/models/pokeapi/pokeapi_pokemon.dart';




class PokemonMapper {

  static Pokemon pokeapiPokemonToEntity( PokeapiPokemon pokeapiPokemon ) {

    final List<String> otherSprites = [
      if ( pokeapiPokemon.sprites.other?.home.frontDefault != null ) 
        pokeapiPokemon.sprites.other!.home.frontDefault,

      if ( pokeapiPokemon.sprites.other?.home.frontShiny != null ) 
        pokeapiPokemon.sprites.other!.home.frontShiny,

      if ( pokeapiPokemon.sprites.other?.officialArtwork.frontShiny != null ) 
        pokeapiPokemon.sprites.other!.officialArtwork.frontShiny,

      if ( pokeapiPokemon.sprites.other?.officialArtwork.frontDefault != null ) 
        pokeapiPokemon.sprites.other!.officialArtwork.frontDefault,

    ];



    return Pokemon(
      id: pokeapiPokemon.id, 
      name: pokeapiPokemon.name, 
      frontSprite: pokeapiPokemon.sprites.frontDefault, 
      backSprite: pokeapiPokemon.sprites.backDefault, 
      otherSprites: otherSprites
    );

  }



}
