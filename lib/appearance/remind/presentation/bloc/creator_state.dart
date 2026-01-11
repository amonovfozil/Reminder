part of 'creator_bloc.dart';

class CreatorState {
  RemindModel remind;
  CreatorState({required this.remind});
}

class InitialCreatorState extends CreatorState {
  InitialCreatorState({required super.remind});
}

class LoadingCreatorState extends CreatorState {
  LoadingCreatorState({required super.remind});
}
