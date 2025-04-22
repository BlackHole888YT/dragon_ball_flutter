import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dragon_ball_flutter/data/model.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'dragonball_event.dart';
part 'dragonball_state.dart';

class DragonballBloc extends Bloc<DragonballEvent, DragonballState> {
  DragonballBloc() : super(DragonballInitial()) {
    on<GetDataByDragonball>((event, emit) async {
      emit(Loading());
      try {
        final dio = Dio();
        final response = await dio.get('https://dragonball-api.com/api/characters');

        final list = response.data['items'] as List;
        final listDragonball = list.map((e) => Model.fromJson(e)).toList();
        
        // Convert to JSON string and save to Hive
        final jsonString = jsonEncode(listDragonball.map((e) => e.toJson()).toList());
        final box = Hive.box('dragonball');
        await box.put('characters', jsonString);

        emit(Success(listDragonball));
      } catch (e) {
        emit(Error());
      }
    });

    on<GetDataFromLocal>((event, emit) async {
      try {
        final box = Hive.box('dragonball');
        final jsonString = box.get('characters') as String?;
        
        if (jsonString == null) {
          emit(Error());
          return;
        }
        
        final List<dynamic> jsonList = jsonDecode(jsonString);
        final listDragonball = jsonList.map((e) => Model.fromJson(e)).toList();
        emit(Success(listDragonball));
      } catch (e) {
        emit(Error());
      }
    });
  }
}
