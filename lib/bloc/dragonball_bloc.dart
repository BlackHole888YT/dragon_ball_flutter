import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dragon_ball_flutter/data/model.dart';
import 'package:meta/meta.dart';

part 'dragonball_event.dart';
part 'dragonball_state.dart';

class DragonballBloc extends Bloc<DragonballEvent, DragonballState> {
  DragonballBloc() : super(DragonballInitial()) {
    on<GetDataByDragonball>((event, emit) async {
      emit(Loading());
      final dio = Dio();
      final response = await dio.get('https://dragonball-api.com/api/characters');
      final list = response.data['items'] as List;
      final listDragonball = list.map((e) => Model.fromJson(e)).toList();
      emit(Success(listDragonball));

    });
  }
}
