part of 'dragonball_bloc.dart';

@immutable
sealed class DragonballState {}

final class DragonballInitial extends DragonballState {}

final class Loading extends DragonballState {}

final class Error extends DragonballState {}

final class Success extends DragonballState {
  final List<Model> list;

  Success(this.list);
}
