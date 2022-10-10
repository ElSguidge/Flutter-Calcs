part of 'air_temp_bloc.dart';

@immutable
abstract class AirTempEvent {}

class InitialAirTempEvent extends AirTempEvent {}

// ignore: must_be_immutable
class Conversion extends AirTempEvent {
  bool? isCelcius;
  bool? isCelcius1;
  bool? isFahrenheit;
  bool? isFahrenheit1;
  bool? isR;
  bool? isR1;
  bool? isK;
  bool? isK1;
  double temp;

  Conversion(
      {this.isCelcius,
      this.isCelcius1,
      this.isFahrenheit,
      this.isFahrenheit1,
      this.isR,
      this.isR1,
      this.isK,
      this.isK1,
      required this.temp});
}
