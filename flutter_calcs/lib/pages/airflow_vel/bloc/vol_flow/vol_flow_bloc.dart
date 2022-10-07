import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

import 'package:meta/meta.dart';

part 'vol_flow_event.dart';
part 'vol_flow_state.dart';

class VolumeBloc extends Bloc<VolumeEvent, VolumeState> {
  VolumeBloc() : super(VolumeDataState()) {
    on<InitialVolumeEvent>((event, emit) => emit(VolumeDataState(
        answer1: 0,
        answer2: 0,
        answer3: 0,
        answer4: 0,
        answer2A: 0,
        answer3A: 0,
        answer4A: 0)));

    on<AreaKnown>((event, emit) =>
        emit(VolumeDataState(answer1: (event.area * 1000) * event.velocity)));

    on<RectangleArea>((event, emit) => emit(VolumeDataState(
        answer2: ((event.width * event.height * event.velocity) / 1000),
        answer2A: (event.width * event.height) / 1000000)));

    on<RoundArea>((event, emit) => _calculateRound(event, emit));

    on<FlatArea>((event, emit) => _calculateFlat(event, emit));
  }
  _calculateRound(RoundArea round, Emitter<VolumeState> emit) {
    final divide = round.diameter / 2;
    final power = math.pow(divide, 2) * math.pi;
    emit(VolumeDataState(
        answer3: power / 1000000, answer3A: power / 1000 * round.velocity));
  }

  _calculateFlat(FlatArea flat, Emitter<VolumeState> emit) {
    final divide = flat.flatHeight / 2;
    final power = math.pow(divide, 2) * math.pi;
    final subtraction = (flat.flatWidth - flat.flatHeight) * flat.flatHeight;
    final additionForArea = (subtraction + power) / 1000000;
    emit(VolumeDataState(
        answer4: additionForArea,
        answer4A: (additionForArea * flat.velocity) * 1000));
  }
}
