import 'dart:ui';

import 'package:dragon_ball_flutter/bloc/dragonball_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = DragonballBloc()..add(GetDataByDragonball());
    return SafeArea(
        child: Scaffold(
          body: BlocBuilder<DragonballBloc, DragonballState>(
            bloc: bloc,
          builder: (context, state) {
            if (state is Success){
              final list = state.list;
              return Expanded(child: ListView.builder(itemBuilder: (context, index){
                return Column(children: [
                  Image.network(list[index].image, height: 400, width: 400,),
                  Text(list[index].name, style: TextStyle(fontSize: 30),),
                  Text('ki: ${list[index].ki} / ${list[index].maxKi}', style: TextStyle(color: Colors.red),),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(list[index].description, maxLines: 10, textAlign: TextAlign.center,),
                  ),
                  Text(list[index].affiliation, style: TextStyle(color: Colors.red)),
                  SizedBox(height: 50,),
                ],);
              },
              itemCount: list.length,
              ));
            } else {
              return const Center(child: CircularProgressIndicator(),);
            }
          },
        ),
      )
    );
  }
}
