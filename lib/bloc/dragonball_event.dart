part of 'dragonball_bloc.dart';

@immutable
sealed class DragonballEvent {}

class GetDataByDragonball extends DragonballEvent {}

class GetDataFromLocal extends DragonballEvent {}