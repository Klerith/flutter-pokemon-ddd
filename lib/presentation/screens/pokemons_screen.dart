import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pokemon_ddd/domain/entities/pokemon.dart';
import 'package:pokemon_ddd/infrastructure/datasources/pokeapi_datasource.dart';
import 'package:pokemon_ddd/infrastructure/repositorios/pokemon_repository_impl.dart';

class PokemonsScreen extends StatelessWidget {
  const PokemonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _PokemonsView(),
    );
  }
}


class _PokemonsView extends StatefulWidget {
  const _PokemonsView();

  @override
  State<_PokemonsView> createState() => _PokemonsViewState();
}

class _PokemonsViewState extends State<_PokemonsView> {

  final pokemonRepository = PokemonRepositoryImpl( PokeapiDatasource() );
  bool isLoading = true;
  List<Pokemon> pokemons = [];

  @override
  void initState() {
    super.initState();
    
    loadNextPage();
  }

  void loadNextPage() async{
    setState(() {
      isLoading = true;
    });


    final newPokemons = await pokemonRepository.getPokemonsByPage();
    
    setState(() {
      pokemons.addAll(newPokemons);
      isLoading = false;
    });
  }



  @override
  Widget build(BuildContext context) {

    if ( isLoading ) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: pokemons.length,
      itemBuilder: (BuildContext context, int index) {
        final pokemon = pokemons[index];
        return ListTile(
          leading: Image.network(pokemon.frontSprite),
          trailing: Image.network(pokemon.backSprite),
          title: Text(pokemon.name),
        );
      },
    );
  }
}

