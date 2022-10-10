import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'mixed_air_event.dart';
part 'mixed_air_state.dart';

class MixedAirTempBloc extends Bloc<MixedAirEvent, MixedAirState> {
  MixedAirTempBloc() : super(MixedAirDataState(answer1: 0)) {
    on<InitialMixedAirEvent>(
        (event, emit) => emit(MixedAirDataState(answer1: 0)));

    on<MixedAirCalc>((event, emit) => _calculate(event, emit));
  }
  _calculate(MixedAirCalc mixed, Emitter<MixedAirState> emit) {
    final oa = (mixed.oaPercent / 100) * mixed.oat;
    final ra = (mixed.raPercent / 100) * mixed.rat;

    emit(MixedAirDataState(answer1: oa + ra));
  }
}
