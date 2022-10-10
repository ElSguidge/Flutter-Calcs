part of 'mixed_air_bloc.dart';

@immutable
abstract class MixedAirEvent {}

class InitialMixedAirEvent extends MixedAirEvent {}

// ignore: must_be_immutable
class MixedAirCalc extends MixedAirEvent {
  double rat;
  double oat;
  double raPercent;
  double oaPercent;
  MixedAirCalc(
      {required this.rat,
      required this.oat,
      required this.oaPercent,
      required this.raPercent});
}
