import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:meta/meta.dart';

part 'air_temp_event.dart';
part 'air_temp_state.dart';

class AirTempBloc extends Bloc<AirTempEvent, AirTempState> {
  AirTempBloc() : super(AirTempDataState()) {
    on<InitialAirTempEvent>((event, emit) => emit(AirTempDataState(
          answer1: 0,
        )));

    on<Conversion>((event, emit) => _convert(event, emit));
  }
  _convert(Conversion convert, Emitter<AirTempState> emit) {
    if (convert.isCelcius == true && convert.isCelcius1 == true) {
      emit(AirTempDataState(answer1: convert.temp));
    }
    if (convert.isCelcius == true && convert.isFahrenheit1 == true) {
      final celcius = (convert.temp * 1.8) + 32;
      emit(AirTempDataState(answer2: celcius));
    }
    if (convert.isCelcius == true && convert.isR1 == true) {
      final fahrenheit = (convert.temp * 1.8) + 32;
      final r = fahrenheit + 460;
      emit(AirTempDataState(answer3: r));
    }
    if (convert.isCelcius == true && convert.isK1 == true) {
      final k = convert.temp + 273;
      emit(AirTempDataState(answer4: k));
    }
    if (convert.isFahrenheit == true && convert.isFahrenheit1 == true) {
      final f = convert.temp;
      emit(AirTempDataState(answer5: f));
    }
    if (convert.isFahrenheit == true && convert.isCelcius1 == true) {
      final celcius1 = (convert.temp - 32) / 1.8;
      emit(AirTempDataState(answer6: celcius1));
    }
    if (convert.isFahrenheit == true && convert.isR1 == true) {
      final r1 = convert.temp + 460;
      emit(AirTempDataState(answer7: r1));
    }
    if (convert.isFahrenheit == true && convert.isK1 == true) {
      final c = (convert.temp - 32) / 1.8;
      final k1 = c + 273;
      emit(AirTempDataState(answer8: k1));
    }
    if (convert.isR == true && convert.isR1 == true) {
      final rR = convert.temp;
      emit(AirTempDataState(answer9: rR));
    }
    if (convert.isR == true && convert.isCelcius1 == true) {
      final rC = (convert.temp - 491.67) * 5 / 9;
      emit(AirTempDataState(answer10: rC));
    }
    if (convert.isR == true && convert.isFahrenheit1 == true) {
      final rF = convert.temp - 459.67;
      emit(AirTempDataState(answer11: rF));
    }
    if (convert.isR == true && convert.isK1 == true) {
      final rK = convert.temp * 5 / 9;
      emit(AirTempDataState(answer12: rK));
    }
    if (convert.isK == true && convert.isK1 == true) {
      final kK = convert.temp;
      emit(AirTempDataState(answer13: kK));
    }

    if (convert.isK == true && convert.isCelcius1 == true) {
      final kC = (convert.temp - 273.15);
      emit(AirTempDataState(answer14: kC));
    }
    if (convert.isK == true && convert.isFahrenheit1 == true) {
      final kF = (convert.temp - 273.15) * 9 / 5 + 32;
      emit(AirTempDataState(answer15: kF));
    }
    if (convert.isK == true && convert.isR1 == true) {
      final rK = convert.temp * 1.8;
      emit(AirTempDataState(answer16: rK));
    }
  }
}
