import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dragon_ball_flutter/data/model.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      String json = jsonEncode(listDragonball.map((e) => e.toJson()).toList());
      await saveJson(json);

      emit(Success(listDragonball));
    });

    on<GetDataFromLocal>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final json = prefs.get('db') as String;
      List<dynamic> list = jsonDecode(json);

      final listDb = list.map((e) => Model.fromJson(e)).toList();
      emit(Success(listDb));
    });
  }
  Future <void> saveJson(String json) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('db', json);

    print('\n\nData from pref:\n ${prefs.get('db')}\n\n');
  }
}
