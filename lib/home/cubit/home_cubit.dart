import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
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
        await Dio().get("https://pokeapi.co/api/v2/pokemon/$index/");
    box.put(
      "offlinePokemonInfo",
      List.generate(
        20,
        (e) => HivePokemonInfo(
          id: pokemonInfoRes.data["id"].toString(),
          name: pokemonInfoRes.data["name"].toString(),
          imageUrl: pokemonInfoRes.data["sprites"]["front_default"].toString(),
          height: pokemonInfoRes.data["height"].toString(),
          weight: pokemonInfoRes.data["weight"].toString(),
          category: pokemonInfoRes.data["types"][0]["type"]["name"],
        )
      ),
    );
    // List<HivePokemonInfo> ajdsh = box.get("offlinePokemonInfo");
    debugPrint(box.get("offlinePokemonInfo").length.toString());
    return PokemonModel.fromJson(pokemonRes.data);
  }

  Future<PokemonInfoModel> getInfoPokemon({required int index}) async {
    Response res = await Dio().get("https://pokeapi.co/api/v2/pokemon/$index/");
    // box.put(
    //     "offlinePokemonInfo",
    //     HivePokemonInfo(
    //             id: res.data["id"].toString(),
    //             name: res.data["name"].toString(),
    //             imageUrl: res.data["sprites"]["front_default"].toString(),
    //             height: res.data["height"].toString(),
    //             weight: res.data["weight"].toString(),
    //             category: res.data["types"][0]["type"]["name"])
    //         .toString());
    // print(box.get("offlinePokemonInfo"));
    return PokemonInfoModel.fromJson(res.data);
  }
}
