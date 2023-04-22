import 'package:pokemon/home/view/home_page.dart';

abstract class HomePageState {
  HomePageState();
}

class HomeInitialPageState extends HomePageState {
  HomeInitialPageState();
}

class HomeLoadingPageState extends HomePageState {
  HomeLoadingPageState();
}

class HomeErrorState extends HomePageState {
  HomeErrorState();
}
