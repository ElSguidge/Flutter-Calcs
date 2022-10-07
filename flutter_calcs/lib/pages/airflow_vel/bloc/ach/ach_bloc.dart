import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'ach_event.dart';
part 'ach_state.dart';

class AchBloc extends Bloc<AchEvent, AchState> {
  AchBloc() : super(AchDataState()) {
    on<InitialAchEvent>(
        (event, emit) => emit(AchDataState(answer1: 0, answer2: 0)));
    on<VolumeKnown>((event, emit) =>
        emit(AchDataState(answer1: (3.6 * event.airflow) / event.roomVolume)));
    on<CalculateVolume>((event, emit) => emit(AchDataState(
        answer2: (3.6 * event.airflow) /
            (event.length * event.width * event.height))));
  }
}
