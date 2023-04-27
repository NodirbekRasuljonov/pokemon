import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pokemon/hive/hive_pokemon/hive_pokemon_model.dart';
import 'package:pokemon/hive/hive_pokemon_info/hive_pokemon_info.dart';
import 'package:pokemon/home/state/home_page_state.dart';
import 'package:pokemon/model/pokemon_info_model.dart';
import 'package:pokemon/model/pokemon_model.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomeInitialPageState());

  Box box = Hive.box("hive");
  Future<PokemonModel> getPokemon({required int index}) async {
    Response pokemonRes = await Dio().get("https://pokeapi.co/api/v2/pokemon");
    box.put("offlinePokemon", HivePokemonModel.fromJson(pokemonRes.data));
    Response pokemonInfoRes =
        await Dio().get("https://pokeapi.co/api/v2/pokemon/${index += 1}/");
    List<HivePokemonInfo> info = List.generate(19, (index) {
      return HivePokemonInfo(
        id: pokemonInfoRes.data["id"].toString(),
        name: pokemonInfoRes.data["name"].toString(),
        imageUrl: pokemonInfoRes.data["sprites"]["front_default"].toString(),
        height: pokemonInfoRes.data["height"].toString(),
        weight: pokemonInfoRes.data["weight"].toString(),
        category: pokemonInfoRes.data["types"][0]["type"]["name"],
      );
    });
    box.put("offlinePokemonInfo",
      info
    );

    return PokemonModel.fromJson(pokemonRes.data);
  }

  Future<PokemonInfoModel> getInfoPokemon({required int index}) async {
    Response res =
        await Dio().get("https://pokeapi.co/api/v2/pokemon/${index += 1}/");
    return PokemonInfoModel.fromJson(res.data);
  }
}
