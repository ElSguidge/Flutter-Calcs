import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

import 'package:meta/meta.dart';

part '../velocity_of_air/vel_air_event.dart';
part '../velocity_of_air/vel_air_state.dart';

class VelBloc extends Bloc<VelocityEvent, VelocityState> {
  VelBloc() : super(VelocityDataState(answer1: 0, answer2: 0)) {
    on<InitialVelocityEvent>(
        (event, emit) => emit(VelocityDataState(answer1: 0, answer2: 0)));

    on<StandardAirEvent>((event, emit) => emit(
        VelocityDataState(answer1: sqrt(event.velocity) * 1.225, answer2: 0)));

    on<AirDensityEvent>((event, emit) => emit(VelocityDataState(
          answer2: sqrt(event.velocity) * (event.airDensity),
          answer1: sqrt(event.velocity) * 1.225,
        )));
  }
}
