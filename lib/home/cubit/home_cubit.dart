import 'package:bloc/bloc.dart';
import 'package:pokemon/home/state/home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomeInitialPageState());


}
