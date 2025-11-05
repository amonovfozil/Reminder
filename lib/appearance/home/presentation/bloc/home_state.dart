part of 'home_bloc.dart';

class HomeState {
  final int currentIndex;
  HomeState({this.currentIndex = 0});
}

class InitialHomeState extends HomeState {
  InitialHomeState({super.currentIndex});
}

class ContuneHomeState extends HomeState {
  ContuneHomeState({super.currentIndex});
}
