import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'total_p_event.dart';
part 'total_p_state.dart';

class TotalPressureBloc
    extends Bloc<TotalPressureEvent, TotalPressureCalcState> {
  TotalPressureBloc() : super(TotalPressureDataState(answer: 0)) {
    on<InitialTotalPressureEvent>(
        (event, emit) => emit(TotalPressureDataState(answer: 0)));
    on<AddPressureEvent>((event, emit) => emit(TotalPressureDataState(
        answer: (event.velocityPressure) + (event.staticPressure))));
  }
}
