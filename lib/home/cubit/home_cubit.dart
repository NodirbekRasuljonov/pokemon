import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:pokemon/home/state/home_page_state.dart';
import 'package:pokemon/model/pokemon_model.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomeInitialPageState());

  Future<PokemonModel> getPokemon() async {
    Response res = await Dio().get("https://pokeapi.co/api/v2/pokemon");

    return PokemonModel.fromJson(res.data);
  }

 
}


