import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

import 'package:meta/meta.dart';

part 'area_event.dart';
part 'area_state.dart';

class AreaBloc extends Bloc<AreaEvent, AreaState> {
  AreaBloc() : super(AreaDataState()) {
    on<InitialAreaEvent>((event, emit) => emit(AreaDataState(
          answer1: 0,
          answer2: 0,
          answer3: 0,
        )));

    on<RectangleArea>((event, emit) => emit(AreaDataState(
          answer1: (event.width * event.height) / 1000000,
        )));

    on<RoundArea>((event, emit) => _calculateRound(event, emit));

    on<FlatArea>((event, emit) => _calculateFlat(event, emit));
  }
  _calculateRound(RoundArea round, Emitter<AreaState> emit) {
    final divide = round.diameter / 2;
    final power = math.pow(divide, 2) * math.pi;
    emit(AreaDataState(answer2: power / 1000000));
  }

  _calculateFlat(FlatArea flat, Emitter<AreaState> emit) {
    final divide = flat.flatHeight / 2;
    final power = math.pow(divide, 2) * math.pi;
    final subtraction = (flat.flatWidth - flat.flatHeight) * flat.flatHeight;
    final additionForArea = (subtraction + power) / 1000000;
    emit(AreaDataState(
      answer3: additionForArea,
    ));
  }
}
